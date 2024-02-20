//
//  File.swift
//
//
//  Created by Bin on 2024/2/19.
//
import Foundation
import RivuletProtos
import WebKit

struct WKWebViewManager {
    var mWebview: WKWebView

    init() {
        mWebview = WKWebView()
    }

    @available(macOS 10.15.0, *)
    func load(request: URLRequest) async {
        await mWebview.load(request)
    }

    func load(request: URLRequest, handle _: () -> Void) {
        mWebview.load(request)
    }
}

struct RivuletUseWKWebViewReply: RivuletHandleInterface {
    func Reply(request: RivuletRequest) throws -> RivuletResponse? {
        return try Reply(request.instance)
    }

    func Reply(_ request: _RivuletRequest) throws -> RivuletResponse? {
        // 构造请求
        guard var _requestObj = toURLRequest(request.url) else {
            throw URLError(.badURL)
        }

        // 配置请求方法
        _requestObj.httpMethod = request.hasMethod ? request.method : "GET"

        // 配置请求头
        if !request.headers.isEmpty {
            request.headers.forEach { item in
                if item.hasDisabled, item.disabled {
                    return
                }
                _requestObj.addValue(item.value, forHTTPHeaderField: item.key)
            }
        }

        // 配置请求参数
        if request.hasBody {
            if !request.body.hasDisabled || !request.body.disabled {
                var data: Data? = .init()
                let body = request.body
                switch body.mode {
                case .urlencoded:
                    if !body.urlencoded.isEmpty {
                        // Urlencodeed
                        _requestObj.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                        var urlc = URLComponents()
                        urlc.queryItems = []
                        body.urlencoded.forEach { item in
                            if item.hasDisabled, item.disabled {
                                return
                            }
                            urlc.queryItems!.append(.init(name: item.key, value: item.value))
                        }
                        data = urlc.string?.data(using: .utf8)
                    }
                case .formdata:
                    // formdata
                    if !body.formdata.isEmpty {
                        // TODO: 待实现 formdata
                    }
                case .file:
                    // file
                    if body.hasFile {
                        let file = body.file
                        if file.hasRaw {
                            data = file.raw
                        } else if file.hasContent {
                            data = file.content.data(using: .utf8)
                        } else if file.hasSrc {
                            data = try Data(contentsOf: URL(fileURLWithPath: file.src))
                        }
                    }
                default:
                    if body.hasRaw {
                        data = body.raw.data(using: .utf8)
                    }
                }
                _requestObj.httpBody = data
            }
        }

        let wvm = WKWebViewManager()
        wvm.load(request: _requestObj) {}

        return nil
    }

    func toURLRequest(_ data: Com_Rivuletkit_Common_Collection_URL) -> URLRequest? {
        var uc = URLComponents()
        uc.scheme = data.protocol
        uc.host = data.host
        uc.port = Int(data.port)
        uc.path = data.path

        if !data.querys.isEmpty {
            let queryItems: [URLQueryItem] = data.querys.compactMap { item in
                if item.hasDisabled, item.disabled {
                    return nil
                }
                return URLQueryItem(name: item.key, value: item.value)
            }
            uc.queryItems = queryItems
        }

        if let url = uc.url {
            return URLRequest(url: url)
        }
        return nil
    }
}
