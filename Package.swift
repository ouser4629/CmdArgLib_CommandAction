// Copyright (c) 2025 Peter Summerland
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// --- Remote and local use of cmd-arg-lib
let cmdArgLib = "cmd-arg-lib"

/// --- Local - source
//let cmdArgLib = "Cmd_Arg_Lib"

let package = Package(
    name: "CommandActionExample",
    platforms: [.macOS(.v26)],
    products: [
        .executable(name: "cf-ca1-simple", targets: ["Cmd_1_Simple"]),
        .executable(name: "cf-ca2-stateful", targets: ["Cmd_2_Stateful"]),
        .executable(name: "cf-ca3-assisted", targets: ["Cmd_3_Assisted"]),
    ],
    dependencies: [
        // Remote
         .package(url: "https://github.com/ouser4629/cmd-arg-lib.git", from: "0.4.6")
        // Local
        // .package(path: "../../\(cmdArgLib)")
    ],
    targets: [
        .target(
            name: "LocalHelpers",
            dependencies: [
                .product(name: "CmdArgLib", package: cmdArgLib),
                .product(name: "CmdArgLibMacros", package: cmdArgLib),
            ],
            path: "Sources/LocalHelpers"),
        .executableTarget(
            name: "Cmd_1_Simple",
            dependencies: [
                "LocalHelpers",
                .product(name: "CmdArgLib", package: cmdArgLib),
                .product(name: "CmdArgLibMacros", package: cmdArgLib),
            ],
            path: "Sources/Cmd_1_Simple"),
        .executableTarget(
            name: "Cmd_2_Stateful",
            dependencies: [
                "LocalHelpers",
                .product(name: "CmdArgLib", package: cmdArgLib),
                .product(name: "CmdArgLibMacros", package: cmdArgLib),
            ],
            path: "Sources/Cmd_2_Stateful"),
        .executableTarget(
            name: "Cmd_3_Assisted",
            dependencies: [
                "LocalHelpers",
                .product(name: "CmdArgLib", package: cmdArgLib),
                .product(name: "CmdArgLibMacros", package: cmdArgLib),
            ],
            path: "Sources/Cmd_3_Assisted"),
    ]
)
