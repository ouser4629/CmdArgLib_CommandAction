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

typealias Greeting = String
typealias Name = String
typealias Count = Int

let note1 = """
    The default for $E{repeats} is a random integer between 1 and 3. 
    """

let note2 = """
    The $S{lower} and $S{upper} options shadow each other; only the last one specified 
    is applicable.
    """

let note3 = """
    Bracketed parameters in the synopsis line are not required because they have
    explicit or implied default values. The other parametets are required.
    """

let style = SymbolFormatter(textCase: .lower, snakeSeparator: "_", brackets: "<>")

struct Greet {

    @CommandAction(shadowGroups: ["lower upper"])
    private static func work(
        i includeIndex: Flag = false,
        u upper: Flag = false,
        l lower: Flag = false,
        c__count repeats: Count? = nil,
        g__greeting greeting: Greeting = "Hello",
        _ name: Name,
        authors: MetaFlag = MetaFlag(string: "Robert Ford and Jesse James"),
        h__help help: MetaFlag = MetaFlag(helpElements: helpElements)
    ) {
        let count = repeats == nil || repeats! < 1 ? (Int.random(in: 1...3)) : repeats!
        var text = "\(greeting) \(name)"
        text = lower ? text.lowercased() : upper ? text.uppercased() : text
        for index in 1...count {
            var text = (includeIndex ? "\(index) " : "") + "\(greeting) \(name)"
            if upper { text = text.uppercased() }
            print(text)
        }
    }

    static let command = SimpleCommand(
        name: "greet",
        synopsis: "Print a greeting.",
        action: action)

    private static let helpElements: [ShowElement] = [
        .text("DESCRIPTION:", "Print a greeting."),
        .synopsis("\nUSAGE:"),
        .text("\nPARAMETERS:"),
        .parameter("includeIndex", "Show index of repeated greetings"),
        .parameter("upper", "Print text in upper case"),
        .parameter("lower", "Print text in lower case"),
        .parameter("help", "Show this help message"),
        .parameter("repeats", "Repeat the greeting $E{repeats} times"),
        .parameter("greeting", "The greeting to print"),
        .parameter("name", "Name of person to greet, if any"),
        .text("\nNOTES:\n", note1),
        .text("\n", note2),
        .text("\n", note3),
    ]
}
