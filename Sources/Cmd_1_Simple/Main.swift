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

import CmdArgLib
import CmdArgLibMacros
import Foundation

@main
struct Main {

    private static let topLevel = SimpleCommand(
        name: "cf-ca1-simple",
        synopsis: "Demonstrate CLI completion.",
        action: action,
        config: actionConfig(),
        children: [Quotes.command, Food.command, Files.command]
    )

    @CommandAction
    private static func cfCa1Simple(
        generateFishCompletionScript: MetaFlag = MetaFlag(completionScriptFor: .fish, name: "cf-ca1-simple", showElements: helpElements),
        generateZshCompletionScript: MetaFlag = MetaFlag(completionScriptFor: .zsh, name: "cf-ca1-simple", showElements: helpElements),
        t tree: MetaFlag = MetaFlag(treeFor: "cf-ca1-simple", synopsis: "Cmd_1 - Simple commands."),
        h__help help: MetaFlag = MetaFlag(helpElements: helpElements)
    ) {}
    
    
    static let helpElements: [ShowElement] = [
        .text("DESCRIPTION\n", "Demonstrate CLI command completion with a simple hierarchical command."),
        .synopsis("\nUSAGE\n", trailer: "subcommand"),
        .text("\nOPTIONS"),
        .parameter("generateFishCompletionScript","Print a fish completion script"),
        .parameter("generateZshCompletionScript","Print a zsh completion script"),
        .parameter("tree", "Show a hierarchical list of commands"),
        .parameter("help", "Show this help screen"),
        .text("\nSUBCOMMANDS"),
        .commandNode(Quotes.command.asNode),
        .commandNode(Food.command.asNode),
        .commandNode(Files.command.asNode),
    ]
    
    private static func main() async {
        await runCommand(topLevel)
    }
}
