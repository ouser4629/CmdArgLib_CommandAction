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

typealias Author = String

struct Quotes {

    static let command = SimpleCommand(
        name: "quotes",
        synopsis: "Print quotes by famous people.",
        action: action,
        config: actionConfig(),
        children: [GeneralQuotes.command, ComputingQuotes.command])

    @CommandAction
    private static func work(
        h__help: MetaFlag = MetaFlag(helpElements: help)
    ) {}

    private static let help: [ShowElement] = [
        .text("DESCRIPTION\n", "Print quotes by famous people."),
        .synopsis("\nUSAGE\n", trailer: "subcommand"),
        .text("\nOPTION"),
        .parameter("h__help", "Show help information"),
        .text("\nSUBCOMMANDS"),
        .commandNode(GeneralQuotes.command.asNode),
        .commandNode(ComputingQuotes.command.asNode),
    ]
}
