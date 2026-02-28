# Rivulet SDK Behavior Specification (v1)

## 1. Scope

This document defines the deterministic runtime behavior for SDK implementations that consume the Rivulet `Request` schema and produce the Rivulet `Response` schema.

Version: `v1`

Goals:

- Same input JSON/protobuf request produces equivalent behavior across SDK languages.
- SDK returns a normalized `Response` or an explicit SDK error.
- Unsupported features fail explicitly and predictably.

## 2. Request Input Rules

## 2.1 URL Resolution

1. If `request.url.raw` is present and non-empty, SDK must parse and use it as the request URL source.
2. If `request.url.raw` is absent/empty, SDK must compose URL from split fields:
   - `protocol` + `host` + `path` + optional `port` + optional `querys`
3. When `querys` items are present, items with `disabled = true` are excluded.
4. If URL cannot be resolved into a valid runtime URL, SDK must return `invalid_url`.

## 2.2 HTTP Method

- If `request.method` is missing or empty, default method is `GET`.
- Method value should be used as provided after trimming leading/trailing whitespace.

## 2.3 Default Port Inference

- If `port` is explicitly provided, use it.
- If `port` is absent:
  - `http` -> `80`
  - `https` -> `443`
- For other protocols, SDK may omit inferred port.

## 2.4 Headers

- Add all `headers` items except entries with `disabled = true`.
- For duplicate header keys, transport/runtime-specific merge behavior is allowed, but SDK should preserve insertion order when applying headers.

## 2.5 Body Handling

If `request.body.disabled = true`, no body is sent.

If body is enabled, mode handling is:

- `RAW`:
  - encode `body.raw` as UTF-8 bytes.
- `URLENCODED`:
  - include non-disabled `urlencoded` items.
  - encode as `application/x-www-form-urlencoded` payload.
- `FORMDATA`:
  - include non-disabled `formdata` items.
  - encode as multipart/form-data with boundary.
- `FILE`:
  - file content source precedence: `file.raw` -> `file.content` -> `file.src`.
  - `file.src` is read from local filesystem path.
- `GRAPHQL`:
  - not supported in v1, return `unsupported_body_mode`.

If body mode content is malformed or file source is unreadable, return `invalid_body`.

## 2.6 Auth Handling

Supported in v1:

- `noauth`
- `basic`
- `bearer`
- `apikey`

Unsupported in v1:

- `awsv4`, `digest`, `edgegrid`, `hawk`, `ntlm`, `oauth1`, `oauth2`

Behavior:

- Unsupported auth type must return `unsupported_auth`.
- Missing required auth fields should return `invalid_auth`.

## 2.7 Proxy and Certificate

- `proxy` is not supported in v1: return `unsupported_feature` (context: `proxy`).
- `certificate` is not supported in v1: return `unsupported_feature` (context: `certificate`).

## 3. Response Mapping Rules

SDK must map transport response into `Response`:

- `original_request`: set to the effective request used for execution.
- `response_time`: elapsed execution time in milliseconds.
- `headers`: mapped from runtime response headers.
- `cookies`: mapped when runtime exposes cookie metadata.
- `code`: numeric HTTP status code.
- `status`: status text if available from runtime; otherwise stable fallback string from code.
- `body_raw`: raw response bytes.
- `body`: UTF-8 string representation when bytes decode successfully; otherwise empty/omitted.

For successful transport completion, SDK must return a `Response` object (not `nil`).

## 4. Error Taxonomy (v1)

SDK implementations should expose domain errors with one of the following codes:

- `invalid_url`: URL parse/build failed.
- `invalid_method`: method is syntactically invalid for runtime.
- `invalid_headers`: headers could not be encoded/applied.
- `invalid_body`: body build/encoding/file read failed.
- `invalid_auth`: auth type supported but data invalid/incomplete.
- `unsupported_auth`: auth type not supported in v1.
- `unsupported_body_mode`: body mode not supported in v1.
- `unsupported_feature`: feature not in v1 scope (`proxy`, `certificate`, others).
- `network_error`: transport-level failure.
- `timeout`: request timeout failure.
- `decode_error`: response decode/mapping failure.

Error object should include:

- `code` (from list above)
- `message` (human-readable)
- `field` (optional schema path)
- `cause` (optional runtime/native error)

## 5. Support Matrix (v1)

- URL: `raw`, split URL fields, query filtering by `disabled`.
- Method: supported with `GET` default.
- Headers: supported with `disabled` filtering.
- Body:
  - `RAW`: supported
  - `URLENCODED`: supported
  - `FORMDATA`: supported
  - `FILE`: supported
  - `GRAPHQL`: unsupported
- Auth:
  - `noauth`: supported
  - `basic`: supported
  - `bearer`: supported
  - `apikey`: supported
  - others: unsupported
- Proxy: unsupported
- Certificate: unsupported

## 6. Conformance Requirements

To claim v1 conformance, an SDK must:

1. Implement all supported features in this document.
2. Return explicit errors for unsupported features.
3. Pass fixture-based conformance tests for success and failure cases.
