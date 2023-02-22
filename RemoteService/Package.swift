// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RemoteService",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "RemoteService", targets: ["RemoteService"]),
        .library(name: "RemoteServiceLive", targets: ["RemoteServiceLive"])
    ],
    dependencies: [],
    targets: [
        .target(name: "RemoteService", dependencies: []),
        .target(name: "RemoteServiceLive", dependencies: ["RemoteService"]),
        .testTarget(
            name: "RemoteServiceTests",
            dependencies: ["RemoteService", "RemoteServiceLive"])
    ]
)
