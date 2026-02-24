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
import LocalHelpers

@main
struct Main {

    private static let topLevel = StatefulCommand<PhraseFormatter>(
        name: "cf-ca2-stateful",
        synopsis: "Demonstrate CLI completion.",
        action: action,
        config: actionConfig(),
        children: [Quotes.command, Food.command, Files.command]
    )

    @CommandAction
    private static func cfCa2Stateful(
        generateFishCompletionScript: MetaFlag = MetaFlag(completionScriptFor: .fish, name: "cf-ca2-stateful", showElements: helpElements),
        generateZshCompletionScript: MetaFlag = MetaFlag(completionScriptFor: .zsh, name: "cf-ca2-stateful", showElements: helpElements),
        t tree: MetaFlag = MetaFlag(treeFor: "cf-ca2-stateful", synopsis: "Cmd_2 - Stateful commands."),
        u__upper upper: Flag,
        l__lower lower: Flag,
        f__format format: PhraseFormat?,
        h__help help: MetaFlag = MetaFlag(helpElements: helpElements),
        state: [PhraseFormatter]) -> [PhraseFormatter]
    {
        let formatter = PhraseFormatter(upper: upper, lower: lower, phraseFormat: format)
        return [formatter]
    }

    static let helpElements: [ShowElement] = [
        .text("DESCRIPTION\n", "Demonstrate CLI command completion with a stateful hierarchical command."),
        .synopsis("\nUSAGE\n", trailer: "subcommand"),
        .text("\nOPTIONS"),
        .parameter("format","A text format (\(PhraseFormat.orCases("one of")) to use when displaying quotes", .list(PhraseFormat.casesArray)),
        .parameter("upper", "Show the uppercase version of the quotes"),
        .parameter("lower", "Show the lowercase version of the quotes"),
        .text("\nMETA-OPTIONS"),
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
