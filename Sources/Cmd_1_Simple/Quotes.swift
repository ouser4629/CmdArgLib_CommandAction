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

typealias Author = String

struct Quotes {

    static let command = SimpleCommand(
        name: "quotes",
        synopsis: "Print some quotes.",
        action: action,
        children: [GeneralQuotes.command, ComputingQuotes.command]
    )

    @CommandAction
    private static func work(
        help: MetaFlag = MetaFlag(helpElements: help)
    ) {}

    private static let help: [ShowElement] = [
        .text("DESCRIPTION:", "Print some quotes."),
        .synopsis("\nUSAGE:", trailer: "subcommand"),
        .text("\nSUBCOMMANDS:"),
        .commandNode(GeneralQuotes.command.asNode),
        .commandNode(ComputingQuotes.command.asNode),
    ]
}

struct ComputingQuotes {

    @CommandAction(shadowGroups: ["lower upper"])
    private static func work(
        l lower: Flag, u upper: Flag, _ count: Count,
        help: MetaFlag = MetaFlag(helpElements: helpForComputingQuotes)
    ) {
        let formatter = PhraseFormatter(upper: upper, lower: lower)
        printQuotesWith(formatter, count: count, quotes: computingQuotes)
    }

    static let command = SimpleCommand(
        name: "computing",
        synopsis: "Print quotes about computing.",
        action: action)
}

let helpForComputingQuotes: [ShowElement] = [
    .text("DESCRIPTION:", "Print $T{count} quotes about computing."),
    .synopsis("\nUSAGE:"),
    .text("\nOPTIONS:"),
    .parameter("lower", "Lowercase the output"),
    .parameter("upper", "Uppercase the output"),
    .text("\nNOTE:", "The $L{lower} and $L{upper} options shadow each other."),
]

let helpForGeneralCQuotes: [ShowElement] = [
    .text("DESCRIPTION:", "Print $T{count} quotes about life in general."),
    .synopsis("\nUSAGE:"),
    .text("\nOPTIONS:"),
    .parameter("lower", "Lowercase the output"),
    .parameter("upper", "Uppercase the output"),
    .text("\nNOTE:", "The $L{lower} and $L{upper} options shadow each other."),
    
]


struct GeneralQuotes {

    static let command = SimpleCommand(
        name: "general",
        synopsis: "Print quotes about life in general.",
        action: action)

    @CommandAction(shadowGroups: ["lower upper"])
    private static func work(
        l lower: Flag, u upper: Flag, _ count: Count,
        help: MetaFlag = MetaFlag(helpElements: helpForGeneralCQuotes)
    ) {
        let formatter = PhraseFormatter(upper: upper, lower: lower)
        printQuotesWith(formatter, count: count, quotes: generalQuotes)
    }

}
