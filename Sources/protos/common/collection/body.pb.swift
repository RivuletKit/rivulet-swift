// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: protos/common/collection/body.proto
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

public enum Com_Rivuletkit_Common_Collection_BodyMode: SwiftProtobuf.Enum {
  public typealias RawValue = Int

  /// raw
  case raw // = 0

  /// urlencoded
  case urlencoded // = 1

  /// formdata
  case formdata // = 2

  /// file
  case file // = 3

  ///  GraphQL
  case graphql // = 4
  case UNRECOGNIZED(Int)

  public init() {
    self = .raw
  }

  public init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .raw
    case 1: self = .urlencoded
    case 2: self = .formdata
    case 3: self = .file
    case 4: self = .graphql
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  public var rawValue: Int {
    switch self {
    case .raw: return 0
    case .urlencoded: return 1
    case .formdata: return 2
    case .file: return 3
    case .graphql: return 4
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Com_Rivuletkit_Common_Collection_BodyMode: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  public static let allCases: [Com_Rivuletkit_Common_Collection_BodyMode] = [
    .raw,
    .urlencoded,
    .formdata,
    .file,
    .graphql,
  ]
}

#endif  // swift(>=4.2)

public struct Com_Rivuletkit_Common_Collection_Body {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The type of data associated with this request in this field.
  public var mode: Com_Rivuletkit_Common_Collection_BodyMode {
    get {return _mode ?? .raw}
    set {_mode = newValue}
  }
  /// Returns true if `mode` has been explicitly set.
  public var hasMode: Bool {return self._mode != nil}
  /// Clears the value of `mode`. Subsequent reads from it will return its default value.
  public mutating func clearMode() {self._mode = nil}

  public var rew: String {
    get {return _rew ?? String()}
    set {_rew = newValue}
  }
  /// Returns true if `rew` has been explicitly set.
  public var hasRew: Bool {return self._rew != nil}
  /// Clears the value of `rew`. Subsequent reads from it will return its default value.
  public mutating func clearRew() {self._rew = nil}

  /// optional string graphql = 3; // reserve
  public var urlencoded: Com_Rivuletkit_Common_Collection_UrlEncodedParameter {
    get {return _urlencoded ?? Com_Rivuletkit_Common_Collection_UrlEncodedParameter()}
    set {_urlencoded = newValue}
  }
  /// Returns true if `urlencoded` has been explicitly set.
  public var hasUrlencoded: Bool {return self._urlencoded != nil}
  /// Clears the value of `urlencoded`. Subsequent reads from it will return its default value.
  public mutating func clearUrlencoded() {self._urlencoded = nil}

  public var formdata: Com_Rivuletkit_Common_Collection_FormParameter {
    get {return _formdata ?? Com_Rivuletkit_Common_Collection_FormParameter()}
    set {_formdata = newValue}
  }
  /// Returns true if `formdata` has been explicitly set.
  public var hasFormdata: Bool {return self._formdata != nil}
  /// Clears the value of `formdata`. Subsequent reads from it will return its default value.
  public mutating func clearFormdata() {self._formdata = nil}

  public var file: Com_Rivuletkit_Common_Collection_BodyFile {
    get {return _file ?? Com_Rivuletkit_Common_Collection_BodyFile()}
    set {_file = newValue}
  }
  /// Returns true if `file` has been explicitly set.
  public var hasFile: Bool {return self._file != nil}
  /// Clears the value of `file`. Subsequent reads from it will return its default value.
  public mutating func clearFile() {self._file = nil}

  /// optional string options = 7; // reserve
  public var disabled: Bool {
    get {return _disabled ?? false}
    set {_disabled = newValue}
  }
  /// Returns true if `disabled` has been explicitly set.
  public var hasDisabled: Bool {return self._disabled != nil}
  /// Clears the value of `disabled`. Subsequent reads from it will return its default value.
  public mutating func clearDisabled() {self._disabled = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _mode: Com_Rivuletkit_Common_Collection_BodyMode? = nil
  fileprivate var _rew: String? = nil
  fileprivate var _urlencoded: Com_Rivuletkit_Common_Collection_UrlEncodedParameter? = nil
  fileprivate var _formdata: Com_Rivuletkit_Common_Collection_FormParameter? = nil
  fileprivate var _file: Com_Rivuletkit_Common_Collection_BodyFile? = nil
  fileprivate var _disabled: Bool? = nil
}

public struct Com_Rivuletkit_Common_Collection_UrlEncodedParameter {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var key: String = String()

  public var value: String {
    get {return _value ?? String()}
    set {_value = newValue}
  }
  /// Returns true if `value` has been explicitly set.
  public var hasValue: Bool {return self._value != nil}
  /// Clears the value of `value`. Subsequent reads from it will return its default value.
  public mutating func clearValue() {self._value = nil}

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

  fileprivate var _value: String? = nil
  fileprivate var _disabled: Bool? = nil
  fileprivate var _description_p: String? = nil
}

public struct Com_Rivuletkit_Common_Collection_FormParameter {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var key: String = String()

  public var value: String {
    get {return _value ?? String()}
    set {_value = newValue}
  }
  /// Returns true if `value` has been explicitly set.
  public var hasValue: Bool {return self._value != nil}
  /// Clears the value of `value`. Subsequent reads from it will return its default value.
  public mutating func clearValue() {self._value = nil}

  /// When set to true, prevents this form data entity from being sent.
  public var disabled: Bool {
    get {return _disabled ?? false}
    set {_disabled = newValue}
  }
  /// Returns true if `disabled` has been explicitly set.
  public var hasDisabled: Bool {return self._disabled != nil}
  /// Clears the value of `disabled`. Subsequent reads from it will return its default value.
  public mutating func clearDisabled() {self._disabled = nil}

  public var type: String {
    get {return _type ?? String()}
    set {_type = newValue}
  }
  /// Returns true if `type` has been explicitly set.
  public var hasType: Bool {return self._type != nil}
  /// Clears the value of `type`. Subsequent reads from it will return its default value.
  public mutating func clearType() {self._type = nil}

  /// Override Content-Type header of this form data entity.
  public var contentType: String {
    get {return _contentType ?? String()}
    set {_contentType = newValue}
  }
  /// Returns true if `contentType` has been explicitly set.
  public var hasContentType: Bool {return self._contentType != nil}
  /// Clears the value of `contentType`. Subsequent reads from it will return its default value.
  public mutating func clearContentType() {self._contentType = nil}

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

  fileprivate var _value: String? = nil
  fileprivate var _disabled: Bool? = nil
  fileprivate var _type: String? = nil
  fileprivate var _contentType: String? = nil
  fileprivate var _description_p: String? = nil
}

public struct Com_Rivuletkit_Common_Collection_BodyFile {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var src: String {
    get {return _src ?? String()}
    set {_src = newValue}
  }
  /// Returns true if `src` has been explicitly set.
  public var hasSrc: Bool {return self._src != nil}
  /// Clears the value of `src`. Subsequent reads from it will return its default value.
  public mutating func clearSrc() {self._src = nil}

  public var content: String {
    get {return _content ?? String()}
    set {_content = newValue}
  }
  /// Returns true if `content` has been explicitly set.
  public var hasContent: Bool {return self._content != nil}
  /// Clears the value of `content`. Subsequent reads from it will return its default value.
  public mutating func clearContent() {self._content = nil}

  public var raw: Data {
    get {return _raw ?? Data()}
    set {_raw = newValue}
  }
  /// Returns true if `raw` has been explicitly set.
  public var hasRaw: Bool {return self._raw != nil}
  /// Clears the value of `raw`. Subsequent reads from it will return its default value.
  public mutating func clearRaw() {self._raw = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _src: String? = nil
  fileprivate var _content: String? = nil
  fileprivate var _raw: Data? = nil
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Com_Rivuletkit_Common_Collection_BodyMode: @unchecked Sendable {}
extension Com_Rivuletkit_Common_Collection_Body: @unchecked Sendable {}
extension Com_Rivuletkit_Common_Collection_UrlEncodedParameter: @unchecked Sendable {}
extension Com_Rivuletkit_Common_Collection_FormParameter: @unchecked Sendable {}
extension Com_Rivuletkit_Common_Collection_BodyFile: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "com.rivuletkit.common.collection"

extension Com_Rivuletkit_Common_Collection_BodyMode: SwiftProtobuf._ProtoNameProviding {
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "RAW"),
    1: .same(proto: "URLENCODED"),
    2: .same(proto: "FORMDATA"),
    3: .same(proto: "FILE"),
    4: .same(proto: "GRAPHQL"),
  ]
}

extension Com_Rivuletkit_Common_Collection_Body: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Body"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "mode"),
    2: .same(proto: "rew"),
    4: .same(proto: "urlencoded"),
    5: .same(proto: "formdata"),
    6: .same(proto: "file"),
    8: .same(proto: "disabled"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularEnumField(value: &self._mode) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self._rew) }()
      case 4: try { try decoder.decodeSingularMessageField(value: &self._urlencoded) }()
      case 5: try { try decoder.decodeSingularMessageField(value: &self._formdata) }()
      case 6: try { try decoder.decodeSingularMessageField(value: &self._file) }()
      case 8: try { try decoder.decodeSingularBoolField(value: &self._disabled) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._mode {
      try visitor.visitSingularEnumField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._rew {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._urlencoded {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
    } }()
    try { if let v = self._formdata {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    } }()
    try { if let v = self._file {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
    } }()
    try { if let v = self._disabled {
      try visitor.visitSingularBoolField(value: v, fieldNumber: 8)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Com_Rivuletkit_Common_Collection_Body, rhs: Com_Rivuletkit_Common_Collection_Body) -> Bool {
    if lhs._mode != rhs._mode {return false}
    if lhs._rew != rhs._rew {return false}
    if lhs._urlencoded != rhs._urlencoded {return false}
    if lhs._formdata != rhs._formdata {return false}
    if lhs._file != rhs._file {return false}
    if lhs._disabled != rhs._disabled {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Com_Rivuletkit_Common_Collection_UrlEncodedParameter: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".UrlEncodedParameter"
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
      case 1: try { try decoder.decodeSingularStringField(value: &self.key) }()
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
    if !self.key.isEmpty {
      try visitor.visitSingularStringField(value: self.key, fieldNumber: 1)
    }
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

  public static func ==(lhs: Com_Rivuletkit_Common_Collection_UrlEncodedParameter, rhs: Com_Rivuletkit_Common_Collection_UrlEncodedParameter) -> Bool {
    if lhs.key != rhs.key {return false}
    if lhs._value != rhs._value {return false}
    if lhs._disabled != rhs._disabled {return false}
    if lhs._description_p != rhs._description_p {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Com_Rivuletkit_Common_Collection_FormParameter: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".FormParameter"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "key"),
    2: .same(proto: "value"),
    3: .same(proto: "disabled"),
    4: .same(proto: "type"),
    5: .standard(proto: "content_type"),
    6: .same(proto: "description"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.key) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self._value) }()
      case 3: try { try decoder.decodeSingularBoolField(value: &self._disabled) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self._type) }()
      case 5: try { try decoder.decodeSingularStringField(value: &self._contentType) }()
      case 6: try { try decoder.decodeSingularStringField(value: &self._description_p) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if !self.key.isEmpty {
      try visitor.visitSingularStringField(value: self.key, fieldNumber: 1)
    }
    try { if let v = self._value {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._disabled {
      try visitor.visitSingularBoolField(value: v, fieldNumber: 3)
    } }()
    try { if let v = self._type {
      try visitor.visitSingularStringField(value: v, fieldNumber: 4)
    } }()
    try { if let v = self._contentType {
      try visitor.visitSingularStringField(value: v, fieldNumber: 5)
    } }()
    try { if let v = self._description_p {
      try visitor.visitSingularStringField(value: v, fieldNumber: 6)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Com_Rivuletkit_Common_Collection_FormParameter, rhs: Com_Rivuletkit_Common_Collection_FormParameter) -> Bool {
    if lhs.key != rhs.key {return false}
    if lhs._value != rhs._value {return false}
    if lhs._disabled != rhs._disabled {return false}
    if lhs._type != rhs._type {return false}
    if lhs._contentType != rhs._contentType {return false}
    if lhs._description_p != rhs._description_p {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Com_Rivuletkit_Common_Collection_BodyFile: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".BodyFile"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "src"),
    2: .same(proto: "content"),
    3: .same(proto: "raw"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self._src) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self._content) }()
      case 3: try { try decoder.decodeSingularBytesField(value: &self._raw) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._src {
      try visitor.visitSingularStringField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._content {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._raw {
      try visitor.visitSingularBytesField(value: v, fieldNumber: 3)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Com_Rivuletkit_Common_Collection_BodyFile, rhs: Com_Rivuletkit_Common_Collection_BodyFile) -> Bool {
    if lhs._src != rhs._src {return false}
    if lhs._content != rhs._content {return false}
    if lhs._raw != rhs._raw {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
