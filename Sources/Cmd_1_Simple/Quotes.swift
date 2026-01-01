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
        config: actionConfig(),
        children: [GeneralQuotes.command, ComputingQuotes.command]
    )

    @CommandAction
    private static func quotes(
        h__help: MetaFlag = MetaFlag(helpElements: help),
        t__tree: MetaFlag = MetaFlag(treeFor: "quotes", synopsis: "Print some famous quotes."),
        m__manpage: MetaFlag = MetaFlag(manPageElements: manpage)
    ) {}

    private static let help: [ShowElement] = [
        .text("DESCRIPTION:", "Print some quotes."),
        .synopsis("\nUSAGE:", trailer: "subcommand"),
    ] + optionElements

    private static let manpage: [ShowElement] = [
        .prologue(description: "Print some quotes."),
        .synopsis("SYNOPSIS", trailer: "subcommand"),
    ] + optionElements

    private static let optionElements: [ShowElement] = [
        .text("\nOPTIONS"),
        .parameter("h__help", "Show help information"),
        .parameter("t__tree", "Show command tree"),
        .parameter("m__manpage", "Print manpage mdoc code"),
        .lines("\nSUBCOMMANDS"),
        .commandNode(ComputingQuotes.command.asNode),
        .commandNode(GeneralQuotes.command.asNode),
    ]
}

struct ComputingQuotes {

    static let command = SimpleCommand(
        name: "computing",
        synopsis: "Print quotes about computing.",
        action: action,
        config: actionConfig())

    @CommandAction(shadowGroups: ["lower upper"])
    private static func work(
        l lower: Flag, u upper: Flag, _ count: Count,
        help: MetaFlag = MetaFlag(helpElements: helpForComputingQuotes),
        m__manpage manpage: MetaFlag = MetaFlag(manPageElements: manpageForComputingQuotes)
    ) {
        let formatter = PhraseFormatter(upper: upper, lower: lower)
        printQuotesWith(formatter, count: count, quotes: computingQuotes)
    }
}

struct GeneralQuotes {

    static let command = SimpleCommand(
        name: "general",
        synopsis: "Print quotes about life in general.",
        action: action,
        config: actionConfig())

    @CommandAction(shadowGroups: ["lower upper"])
    private static func work(
        l lower: Flag, u upper: Flag, _ count: Count,
        h__help help: MetaFlag = MetaFlag(helpElements: helpForGeneralCQuotes),
        m__manpage manpage: MetaFlag = MetaFlag(manPageElements: manpageForGeneralCQuotes)
    ) {
        let formatter = PhraseFormatter(upper: upper, lower: lower)
        printQuotesWith(formatter, count: count, quotes: generalQuotes)
    }
}

let helpForComputingQuotes: [ShowElement] = [
    .text("DESCRIPTION:", "Print $T{count} quotes about computing."),
    .synopsis("\nUSAGE:"),
] + parameterlements

let manpageForComputingQuotes: [ShowElement] = [
    .prologue(description: "Print $T{count} quotes about computing."),
    .synopsis("SYNOPSIS"),
] + parameterlements

let helpForGeneralCQuotes: [ShowElement] = [
    .text("DESCRIPTION:", "Print $T{count} quotes about life in general."),
    .synopsis("\nUSAGE:"),
] + parameterlements

let manpageForGeneralCQuotes: [ShowElement] = [
    .prologue(description: "Print $T{count} quotes about life in general."),
    .synopsis("SYNOPSIS"),
] + parameterlements

let parameterlements: [ShowElement] = [
    .text("\nPARAMETERS"),
    .parameter("lower", "Lowercase the output"),
    .parameter("upper", "Uppercase the output"),
    .parameter("count", "Number of quotes to print"),
    .text("\nMETA-FLAGS"),
    .parameter("help", "Show this help message"),
    .parameter("manpage","Generate a manpage"),
    .text("\nNOTE", "The $L{lower} and $L{upper} options shadow each other."),
]
