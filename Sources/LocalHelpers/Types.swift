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
import Foundation

public enum PhraseFormat: String, BasicParameterEnum {
    case red, yellow, underlined
}

public struct PhraseFormatter: Sendable {
    private let upper: Bool
    private let lower: Bool
    public let phraseFormat: PhraseFormat?

    public init(upper: Bool = false, lower: Bool = false, phraseFormat: PhraseFormat? = nil) {
        self.upper = upper
        self.lower = lower
        self.phraseFormat = phraseFormat
    }

    public func format(words: [String]) -> [String] {
        var formatted =
            if upper {
                words.map { $0.uppercased() }
            } else if lower {
                words.map { $0.lowercased() }
            } else {
                words
            }
        if let phraseFormat {
            var startCode = 97 // white
            var endCode = 0 // For colors
            switch phraseFormat {
            case .red: startCode = 31
            case .yellow: startCode = 33
            case .underlined: startCode = 4; endCode = 24
            }
            formatted = formatted.map{"\u{001B}[\(startCode)m\($0)\u{001B}[\(endCode)m"}
        }
     return formatted
    }

    public func format(wordsIn phrase: String) -> String {
        format(words: phrase.components(separatedBy: .whitespaces)).joined(separator: " ")
    }
}
