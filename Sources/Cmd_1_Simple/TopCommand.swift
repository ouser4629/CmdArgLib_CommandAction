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
struct TopCommand {

    private static let topCommand = SimpleCommand(
        name: "ca1-simple",
        synopsis: "Cmd_1 - Simple Commands.",
        action: action,
        config: actionConfig(),
        children: [Greet.command, Quotes.command])

    @CommandAction
    private static func ca1Simple(
        h__help: MetaFlag = MetaFlag(helpElements: help),
        t__tree: MetaFlag = MetaFlag(treeFor: nil),
        m__manpage: MetaFlag = MetaFlag(manPageElements: manpage)
    ) {}

    private static let manpage: [ShowElement] = [
        .prologue(description: "Print a greeting or print some famous quotes."),
        .synopsis("SYNOPSIS", trailer: "subcommand"),
        .text("\nOPTIONS"),
        .parameter("h__help", "Show help information"),
        .parameter("t__tree", "Show command tree"),
        .parameter("m__manpage", "Print manpage mdoc code"),
        .lines("\nSUBCOMMANDS"),
        .commandNode(Greet.command.asNode),
        .commandNode(Quotes.command.asNode),
    ]

    private static let help: [ShowElement] = [
        .text("DESCRIPTION:", "Print a greeting or print some famous quotes."),
        .synopsis("\nUSAGE:", trailer: "subcommand"),
        .text("\nOPTIONS:"),
        .parameter("h__help", "Show help information"),
        .parameter("t__tree", "Show command tree"),
        .parameter("m__manpage", "Print manpage mdoc code"),
        .text("\nSUBCOMMANDS:"),
        .commandNode(Greet.command.asNode),
        .commandNode(Quotes.command.asNode),
    ]

    private static func main() async {
        do {
            var (_, words) = commandLineNameAndWords()
            if words.isEmpty { words = ["--help"] }
            try await topCommand.run(words: words, commandPath: [])
        } catch {
            printErrorAndExit(for: error, callNames: [topCommand.name])
        }
    }
}
