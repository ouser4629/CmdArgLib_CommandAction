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

// Example Cmd_3_TextAndMath
//
// The commands in this example have a complex type, members of which are structs
//    1. All the commands or instances of StatefulCommand<GlobalOptions>
//    2. The GlobalOption recieved by a leaf command is modified by parent commands
// There is a short cut path to the general quotes command.
//
// Suggested command calls:
//    > ./ca3-text-math tree
//    > ./ca3-text-math --help
//    > ./ca3-text-math .general --help
//    > ./ca3-text-math -vn Sammy .math .add -1 -2
//    > ./ca3-text-math .text .phrases --help
//    > ./ca3-text-math .text .phrases -o ascending "foo" "bar"
//    > ./ca3-text-math -vn Sammy .text -u .phrases -o ascending foo bar
//    > ./ca3-text-math -vn Sammy .text -u .phrases
//

import CmdArgLib
import CmdArgLibMacros
import LocalHelpers

// FIXME: ./ca3-text-math .math --help -- puts [-h] in wrong place

@main
struct TopCommands {

    private static let topCommand = StatefulCommand<GlobalOptions>(
        name: "ca3-text-math",
        synopsis: "Do text and math stuff.",
        action: action,
        children: [Text.command, Math.command, GeneralQuotes.command])

    @CommandAction
    private static func work(
        n name: Name? = nil,
        v verbose: Flag,
        h__help: MetaFlag = MetaFlag(helpElements: help),
        t__tree: MetaFlag = MetaFlag(treeFor: "ca3-text-math", synopsis: "Run text and math commands"),
        version: MetaFlag = MetaFlag(string: "version 0.1"),
        commandPath: [StatefulCommand<GlobalOptions>],
        state: [GlobalOptions]
    ) throws -> [GlobalOptions] {
        let state = GlobalOptions(name: name, verbose: verbose)
        return [state]
    }

    private static let help: [ShowElement] = [
        .text("DESCRIPTION:", "Do text and math stuff."),
        .synopsis("\nUSAGE:", trailer: "subcommand"),
        .text("\nOPTIONS:"),
        .parameter("verbose", "Execute subcommands verbosely"),
        .parameter("h__help", "Show help information"),
        .parameter("t__tree", "Show command tree"),
        .parameter("name", "The name of the user, if any"),
        .text("\nSUBCOMMANDS:"),
        .commandNode(Text.command.asNode),
        .commandNode(Math.command.asNode),
        .commandNode(GeneralQuotes.command.asNode),
    ]

    private static func main() async {
        await runCommand(topCommand)
    }
}
