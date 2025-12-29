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
import CmdArgLibMacros
import LocalHelpers

@main
struct TopNode {
    
    private static let phoneyNode = Node(
        name: "cf-ca1-simple",
        synopsis: "Print a greeting or print some famous quotes.",
        subnodes: [Greet.command.asNode, Quotes.command.asNode]
    )

    private static let topLevel = SimpleCommand(
        name: "ca1-simple",
        synopsis: "Cmd_1 - Simple Commands.",
        action: action,
        config: actionConfig(),
        children: [Greet.command, Quotes.command])

    @CommandAction
    private static func work(
        h__help: MetaFlag = MetaFlag(helpElements: help),
        t__tree: MetaFlag = MetaFlag(treeFor: phoneyNode),
    ) {}

    private static let help: [ShowElement] = [
        .text("DESCRIPTION:", "Print a greeting or print some famous quotes."),
        .synopsis("\nUSAGE:", trailer: "Command"),
        .text("\nOPTIONS:"),
        .parameter("h__help", "Show help information"),
        .parameter("t__tree", "Show command tree"),
        .text("\nSUBCOMMANDS:"),
        .commandNode(Greet.command.asNode),
        .commandNode(Quotes.command.asNode),
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
