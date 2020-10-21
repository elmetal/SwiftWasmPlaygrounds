// swift-tools-version:5.3
import PackageDescription
let package = Package(
    name: "SwiftWasmPlaygrounds",
    products: [
        .executable(name: "SwiftWasmPlaygrounds", targets: ["SwiftWasmPlaygrounds"])
    ],
    dependencies: [
        .package(name: "Tokamak", url: "https://github.com/swiftwasm/Tokamak", from: "0.4.0")
    ],
    targets: [
        .target(
            name: "SwiftWasmPlaygrounds",
            dependencies: [
                .product(name: "TokamakShim", package: "Tokamak")
            ]),
        .testTarget(
            name: "SwiftWasmPlaygroundsTests",
            dependencies: ["SwiftWasmPlaygrounds"]),
    ]
)
