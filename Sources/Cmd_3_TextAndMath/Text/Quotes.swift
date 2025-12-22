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
import Foundation
import LocalHelpers

typealias Author = String

struct Quotes {

    static let command = StatefulCommand<GlobalOptions>(
        name: ".quotes",
        synopsis: "Print some quotes",
        action: action,
        children: [GeneralQuotes.command, ComputingQuotes.command]
    )

    @CommandAction
    private static func work(
        h__help help: MetaFlag = MetaFlag(helpElements: help),
        nodePath: [StatefulCommand<GlobalOptions>],
        state: [GlobalOptions]
    ) throws -> [GlobalOptions] {
        return state
    }

    private static let help: [ShowElement] = [
        .synopsis("USAGE:", trailer: "subcommand"),
        .text("\nSUBCOMMANDS:"),
        .commandNode(GeneralQuotes.command.asNode),
        .commandNode(ComputingQuotes.command.asNode),
    ]
}

struct GeneralQuotes {

    static let command = StatefulCommand<GlobalOptions>(
        name: ".general",
        synopsis: "Print quotes about life in general.",
        action: action)

    @CommandAction
    private static func work(
        _ count: Count,
        h__help help: MetaFlag = MetaFlag(helpElements: quotesHelpFor("life in general")),
        nodePath: [StatefulCommand<GlobalOptions>],
        state: [GlobalOptions]
    ) -> [GlobalOptions] {
        guard let formatter = state.first else { fatalError() }
        printQuotesWith(formatter.textFormat, count: count, quotes: generalQuotes)
        return state
    }
}

struct ComputingQuotes {

    static let command = StatefulCommand<GlobalOptions>(
        name: ".computing",
        synopsis: "Print quotes about computing.",
        action: action)

    @CommandAction
    private static func work(
        _ count: Count,
        h__help help: MetaFlag = MetaFlag(helpElements: quotesHelpFor("computing")),
        nodePath: [StatefulCommand<GlobalOptions>],
        state: [GlobalOptions]
    ) -> [GlobalOptions] {
        guard let formatter = state.first else { fatalError() }
        printQuotesWith(formatter.textFormat, count: count, quotes: computingQuotes)
        return state
    }
}

func quotesHelpFor(_ topic: String) -> [ShowElement] {
    [
        .text("DESCRIPTION:", "Prin quotes about \(topic)."),
        .synopsis("\nUSAGE:"),
        .text("\nOPTIONS:"),
        .parameter("count", "The number of quotes to print"),
        .parameter("help", "Show this help message and exit"),
    ]
}
