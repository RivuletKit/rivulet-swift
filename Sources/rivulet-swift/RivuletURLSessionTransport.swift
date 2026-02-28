import Foundation
import RivuletProtos

public struct RivuletURLSessionTransport: RivuletTransport {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func send(request: RivuletRequest) async throws -> RivuletResponse {
        let payload = request.instance

        if payload.hasProxy {
            throw RivuletError.unsupportedFeature("proxy")
        }

        if payload.hasCertificate {
            throw RivuletError.unsupportedFeature("certificate")
        }

        var urlRequest = try buildURLRequest(from: payload)
        if payload.hasAuth {
            try applyAuth(payload.auth, to: &urlRequest)
        }

        let startedAt = Date()
        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await loadData(for: urlRequest)
        } catch {
            throw error
        }

        let elapsed = Int32(max(0, Int(Date().timeIntervalSince(startedAt) * 1000.0)))
        let mapped = mapResponse(
            originalRequest: payload,
            response: response,
            data: data,
            elapsedMs: elapsed
        )
        return request.makeResponse(instance: mapped)
    }

    private func buildURLRequest(from request: _RivuletRequest) throws -> URLRequest {
        guard let url = buildURL(from: request.url) else {
            throw URLError(.badURL)
        }

        var built = URLRequest(url: url)
        let method = request.hasMethod ? request.method.trimmingCharacters(in: .whitespacesAndNewlines) : ""
        built.httpMethod = method.isEmpty ? "GET" : method

        for header in request.headers where !(header.hasDisabled && header.disabled) {
            built.addValue(header.value, forHTTPHeaderField: header.key)
        }

        if request.hasBody, !(request.body.hasDisabled && request.body.disabled) {
            let body = try encodeBody(request.body, for: &built)
            built.httpBody = body
        }

        return built
    }

    private func buildURL(from data: Com_Rivuletkit_Common_Collection_URL) -> URL? {
        if data.hasRaw, !data.raw.isEmpty {
            return URL(string: data.raw)
        }

        var components = URLComponents()
        components.scheme = data.protocol
        components.host = data.host
        components.path = data.path

        if data.hasPort {
            components.port = Int(data.port)
        } else {
            switch data.protocol.lowercased() {
            case "http":
                components.port = 80
            case "https":
                components.port = 443
            default:
                break
            }
        }

        if !data.querys.isEmpty {
            components.queryItems = data.querys.compactMap { item in
                if item.hasDisabled, item.disabled {
                    return nil
                }
                return URLQueryItem(name: item.key, value: item.value)
            }
        }

        if data.hasHash, !data.hash.isEmpty {
            components.fragment = data.hash
        }

        return components.url
    }

    private func encodeBody(_ body: Com_Rivuletkit_Common_Collection_Body, for request: inout URLRequest) throws -> Data? {
        switch body.mode {
        case .raw:
            if body.hasRaw {
                return body.raw.data(using: .utf8)
            }
            return nil
        case .urlencoded:
            let values = body.urlencoded.filter { !($0.hasDisabled && $0.disabled) }
            if values.isEmpty {
                return nil
            }

            if request.value(forHTTPHeaderField: "Content-Type") == nil {
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            }

            let encoded = values.map { item in
                let key = percentEncode(item.key)
                let value = percentEncode(item.value)
                return "\(key)=\(value)"
            }.joined(separator: "&")
            return encoded.data(using: .utf8)
        case .formdata:
            let values = body.formdata.filter { !($0.hasDisabled && $0.disabled) }
            if values.isEmpty {
                return nil
            }

            let boundary = "RivuletBoundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            var data = Data()
            for item in values {
                data.append("--\(boundary)\r\n".data(using: .utf8)!)
                data.append("Content-Disposition: form-data; name=\"\(item.key)\"\r\n".data(using: .utf8)!)
                if item.hasContentType, !item.contentType.isEmpty {
                    data.append("Content-Type: \(item.contentType)\r\n".data(using: .utf8)!)
                }
                data.append("\r\n".data(using: .utf8)!)
                data.append(item.value.data(using: .utf8) ?? Data())
                data.append("\r\n".data(using: .utf8)!)
            }
            data.append("--\(boundary)--\r\n".data(using: .utf8)!)
            return data
        case .file:
            guard body.hasFile else {
                return nil
            }

            if body.file.hasRaw {
                return body.file.raw
            }

            if body.file.hasContent {
                return body.file.content.data(using: .utf8)
            }

            if body.file.hasSrc {
                return try Data(contentsOf: URL(fileURLWithPath: body.file.src))
            }

            return nil
        case .graphql:
            throw RivuletError.unsupportedFeature("body.graphql")
        case let .UNRECOGNIZED(rawValue):
            throw RivuletError.unsupportedFeature("body.mode.\(rawValue)")
        }
    }

    private func applyAuth(_ auth: Com_Rivuletkit_Common_Collection_Auth, to request: inout URLRequest) throws {
        let kind = auth.type.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if kind.isEmpty || kind == "noauth" {
            return
        }

        switch kind {
        case "basic":
            try applyBasicAuth(auth.basic, to: &request)
        case "bearer":
            try applyBearerAuth(auth.bearer, to: &request)
        case "apikey":
            try applyAPIKeyAuth(auth.apikey, to: &request)
        default:
            throw RivuletError.unsupportedAuth(kind)
        }
    }

    private func applyBasicAuth(_ items: [Com_Rivuletkit_Common_Collection_AuthItem], to request: inout URLRequest) throws {
        let mapped = authItemsToMap(items)
        guard let username = mapped["username"], let password = mapped["password"] else {
            throw RivuletError.invalidAuth("basic")
        }

        let credentials = "\(username):\(password)"
        guard let token = credentials.data(using: .utf8)?.base64EncodedString() else {
            throw RivuletError.invalidAuth("basic")
        }

        request.setValue("Basic \(token)", forHTTPHeaderField: "Authorization")
    }

    private func applyBearerAuth(_ items: [Com_Rivuletkit_Common_Collection_AuthItem], to request: inout URLRequest) throws {
        let mapped = authItemsToMap(items)
        let token = mapped["token"] ?? items.first?.value
        guard let token, !token.isEmpty else {
            throw RivuletError.invalidAuth("bearer")
        }

        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }

    private func applyAPIKeyAuth(_ items: [Com_Rivuletkit_Common_Collection_AuthItem], to request: inout URLRequest) throws {
        let mapped = authItemsToMap(items)
        guard let key = mapped["key"], !key.isEmpty,
              let value = mapped["value"], !value.isEmpty
        else {
            throw RivuletError.invalidAuth("apikey")
        }

        let location = (mapped["in"] ?? "header").lowercased()
        switch location {
        case "header":
            request.setValue(value, forHTTPHeaderField: key)
        case "query":
            guard let url = request.url, var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                throw RivuletError.invalidAuth("apikey")
            }
            var queryItems = components.queryItems ?? []
            queryItems.append(URLQueryItem(name: key, value: value))
            components.queryItems = queryItems
            guard let updatedURL = components.url else {
                throw RivuletError.invalidAuth("apikey")
            }
            request.url = updatedURL
        default:
            throw RivuletError.invalidAuth("apikey")
        }
    }

    private func authItemsToMap(_ items: [Com_Rivuletkit_Common_Collection_AuthItem]) -> [String: String] {
        var mapped: [String: String] = [:]
        for item in items {
            mapped[item.key.lowercased()] = item.value
        }
        return mapped
    }

    private func percentEncode(_ value: String) -> String {
        let allowed = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        return value.addingPercentEncoding(withAllowedCharacters: allowed) ?? value
    }

    private func loadData(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            let task = session.dataTask(with: request) { data, response, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let data, let response else {
                    continuation.resume(throwing: URLError(.badServerResponse))
                    return
                }

                continuation.resume(returning: (data, response))
            }
            task.resume()
        }
    }

    private func mapResponse(
        originalRequest: _RivuletRequest,
        response: URLResponse,
        data: Data,
        elapsedMs: Int32
    ) -> _RivuletResponse {
        var mapped = _RivuletResponse()
        mapped.originalRequest = originalRequest
        mapped.responseTime = elapsedMs
        mapped.bodyRaw = data

        if let text = String(data: data, encoding: .utf8) {
            mapped.body = text
        }

        if let http = response as? HTTPURLResponse {
            mapped.code = Int32(http.statusCode)
            mapped.status = "\(http.statusCode) \(HTTPURLResponse.localizedString(forStatusCode: http.statusCode).capitalized)"

            var headers: [_RivuletHeader] = []
            var headerMap: [String: String] = [:]
            for (k, v) in http.allHeaderFields {
                guard let key = k as? String else {
                    continue
                }
                let value = "\(v)"
                var header = _RivuletHeader()
                header.key = key
                header.value = value
                headers.append(header)
                headerMap[key] = value
            }
            mapped.headers = headers

            if let url = response.url {
                let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerMap, for: url)
                mapped.cookies = cookies.map { cookie in
                    var item = Com_Rivuletkit_Common_Collection_Cookie()
                    item.domain = cookie.domain
                    item.path = cookie.path
                    item.name = cookie.name
                    item.value = cookie.value
                    item.secure = cookie.isSecure
                    item.session = cookie.isSessionOnly
                    return item
                }
            }
        }

        return mapped
    }
}

private typealias _RivuletHeader = Com_Rivuletkit_Common_Collection_Header
