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
import Foundation
import LocalHelpers

public enum Operation: String, RawRepresentable, CaseIterable, BasicParameterType {
    case add, mult
    public var description: String { self.rawValue }
}

let operations = Operation.allCases.map { $0.rawValue }.joinedWith("or")

enum SortOrder: String, CustomStringConvertible, RawRepresentable, BasicParameterType, CaseIterable, Sendable {
    case ascending, descending, asIs
    var description: String { rawValue }
}

let sortOrderCases = SortOrder.allCases.map { $0.rawValue }.joined(separator: " ")

let sortOrderList = SortOrder
    .allCases.map { $0.rawValue }
    .joinedWith("or", quoteChar: "\"", separator: ", ")

typealias Number = Double

func printBlame(_ state: [GlobalOptions]) {
    if let globalState = state.last, let name = globalState.userName, globalState.verbose {
        print("DISCLAIMER:\n  This was requested by \(name), a complete unknown.")
    }
}

func printLines(_ lines: [String], state: [GlobalOptions]) {
    if let globalState = state.last {
        for line in lines {
            print(globalState.textFormat.format(line))
        }
    }
}

func mathWork(
    positiveOnly: Bool,
    negativeOnly: Bool,
    operation: Operation,
    doubles: [Double],
    formatStyle: FloatingPointFormatStyle<Double>
) async throws {
    var validationErrors: [String] = []
    if doubles.count > 5 {
        validationErrors.append("At most 5 operands are allowed.")
    }
    if positiveOnly && !(doubles.allSatisfy { $0 >= 0 }) {
        validationErrors.append("All doubles must be positive.")
    } else if negativeOnly && !(doubles.allSatisfy { $0 < 0 }) {
        validationErrors.append("All doubles must be negative.")
    }
    if !validationErrors.isEmpty {
        throw Exception(formattedErrors: validationErrors)
    }
    try await Task.sleep(nanoseconds: 1_000_000)
    let result: Double
    switch operation {
    case .add: result = doubles.reduce(0, +)
    case .mult: result = doubles.reduce(1, *)
    }
    let formattedResult = formatStyle.format(result)
    print("\(operation): \(formattedResult)")
}

func mathHelpFor(_ operation: Operation) -> [ShowElement] {
    let opWord: String
    switch operation {
    case .add: opWord = "Add"
    case .mult: opWord = "Multiply"
    }

    let help: [ShowElement] = [
        .text("DESCRIPTION:", "\(opWord) elements of a list of up to five doubles."),
        .synopsis("\nUSAGE:"),
        .text("\nOPTIONS:"),
        .parameter("p", "All the doubles must be positive"),
        .parameter("n", "All doubles must be negative"),
        .parameter("help", "Show help information"),
    ]
    return help
}
