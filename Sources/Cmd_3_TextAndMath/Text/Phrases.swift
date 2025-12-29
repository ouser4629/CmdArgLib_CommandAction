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

typealias Phrase = String

struct Phrases {

    static let command = StatefulCommand<GlobalOptions>(
        name: ".phrases",
        synopsis: "Print sorted phrases.",
        action: action,
        config: actionConfig()
    )

    @CommandAction
    private static func work(
        o__order sortOrder: SortOrder,
        _ phrases: Variadic<Phrase>,
        h__help help: MetaFlag = MetaFlag(helpElements: phrasesHelp),
        nodePath: [StatefulCommand<GlobalOptions>],
        state: [GlobalOptions]
    ) -> [GlobalOptions] {
        printBlame(state)
        var sortedPhrases = phrases
        switch sortOrder {
        case .asIs: break
        case .ascending: sortedPhrases.sort(by: <)
        case .descending: sortedPhrases.sort(by: >)
        }
        let lines = [sortedPhrases.joinedWith(quoteChar: "'")]
        printLines(lines, state: state)
        exit(EXIT_SUCCESS)
    }

    private static let phrasesHelp: [ShowElement] = [
        .text("DESCRIPTION:", "Print some $E{phrases}s."),
        .synopsis("\nUSAGE:"),
        .text("\nOPTION:"),
        .parameter("sortOrder", "The sort order for printing the phrases."),
        .parameter("help","Show this screen."),
        .text("\nNOTE:\n", "The available sort orders are \(SortOrder.casesJoinedWith("and"))."),
    ]
}
