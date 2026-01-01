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
//    4. The work functions all have commandPath and state as their last two parameters
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
struct TopCommand {

    private static let topCommand = StatefulCommand<PhraseFormatter>(
        name: "ca2-stateful",
        synopsis: "Cmd_2 - Stateful commands.",
        action: Self.action,
        children: [Cmd02General.node, Cmd02Computing.node])

    @CommandAction(shadowGroups: ["lower upper"])
    private static func work(
        l lower: Flag,
        u upper: Flag,
        t__tree: MetaFlag = MetaFlag(treeFor: "ca2-stateful", synopsis: "Cmd_2 - Stateful commands."),
        m__manpage: MetaFlag = MetaFlag(manPageElements: manpage),
        h__help: MetaFlag = MetaFlag(helpElements: help),
        commandPath: [StatefulCommand<PhraseFormatter>],
        state: [PhraseFormatter]
    ) throws -> [PhraseFormatter] {
        return [PhraseFormatter(upper: upper, lower: lower)]
    }

    private static let help: [ShowElement] = [
        .text("DESCRIPTION:", "Print quotes by famous people."),
        .synopsis("\nUSAGE:", trailer: "subcommand"),
    ] + parameterElements

    private static let manpage: [ShowElement] = [
        .prologue(description: "Print quotes by famous people."),
        .synopsis("SYNOPSIS", trailer: "subcommand"),
    ] + parameterElements

    private static let parameterElements: [ShowElement] = [
        .text("\nOPTIONS"),
        .parameter("lower", "Lowercase the output of subcommands"),
        .parameter("upper", "Uppercase the output of subcommands"),
        .parameter("h__help", "Show help information"),
        .parameter("t__tree", "Show command tree"),
        .text("\nNOTE\n", "The $L{lower} and $L{upper} options shadow each other."),
        .text("\nSUBCOMMANDS"),
        .commandNode(Cmd02General.node.asNode),
        .commandNode(Cmd02Computing.node.asNode),
    ]

    private static func main() async {
        await runCommand(topCommand)
    }
}

struct Cmd02General {

    @CommandAction
    private static func work(
        _ count: Count,
        help: MetaFlag = MetaFlag(helpElements: cmd2HelpFor("life in general")),
        commandPath: [StatefulCommand<PhraseFormatter>],
        state: [PhraseFormatter]
    ) -> [PhraseFormatter] {
        guard let formatter = state.first else { fatalError() }
        printQuotesWith(formatter, count: count, quotes: generalQuotes)
        return state
    }

    static let node = StatefulCommand<PhraseFormatter>(
        name: "general",
        synopsis: "Print quotes about life in general.",
        action: action)
}

struct Cmd02Computing {

    @CommandAction
    private static func work(
        _ count: Count,
        help: MetaFlag = MetaFlag(helpElements: cmd2HelpFor("computing")),
        commandPath: [StatefulCommand<PhraseFormatter>],
        state: [PhraseFormatter]
    ) -> [PhraseFormatter] {
        guard let formatter = state.first else { fatalError() }
        printQuotesWith(formatter, count: count, quotes: computingQuotes)
        return state
    }

    static let node = StatefulCommand<PhraseFormatter>(
        name: "computing",
        synopsis: "Print quotes about computing.",
        action: action)
}

private func cmd2HelpFor(_ topic: String) -> [ShowElement] {
    [.text("DESCRIPTION:", "Print $T{count} quotes about \(topic)."), .synopsis("\nUSAGE:")]
}
