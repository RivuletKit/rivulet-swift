# Changelog

## Unreleased

### Added

- Added v1 behavior specification in `SPEC.md`.
- Added staged implementation roadmap in `IMPLEMENTATION_PLAN.md`.
- Added async-first client API (`RivuletClient`, `RivuletTransport`, `RivuletRequestProcessor`).
- Added auth handling coverage for `noauth`, `basic`, `bearer`, and `apikey` in `RivuletUseWKWebViewReply`.
- Added fixture-based async test coverage for success and failure paths.
- Added test resource bundle support for fixtures.

### Changed

- Promoted core SDK types to public surface and introduced Swift-style APIs (`reply`, `handler`).
- Kept legacy APIs with deprecation markers for migration compatibility.
- Made `RivuletUseWKWebViewReply` publicly constructible as an optional transport plugin.
- Expanded README with quick start, transport guidance, migration notes, and error catalog.

### Fixed

- Standardized explicit unsupported behavior for `proxy` and `certificate` fields in v1 path.
- Added deterministic error assertions for unsupported auth and malformed file source scenarios.
