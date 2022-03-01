// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RayonModule",
    platforms: [
        .macOS(.v11),
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "RayonModule",
            type: .static,
            targets: ["RayonModule"]
        ),
        // so we can save disk space for menubar app
//        .library(
//            name: "RayonModule-Framework",
//            type: .dynamic,
//            targets: ["RayonModule"]
//        ),
    ],
    dependencies: [
        .package(name: "PropertyWrapper", path: "../PropertyWrapper"),
        .package(name: "NSRemoteShell", path: "../NSRemoteShell"),
        .package(name: "XTerminalUI", path: "../XTerminalUI"),
        .package(name: "XMLCoder", path: "../XMLCoder"),
        .package(name: "Keychain", path: "../Keychain"),
    ],
    targets: [
        .target(
            name: "RayonModule",
            dependencies: [
                "PropertyWrapper",
                "NSRemoteShell",
                "XTerminalUI",
                "XMLCoder",
                "Keychain",
            ]
        ),
    ]
)
