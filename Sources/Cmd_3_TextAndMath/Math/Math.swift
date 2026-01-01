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
import LocalHelpers

struct Math {

    static let command = StatefulCommand<GlobalOptions>(
        name: ".math",
        synopsis: "Run math commands.",
        action: action,
        children: [Add.command, Mult.command])

    @CommandAction
    private static func work(
        decimals: Int = 2,
        noGrouping: Flag,
        h__help help: MetaFlag = MetaFlag(helpElements: help),
        commandPath: [StatefulCommand<GlobalOptions>],
        state: [GlobalOptions]
    ) -> [GlobalOptions] {
        var newState = state.first ?? GlobalOptions()
        newState.mathOptions = MathOptions(decimals: decimals, group: !noGrouping)
        return [newState]
    }

    private static let help: [ShowElement] = [
        .text("DESCRIPTION:", "Do math stuff."),
        .synopsis("\nUSAGE:", trailer: "subcommand"),
        .text("\nOPTIONS:"),
        .parameter("help","Show this help screen"),
        .parameter("decimals", "Length of fraction part for printed numbers"),
        .parameter("noGrouping", "Supress grouping for printed numbers"),
        .text("\nSUBCOMMANDS:"),
        .commandNode(Add.command.asNode),
        .commandNode(Mult.command.asNode),
    ]
}

struct Add {

    @CommandAction(shadowGroups: ["p n"])
    private static func work(
        p: Flag,
        n: Flag,
        _ doubles: Variadic<Double>,
        h__help help: MetaFlag = MetaFlag(helpElements: help),
        commandPath: [StatefulCommand<GlobalOptions>],
        state: [GlobalOptions]
    ) async throws {
        printBlame(state)
        let fs = (state.first ?? GlobalOptions()).mathOptions.formatStyle
        try await mathWork(
            positiveOnly: p, negativeOnly: n, operation: .add, doubles: doubles, formatStyle: fs)
    }

    private static let help = mathHelpFor(.add)

    static let command = StatefulCommand<GlobalOptions>(
        name: ".add",
        synopsis: "Add a list of doubles.",
        action: action)
}

struct Mult {
    @CommandAction(shadowGroups: ["p n"])
    private static func work(
        p: Flag,
        n: Flag,
        _ doubles: Variadic<Double>,
        h__help help: MetaFlag = MetaFlag(helpElements: help),
        commandPath: [StatefulCommand<GlobalOptions>],
        state: [GlobalOptions]
    ) async throws {
        printBlame(state)
        let fs = (state.first ?? GlobalOptions()).mathOptions.formatStyle
        try await mathWork(
            positiveOnly: p, negativeOnly: n, operation: .mult, doubles: doubles, formatStyle: fs)
    }

    private static let help = mathHelpFor(.mult)

    static let command = StatefulCommand<GlobalOptions>(
        name: ".mult",
        synopsis: "Multiply a list of doubles.",
        action: action)
}
