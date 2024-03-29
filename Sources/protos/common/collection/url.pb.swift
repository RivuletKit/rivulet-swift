// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: protos/common/collection/url.proto
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

public struct Com_Rivuletkit_Common_Collection_URL {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The string representation of the request URL, including the protocol, host, path, hash, query parameter(s) and path variable(s).
  public var raw: String {
    get {return _raw ?? String()}
    set {_raw = newValue}
  }
  /// Returns true if `raw` has been explicitly set.
  public var hasRaw: Bool {return self._raw != nil}
  /// Clears the value of `raw`. Subsequent reads from it will return its default value.
  public mutating func clearRaw() {self._raw = nil}

  /// The protocol associated with the request, E.g: 'http'
  public var `protocol`: String {
    get {return _protocol ?? String()}
    set {_protocol = newValue}
  }
  /// Returns true if ``protocol`` has been explicitly set.
  public var hasProtocol: Bool {return self._protocol != nil}
  /// Clears the value of ``protocol``. Subsequent reads from it will return its default value.
  public mutating func clearProtocol() {self._protocol = nil}

  /// The host for the URL, E.g: api.yourdomain.com. Can be stored as a string or as an array of strings.
  public var host: String {
    get {return _host ?? String()}
    set {_host = newValue}
  }
  /// Returns true if `host` has been explicitly set.
  public var hasHost: Bool {return self._host != nil}
  /// Clears the value of `host`. Subsequent reads from it will return its default value.
  public mutating func clearHost() {self._host = nil}

  /// The complete path of the current url.
  public var path: String {
    get {return _path ?? String()}
    set {_path = newValue}
  }
  /// Returns true if `path` has been explicitly set.
  public var hasPath: Bool {return self._path != nil}
  /// Clears the value of `path`. Subsequent reads from it will return its default value.
  public mutating func clearPath() {self._path = nil}

  /// The port number present in this URL. An empty value implies 80/443 depending on whether the protocol field contains http/https.
  public var port: Int32 {
    get {return _port ?? 0}
    set {_port = newValue}
  }
  /// Returns true if `port` has been explicitly set.
  public var hasPort: Bool {return self._port != nil}
  /// Clears the value of `port`. Subsequent reads from it will return its default value.
  public mutating func clearPort() {self._port = nil}

  /// An array of QueryParams, which is basically the query string part of the URL, parsed into separate variables.
  public var querys: [Com_Rivuletkit_Common_Collection_QueryParam] = []

  /// Contains the URL fragment (if any). Usually this is not transmitted over the network, but it could be useful to store this in some cases.
  public var hash: String {
    get {return _hash ?? String()}
    set {_hash = newValue}
  }
  /// Returns true if `hash` has been explicitly set.
  public var hasHash: Bool {return self._hash != nil}
  /// Clears the value of `hash`. Subsequent reads from it will return its default value.
  public mutating func clearHash() {self._hash = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _raw: String? = nil
  fileprivate var _protocol: String? = nil
  fileprivate var _host: String? = nil
  fileprivate var _path: String? = nil
  fileprivate var _port: Int32? = nil
  fileprivate var _hash: String? = nil
}

public struct Com_Rivuletkit_Common_Collection_QueryParam {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var key: String {
    get {return _key ?? String()}
    set {_key = newValue}
  }
  /// Returns true if `key` has been explicitly set.
  public var hasKey: Bool {return self._key != nil}
  /// Clears the value of `key`. Subsequent reads from it will return its default value.
  public mutating func clearKey() {self._key = nil}

  public var value: String {
    get {return _value ?? String()}
    set {_value = newValue}
  }
  /// Returns true if `value` has been explicitly set.
  public var hasValue: Bool {return self._value != nil}
  /// Clears the value of `value`. Subsequent reads from it will return its default value.
  public mutating func clearValue() {self._value = nil}

  /// If set to true, the current query parameter will not be sent with the request.
  public var disabled: Bool {
    get {return _disabled ?? false}
    set {_disabled = newValue}
  }
  /// Returns true if `disabled` has been explicitly set.
  public var hasDisabled: Bool {return self._disabled != nil}
  /// Clears the value of `disabled`. Subsequent reads from it will return its default value.
  public mutating func clearDisabled() {self._disabled = nil}

  public var description_p: String {
    get {return _description_p ?? String()}
    set {_description_p = newValue}
  }
  /// Returns true if `description_p` has been explicitly set.
  public var hasDescription_p: Bool {return self._description_p != nil}
  /// Clears the value of `description_p`. Subsequent reads from it will return its default value.
  public mutating func clearDescription_p() {self._description_p = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _key: String? = nil
  fileprivate var _value: String? = nil
  fileprivate var _disabled: Bool? = nil
  fileprivate var _description_p: String? = nil
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Com_Rivuletkit_Common_Collection_URL: @unchecked Sendable {}
extension Com_Rivuletkit_Common_Collection_QueryParam: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "com.rivuletkit.common.collection"

extension Com_Rivuletkit_Common_Collection_URL: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".URL"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "raw"),
    2: .same(proto: "protocol"),
    3: .same(proto: "host"),
    4: .same(proto: "path"),
    5: .same(proto: "port"),
    6: .same(proto: "querys"),
    7: .same(proto: "hash"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self._raw) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self._protocol) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self._host) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self._path) }()
      case 5: try { try decoder.decodeSingularInt32Field(value: &self._port) }()
      case 6: try { try decoder.decodeRepeatedMessageField(value: &self.querys) }()
      case 7: try { try decoder.decodeSingularStringField(value: &self._hash) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._raw {
      try visitor.visitSingularStringField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._protocol {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._host {
      try visitor.visitSingularStringField(value: v, fieldNumber: 3)
    } }()
    try { if let v = self._path {
      try visitor.visitSingularStringField(value: v, fieldNumber: 4)
    } }()
    try { if let v = self._port {
      try visitor.visitSingularInt32Field(value: v, fieldNumber: 5)
    } }()
    if !self.querys.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.querys, fieldNumber: 6)
    }
    try { if let v = self._hash {
      try visitor.visitSingularStringField(value: v, fieldNumber: 7)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Com_Rivuletkit_Common_Collection_URL, rhs: Com_Rivuletkit_Common_Collection_URL) -> Bool {
    if lhs._raw != rhs._raw {return false}
    if lhs._protocol != rhs._protocol {return false}
    if lhs._host != rhs._host {return false}
    if lhs._path != rhs._path {return false}
    if lhs._port != rhs._port {return false}
    if lhs.querys != rhs.querys {return false}
    if lhs._hash != rhs._hash {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Com_Rivuletkit_Common_Collection_QueryParam: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".QueryParam"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "key"),
    2: .same(proto: "value"),
    3: .same(proto: "disabled"),
    4: .same(proto: "description"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self._key) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self._value) }()
      case 3: try { try decoder.decodeSingularBoolField(value: &self._disabled) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self._description_p) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._key {
      try visitor.visitSingularStringField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._value {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._disabled {
      try visitor.visitSingularBoolField(value: v, fieldNumber: 3)
    } }()
    try { if let v = self._description_p {
      try visitor.visitSingularStringField(value: v, fieldNumber: 4)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Com_Rivuletkit_Common_Collection_QueryParam, rhs: Com_Rivuletkit_Common_Collection_QueryParam) -> Bool {
    if lhs._key != rhs._key {return false}
    if lhs._value != rhs._value {return false}
    if lhs._disabled != rhs._disabled {return false}
    if lhs._description_p != rhs._description_p {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
