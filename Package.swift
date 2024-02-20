// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RivuletSwift",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RivuletSwift",
            targets: ["RivuletSwift", "RivuletProtos"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "SwiftProtobuf", url: "https://github.com/apple/swift-protobuf.git", from: "1.25.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "RivuletSwift",
            dependencies: ["SwiftProtobuf", "RivuletProtos"],
            path: "Sources/rivulet-swift"
        ),
        .target(
            name: "RivuletProtos",
            dependencies: ["SwiftProtobuf"],
            path: "Sources/protos"
        ),
        .testTarget(
            name: "RivuletSwiftTests",
            dependencies: ["RivuletSwift", "RivuletProtos"]
        ),
    ]
)
