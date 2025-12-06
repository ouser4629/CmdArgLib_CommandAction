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

// Example Cmd_2_Stateful
//
//  This example is the same as Cmd_1_Simple except that state is passed to subcommands
//    1. All the commands or instances of xbStatefulCommand<PhraseFormatter>
//    2. We say the tree has type PhraseFormatter
//    3. The state is [PhraseFormatter]
//    4. The work functions all have nodePath and state as their last two parameters
//    5. The work functions all return state.
//
// Suggested command calls:
//    debug> ./ca2-quotes-state  tree
//    debug> ./ca2-quotes-state  --help
//    debug> ./ca2 general --help
//    debug> ./ca2 computing --help
//    debug> ./ca2-quotes-state  computing 1
//    debug> ./ca2-quotes-state  -u -f underlined computing 1
//    debug> ./ca2-quotes-state  -uxly -f

import CmdArgLib
import CmdArgLibMacros
import LocalHelpers

@main
struct TopLevel {

    private static let topLevel = StatefulCommand<PhraseFormatter>(
        name: "ca2-stateful",
        synopsis: "Cmd_2 - Stateful commands.",
        config: actionConfig(),
        showElements: help,
        action: Self.action,
        children: [Cmd02General.command, Cmd02Computing.command, CmdTree.command])

    @CommandAction(shadowGroups: ["lower upper"])
    private static func work(
        l lower: Flag,
        u upper: Flag,
        help: MetaFlag = MetaFlag(helpElements: help),
        nodePath: [StatefulCommand<PhraseFormatter>],
        state: [PhraseFormatter]
    ) throws -> [PhraseFormatter] {
        return [PhraseFormatter(upper: upper, lower: lower)]
    }

    private static let help: [ShowElement] = [
        .text("DESCRIPTION:", "Print quotes by famous people."),
        .synopsis("\nUSAGE:"),
        .text("\nOPTIONS:"),
        .parameter("lower", "Lowercase the output"),
        .parameter("upper", "Uppercase the output"),
        .text("\nNOTE:\n", "The $L{lower} and $L{upper} options shadow each other."),
    ]

    private static func main() async {
        await runCommand(topLevel)
    }
}

struct Cmd02General {

    @CommandAction
    private static func work(
        _ count: Count,
        help: MetaFlag = MetaFlag(helpElements: cmd2HelpFor("life in general")),
        nodePath: [StatefulCommand<PhraseFormatter>],
        state: [PhraseFormatter]
    ) -> [PhraseFormatter] {
        guard let formatter = state.first else { fatalError() }
        printQuotesWith(formatter, count: count, quotes: generalQuotes)
        return state
    }

    static let command = StatefulCommand<PhraseFormatter>(
        name: "general",
        synopsis: "Print quotes about life in general.",
        config: actionConfig(),
        showElements: cmd2HelpFor("life in general"),
        action: action)
}

struct Cmd02Computing {

    @CommandAction
    private static func work(
        _ count: Count,
        help: MetaFlag = MetaFlag(helpElements: cmd2HelpFor("computing")),
        nodePath: [StatefulCommand<PhraseFormatter>],
        state: [PhraseFormatter]
    ) -> [PhraseFormatter] {
        guard let formatter = state.first else { fatalError() }
        printQuotesWith(formatter, count: count, quotes: computingQuotes)
        return state
    }

    static let command = StatefulCommand<PhraseFormatter>(
        name: "computing",
        synopsis: "Print quotes about computing.",
        config: actionConfig(),
        showElements: cmd2HelpFor("computing"),
        action: action)
}

private func cmd2HelpFor(_ topic: String) -> [ShowElement] {
    [.text("DESCRIPTION:", "Print $T{count} quotes about \(topic)."), .synopsis("\nUSAGE:")]
}
