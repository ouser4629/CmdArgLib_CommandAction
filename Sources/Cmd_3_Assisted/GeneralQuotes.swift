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

struct GeneralQuotes {

    static let command = StatefulCommand<PhraseFormatter>(
        name: "general",
        synopsis: "Print quotes about life in general.",
        action: action,
        config: actionConfig())

    @CommandAction(shadowGroups: ["lower upper"])
    private static func general(
        l lower: Flag,
        u upper: Flag,
        _ count: Count,
        h__help: MetaFlag = MetaFlag(helpElements: help),
        state: [PhraseFormatter]
    ) {
        var newFormatter = state.first ?? PhraseFormatter()
        if lower || upper {
            newFormatter = PhraseFormatter(upper: upper, lower: lower, phraseFormat: newFormatter.phraseFormat)
        }
        printQuotesWith(newFormatter, count: count, quotes: generalQuotes)
    }

    private static let help: [ShowElement] = [
        .text("DESCRIPTION\n", "Print quotes about life in general."),
        .synopsis("\nUSAGE\n"),
        .text("\nOPTIONS"),
        .parameter("count", "The number of times to print the quote"),
        .parameter("lower", "Lowercase the output"),
        .parameter("upper", "Uppercase the output"),
        .parameter("h__help", "Show help information"),
        .text("\nNOTE\n", "The $L{lower} and $L{upper} options shadow each other."),
    ]
}
