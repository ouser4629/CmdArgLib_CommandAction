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
//import CmdArgLibCommandTree
import CmdArgLibMacros
import LocalHelpers

typealias Author = String

struct Quotes {

    static let command = SimpleCommand(
        name: "quotes",
        synopsis: "Print some quotes",
        config: actionConfig(),
        showElements: help,
        action: action,
        children: [GeneralQuotes.command, ComputingQuotes.command],
        recastErrorScreenToSubcommandError: true)

    @CommandAction
    private static func work(
        help: MetaFlag = MetaFlag(helpElements: help)
    ) {}

    private static let help: [ShowElement] = [
        .synopsis("USAGE:")
    ]
}

struct ComputingQuotes {

    @CommandAction(shadowGroups: ["lower upper"])
    private static func work(
        l lower: Flag, u upper: Flag, _ count: Count,
        help: MetaFlag = MetaFlag(helpElements: cmd1HelpFor("computing"))
    ) {
        let formatter = PhraseFormatter(upper: upper, lower: lower)
        printQuotesWith(formatter, count: count, quotes: computingQuotes)
    }

    static let command = SimpleCommand(
        name: "computing",
        synopsis: "Print quotes about computing.",
        config: actionConfig(),
        showElements: cmd1HelpFor("computing"),
        action: action)
}

func cmd1HelpFor(_ topic: String) -> [ShowElement] {
    [
        .text("DESCRIPTION:", "Print $T{count} quotes about \(topic)."),
        .synopsis("\nUSAGE:"),
        .text("\nOPTIONS:"),
        .parameter("lower", "Lowercase the output"),
        .parameter("upper", "Uppercase the output"),
        .text("\nNOTE:", "The $L{lower} and $L{upper} options shadow each other."),
    ]
}

struct GeneralQuotes {

    static let command = SimpleCommand(
        name: "general",
        synopsis: "Print quotes about life in general.",
        config: actionConfig(),
        showElements: cmd1HelpFor("computing"),
        action: action)

    @CommandAction(shadowGroups: ["lower upper"])
    private static func work(
        l lower: Flag, u upper: Flag, _ count: Count,
        help: MetaFlag = MetaFlag(helpElements: cmd1HelpFor("life in general"))
    ) {
        let formatter = PhraseFormatter(upper: upper, lower: lower)
        printQuotesWith(formatter, count: count, quotes: generalQuotes)
    }

}
