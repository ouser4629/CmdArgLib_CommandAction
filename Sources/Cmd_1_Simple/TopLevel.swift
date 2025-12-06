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

import CmdArgLib
//import CmdArgLibCommandTree
import CmdArgLibMacros
import LocalHelpers

@main
struct TopLevel {

    private static let topLevel = SimpleCommand(
        name: "ca1-simple",
        synopsis: "Cmd_1 - Simple Commands.",
        config: actionConfig(),
        showElements: help,
        action: action,
        children: [Greet.command, Quotes.command, CmdTree.command])

    @CommandAction
    private static func work(
        help: MetaFlag = MetaFlag(helpElements: help)
    ) {}

    private static let help: [ShowElement] = [
        .text("DESCRIPTION:", "Greet or print some famous quotes."),
        .synopsis("\nUSAGE:"),
    ]

    private static func main() async {
        do {
            var (_, tokens) = commandLineNameAndWords()
            if tokens.isEmpty { tokens = ["--help"] }
            try await topLevel.run(tokens: tokens, nodePath: [])
        } catch {
            printErrorAndExit(for: error, callNames: [topLevel.name])
        }
    }
}
