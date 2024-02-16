// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: protos/common/collection/variable.proto
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

public struct Com_Rivuletkit_Common_Collection_Variable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// A variable ID is a unique user-defined value that identifies the variable within a collection. In traditional terms, this would be a variable name.
  public var id: String {
    get {return _id ?? String()}
    set {_id = newValue}
  }
  /// Returns true if `id` has been explicitly set.
  public var hasID: Bool {return self._id != nil}
  /// Clears the value of `id`. Subsequent reads from it will return its default value.
  public mutating func clearID() {self._id = nil}

  /// A variable key is a human friendly value that identifies the variable within a collection. In traditional terms, this would be a variable name.
  public var key: String {
    get {return _key ?? String()}
    set {_key = newValue}
  }
  /// Returns true if `key` has been explicitly set.
  public var hasKey: Bool {return self._key != nil}
  /// Clears the value of `key`. Subsequent reads from it will return its default value.
  public mutating func clearKey() {self._key = nil}

  /// The value that a variable holds in this collection. Ultimately, the variables will be replaced by this value, when say running a set of requests from a collection.
  public var value: String {
    get {return _value ?? String()}
    set {_value = newValue}
  }
  /// Returns true if `value` has been explicitly set.
  public var hasValue: Bool {return self._value != nil}
  /// Clears the value of `value`. Subsequent reads from it will return its default value.
  public mutating func clearValue() {self._value = nil}

  /// A variable may have multiple types. This field specifies the type of the variable.
  public var type: String {
    get {return _type ?? String()}
    set {_type = newValue}
  }
  /// Returns true if `type` has been explicitly set.
  public var hasType: Bool {return self._type != nil}
  /// Clears the value of `type`. Subsequent reads from it will return its default value.
  public mutating func clearType() {self._type = nil}

  /// Variable name
  public var name: String {
    get {return _name ?? String()}
    set {_name = newValue}
  }
  /// Returns true if `name` has been explicitly set.
  public var hasName: Bool {return self._name != nil}
  /// Clears the value of `name`. Subsequent reads from it will return its default value.
  public mutating func clearName() {self._name = nil}

  public var description_p: String {
    get {return _description_p ?? String()}
    set {_description_p = newValue}
  }
  /// Returns true if `description_p` has been explicitly set.
  public var hasDescription_p: Bool {return self._description_p != nil}
  /// Clears the value of `description_p`. Subsequent reads from it will return its default value.
  public mutating func clearDescription_p() {self._description_p = nil}

  /// boolean default false
  public var system: Bool {
    get {return _system ?? false}
    set {_system = newValue}
  }
  /// Returns true if `system` has been explicitly set.
  public var hasSystem: Bool {return self._system != nil}
  /// Clears the value of `system`. Subsequent reads from it will return its default value.
  public mutating func clearSystem() {self._system = nil}

  /// boolean default false
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

  fileprivate var _id: String? = nil
  fileprivate var _key: String? = nil
  fileprivate var _value: String? = nil
  fileprivate var _type: String? = nil
  fileprivate var _name: String? = nil
  fileprivate var _description_p: String? = nil
  fileprivate var _system: Bool? = nil
  fileprivate var _disabled: Bool? = nil
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Com_Rivuletkit_Common_Collection_Variable: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "com.rivuletkit.common.collection"

extension Com_Rivuletkit_Common_Collection_Variable: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Variable"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "key"),
    3: .same(proto: "value"),
    4: .same(proto: "type"),
    5: .same(proto: "name"),
    6: .same(proto: "description"),
    7: .same(proto: "system"),
    8: .same(proto: "disabled"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self._id) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self._key) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self._value) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self._type) }()
      case 5: try { try decoder.decodeSingularStringField(value: &self._name) }()
      case 6: try { try decoder.decodeSingularStringField(value: &self._description_p) }()
      case 7: try { try decoder.decodeSingularBoolField(value: &self._system) }()
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
    try { if let v = self._id {
      try visitor.visitSingularStringField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._key {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._value {
      try visitor.visitSingularStringField(value: v, fieldNumber: 3)
    } }()
    try { if let v = self._type {
      try visitor.visitSingularStringField(value: v, fieldNumber: 4)
    } }()
    try { if let v = self._name {
      try visitor.visitSingularStringField(value: v, fieldNumber: 5)
    } }()
    try { if let v = self._description_p {
      try visitor.visitSingularStringField(value: v, fieldNumber: 6)
    } }()
    try { if let v = self._system {
      try visitor.visitSingularBoolField(value: v, fieldNumber: 7)
    } }()
    try { if let v = self._disabled {
      try visitor.visitSingularBoolField(value: v, fieldNumber: 8)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Com_Rivuletkit_Common_Collection_Variable, rhs: Com_Rivuletkit_Common_Collection_Variable) -> Bool {
    if lhs._id != rhs._id {return false}
    if lhs._key != rhs._key {return false}
    if lhs._value != rhs._value {return false}
    if lhs._type != rhs._type {return false}
    if lhs._name != rhs._name {return false}
    if lhs._description_p != rhs._description_p {return false}
    if lhs._system != rhs._system {return false}
    if lhs._disabled != rhs._disabled {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
