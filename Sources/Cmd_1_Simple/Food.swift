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


enum Cheese: String, BasicParameterEnum {case comté, gouda, roncal}
enum Bread: String, BasicParameterEnum {case baguette, multigrain, sourdough }
enum Wine: String, BasicParameterEnum {case bordeaux , rioja, sancerre }
enum Person: String, BasicParameterEnum {case manny , moe, jack }

typealias Table = Int
typealias Text = String

struct Food {

    static let command = SimpleCommand(
        name: "food", synopsis: "Print food items passed in from the command line.",
        action: action, config: actionConfig())

    @CommandAction
    private static func values(
        table: Table = 2,
        wines: Variadic<Wine> = [],
        cheese: [Cheese] = [],
        bread: Bread = .baguette,
        _ people: Variadic<Person> = [],
        upper: Flag = false,
        h__help help: MetaFlag = MetaFlag(helpElements: helpElements)) throws
    {
        print("table: ", table)
        print("wines", wines)
        print("cheese: ", cheese)
        print("bread: ", bread)
        print("people" , people)
        print("upper:", upper)
    }

    private static let helpElements: [ShowElement] = [
        .text("DESCRIPTION\n", "Print values passed in from the command line."),
        .customSynopsis("\nUSAGE\n", chunkLists: [["[<options>]", "<fruit>"]]),
        .text("\nARGUMENTS"),
        .parameter("people", Person.orCases("One or more of"), .list(Person.casesArray)),
        .text("\nOPTIONS"),
        .parameter("table", "The table number"),
        .parameter("wines", Wine.orCases("One or more of"), .list(Wine.casesArray)),
        .parameter("cheese", Cheese.orCases("One of", "(can be repeated)"), .list(Cheese.casesArray)),
        .parameter("bread", Bread.orCases("One of"), .list(Bread.casesArray)),
        .parameter("help", "Show this help message"),
    ]
}
