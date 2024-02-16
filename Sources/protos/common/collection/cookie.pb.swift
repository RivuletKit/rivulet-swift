// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: protos/common/collection/cookie.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

public struct Com_Rivuletkit_Common_Collection_Cookie {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The domain for which this cookie is valid.
  public var domain: String = String()

  /// The path associated with the Cookie.
  public var path: String = String()

  /// This is the name of the Cookie.
  public var name: String {
    get {return _name ?? String()}
    set {_name = newValue}
  }
  /// Returns true if `name` has been explicitly set.
  public var hasName: Bool {return self._name != nil}
  /// Clears the value of `name`. Subsequent reads from it will return its default value.
  public mutating func clearName() {self._name = nil}

  /// The value of the Cookie.
  public var value: String {
    get {return _value ?? String()}
    set {_value = newValue}
  }
  /// Returns true if `value` has been explicitly set.
  public var hasValue: Bool {return self._value != nil}
  /// Clears the value of `value`. Subsequent reads from it will return its default value.
  public mutating func clearValue() {self._value = nil}

  /// True if the cookie is a host-only cookie. (i.e. a request's URL domain must exactly match the domain of the cookie).
  public var hostOnly: Bool {
    get {return _hostOnly ?? false}
    set {_hostOnly = newValue}
  }
  /// Returns true if `hostOnly` has been explicitly set.
  public var hasHostOnly: Bool {return self._hostOnly != nil}
  /// Clears the value of `hostOnly`. Subsequent reads from it will return its default value.
  public mutating func clearHostOnly() {self._hostOnly = nil}

  /// Indicates if this cookie is HTTP Only. (if True, the cookie is inaccessible to client-side scripts)
  public var httpOnly: Bool {
    get {return _httpOnly ?? false}
    set {_httpOnly = newValue}
  }
  /// Returns true if `httpOnly` has been explicitly set.
  public var hasHTTPOnly: Bool {return self._httpOnly != nil}
  /// Clears the value of `httpOnly`. Subsequent reads from it will return its default value.
  public mutating func clearHTTPOnly() {self._httpOnly = nil}

  /// When the cookie expires.
  public var expires: String {
    get {return _expires ?? String()}
    set {_expires = newValue}
  }
  /// Returns true if `expires` has been explicitly set.
  public var hasExpires: Bool {return self._expires != nil}
  /// Clears the value of `expires`. Subsequent reads from it will return its default value.
  public mutating func clearExpires() {self._expires = nil}

  public var maxAge: String {
    get {return _maxAge ?? String()}
    set {_maxAge = newValue}
  }
  /// Returns true if `maxAge` has been explicitly set.
  public var hasMaxAge: Bool {return self._maxAge != nil}
  /// Clears the value of `maxAge`. Subsequent reads from it will return its default value.
  public mutating func clearMaxAge() {self._maxAge = nil}

  /// Indicates if the 'secure' flag is set on the Cookie, meaning that it is transmitted over secure connections only. (typically HTTPS)
  public var secure: Bool {
    get {return _secure ?? false}
    set {_secure = newValue}
  }
  /// Returns true if `secure` has been explicitly set.
  public var hasSecure: Bool {return self._secure != nil}
  /// Clears the value of `secure`. Subsequent reads from it will return its default value.
  public mutating func clearSecure() {self._secure = nil}

  /// True if the cookie is a session cookie.
  public var session: Bool {
    get {return _session ?? false}
    set {_session = newValue}
  }
  /// Returns true if `session` has been explicitly set.
  public var hasSession: Bool {return self._session != nil}
  /// Clears the value of `session`. Subsequent reads from it will return its default value.
  public mutating func clearSession() {self._session = nil}

  /// Custom attributes for a cookie go here, such as the [Priority Field](https://code.google.com/p/chromium/issues/detail?id=232693)
  public var extensions: [String] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _name: String? = nil
  fileprivate var _value: String? = nil
  fileprivate var _hostOnly: Bool? = nil
  fileprivate var _httpOnly: Bool? = nil
  fileprivate var _expires: String? = nil
  fileprivate var _maxAge: String? = nil
  fileprivate var _secure: Bool? = nil
  fileprivate var _session: Bool? = nil
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Com_Rivuletkit_Common_Collection_Cookie: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "com.rivuletkit.common.collection"

extension Com_Rivuletkit_Common_Collection_Cookie: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Cookie"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "domain"),
    2: .same(proto: "path"),
    3: .same(proto: "name"),
    4: .same(proto: "value"),
    5: .standard(proto: "host_only"),
    6: .standard(proto: "http_only"),
    7: .same(proto: "expires"),
    8: .standard(proto: "max_age"),
    9: .same(proto: "secure"),
    10: .same(proto: "session"),
    11: .same(proto: "extensions"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.domain) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.path) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self._name) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self._value) }()
      case 5: try { try decoder.decodeSingularBoolField(value: &self._hostOnly) }()
      case 6: try { try decoder.decodeSingularBoolField(value: &self._httpOnly) }()
      case 7: try { try decoder.decodeSingularStringField(value: &self._expires) }()
      case 8: try { try decoder.decodeSingularStringField(value: &self._maxAge) }()
      case 9: try { try decoder.decodeSingularBoolField(value: &self._secure) }()
      case 10: try { try decoder.decodeSingularBoolField(value: &self._session) }()
      case 11: try { try decoder.decodeRepeatedStringField(value: &self.extensions) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if !self.domain.isEmpty {
      try visitor.visitSingularStringField(value: self.domain, fieldNumber: 1)
    }
    if !self.path.isEmpty {
      try visitor.visitSingularStringField(value: self.path, fieldNumber: 2)
    }
    try { if let v = self._name {
      try visitor.visitSingularStringField(value: v, fieldNumber: 3)
    } }()
    try { if let v = self._value {
      try visitor.visitSingularStringField(value: v, fieldNumber: 4)
    } }()
    try { if let v = self._hostOnly {
      try visitor.visitSingularBoolField(value: v, fieldNumber: 5)
    } }()
    try { if let v = self._httpOnly {
      try visitor.visitSingularBoolField(value: v, fieldNumber: 6)
    } }()
    try { if let v = self._expires {
      try visitor.visitSingularStringField(value: v, fieldNumber: 7)
    } }()
    try { if let v = self._maxAge {
      try visitor.visitSingularStringField(value: v, fieldNumber: 8)
    } }()
    try { if let v = self._secure {
      try visitor.visitSingularBoolField(value: v, fieldNumber: 9)
    } }()
    try { if let v = self._session {
      try visitor.visitSingularBoolField(value: v, fieldNumber: 10)
    } }()
    if !self.extensions.isEmpty {
      try visitor.visitRepeatedStringField(value: self.extensions, fieldNumber: 11)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Com_Rivuletkit_Common_Collection_Cookie, rhs: Com_Rivuletkit_Common_Collection_Cookie) -> Bool {
    if lhs.domain != rhs.domain {return false}
    if lhs.path != rhs.path {return false}
    if lhs._name != rhs._name {return false}
    if lhs._value != rhs._value {return false}
    if lhs._hostOnly != rhs._hostOnly {return false}
    if lhs._httpOnly != rhs._httpOnly {return false}
    if lhs._expires != rhs._expires {return false}
    if lhs._maxAge != rhs._maxAge {return false}
    if lhs._secure != rhs._secure {return false}
    if lhs._session != rhs._session {return false}
    if lhs.extensions != rhs.extensions {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
