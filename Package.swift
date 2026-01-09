// Copyright (c) 2025 Peter Buenafuente Summerland
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
import PackageDescription

//let cmdArgLib = "Cmd_Arg_Lib"
let cmdArgLib = "cmd-arg-lib"

let package = Package(
    name: "CommandActionExamples",
    platforms: [.macOS(.v26)],
    products: [
        .executable(name: "ca1-simple", targets: ["Cmd_1_Simple"]),
        .executable(name: "ca2-stateful", targets: ["Cmd_2_Stateful"]),
        .executable(name: "ca3-text-math", targets: ["Cmd_3_TextAndMath"]),
    ],

    dependencies: [
        //        .package(path: "../../\(cmdArgLib)")
        .package(url: "https://github.com/ouser4629/cmd-arg-lib.git", from: "0.3.1")
    ],

    targets: [
        .executableTarget(
            name: "Cmd_1_Simple",
            dependencies: [
                .product(name: "CmdArgLib", package: cmdArgLib),
                .product(name: "CmdArgLibMacros", package: cmdArgLib),
                "LocalHelpers",
            ]),
        .executableTarget(
            name: "Cmd_2_Stateful",
            dependencies: [
                .product(name: "CmdArgLib", package: cmdArgLib),
                .product(name: "CmdArgLibMacros", package: cmdArgLib),
                "LocalHelpers",
            ]),
        .executableTarget(
            name: "Cmd_3_TextAndMath",
            dependencies: [
                .product(name: "CmdArgLib", package: cmdArgLib),
                .product(name: "CmdArgLibMacros", package: cmdArgLib),
                "LocalHelpers",
            ]),
        .target(
            name: "LocalHelpers",
            dependencies: [
                .product(name: "CmdArgLib", package: cmdArgLib),
                .product(name: "CmdArgLibMacros", package: cmdArgLib),
            ]),
    ]
)
