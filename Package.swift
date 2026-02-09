// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "MahJongScoresBackend",
    platforms: [
        .macOS(.v26),
        .iOS(.v26)
    ],
    dependencies: [
        // Vapor framework
        .package(url: "https://github.com/vapor/vapor.git", from: "4.99.0"),
        // Swift OpenAPI Generator
        .package(url: "https://github.com/apple/swift-openapi-generator", from: "1.0.0"),
        // Swift OpenAPI Runtime
        .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.0.0"),
        // Swift OpenAPI Vapor transport
        .package(url: "https://github.com/swift-server/swift-openapi-vapor", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "MahJongScoresBackend",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIVapor", package: "swift-openapi-vapor"),
            ],
            plugins: [
                .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator")
            ]
        ),
    ]
)
