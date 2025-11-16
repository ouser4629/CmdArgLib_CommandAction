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

@main
struct TopLevel {

    private static let topLevel = StatefulCommand<GlobalOptions>(
        name: "ca3-text-math",
        synopsis: "Run text and math commands",
        config: actionConfig(),
        showElements: help,
        action: action,
        children: [Text.command, Math.command, GeneralQuotes.command, CmdTree.command])

    @CommandAction
    private static func work(
        n name: Name? = nil,
        v verbose: Flag,
        help: MetaFlag = MetaFlag(helpElements: help),
        version: MetaFlag = MetaFlag(string: "version 0.1"),
        nodePath: [StatefulCommand<GlobalOptions>],
        state: [GlobalOptions]
    ) throws -> [GlobalOptions] {
        let state = GlobalOptions(name: name, verbose: verbose)
        return [state]
    }

    private static let help: [ShowElement] = [
        .text("\nDESCRIPTION:", "Do text and math stuff."),
        .synopsis("\nUSAGE:"),
        .text("\nOPTIONS:"),
        .parameter("name", "The name of the user, if any"),
        .parameter("verbose", "Execute subcommands verbosely"),
    ]

    private static func main() async {
        await runCommand(topLevel)
    }
}
