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

typealias Name = String

struct Text {

    static let command = StatefulCommand<GlobalOptions>(
        name: ".text",
        synopsis: "Print phrase and quotes",
        config: actionConfig(),
        showElements: textHelp,
        action: Self.action,
        children: [Phrases.command, Quotes.command])

    @CommandAction(shadowGroups: ["lower upper"])
    private static func work(
        l lower: Flag,
        u upper: Flag,
        help: MetaFlag = MetaFlag(helpElements: textHelp),
        nodePath: [StatefulCommand<GlobalOptions>],
        state: [GlobalOptions]
    ) throws -> [GlobalOptions] {
        let textFormat = PhraseFormatter(upper: upper, lower: lower)
        var newState = state.first ?? GlobalOptions()
        newState.textFormat = textFormat
        return [newState]
    }

    private static let textHelp: [ShowElement] = [
        .text("DESCRIPTION:", "Print phrases or quotes by famous people."),
        .synopsis("\nUSAGE:"),
        .text("\nOPTIONS:"),
        .parameter("lower", "Lowercase the output"),
        .parameter("upper", "Uppercase the output"),
        .text("\nNOTE:\n", "The $L{lower} and $L{upper} options shadow each other."),
    ]
}
