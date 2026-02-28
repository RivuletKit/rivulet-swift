// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "RivuletSwift",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v13),
  ],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "RivuletSwift",
      targets: ["RivuletSwift", "RivuletProtos"]
    )
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.25.2"),
    .package(
      url: "https://github.com/apple/swift-nio.git",
      revision: "d38344d14bda9c7c3eb0921adea9e12bd84a6bb7"),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "RivuletSwift",
      dependencies: [
        .product(name: "SwiftProtobuf", package: "swift-protobuf"),
        "RivuletProtos",
      ],
      path: "Sources/rivulet-swift"
    ),
    .target(
      name: "RivuletProtos",
      dependencies: [
        .product(name: "SwiftProtobuf", package: "swift-protobuf")
      ],
      path: "Sources/protos"
    ),
    .testTarget(
      name: "RivuletSwiftTests",
      dependencies: [
        "RivuletSwift",
        "RivuletProtos",
        .product(name: "NIOCore", package: "swift-nio"),
        .product(name: "NIOPosix", package: "swift-nio"),
        .product(name: "NIOHTTP1", package: "swift-nio"),
      ],
      resources: [
        .process("Fixtures")
      ]
    ),
  ]
)
