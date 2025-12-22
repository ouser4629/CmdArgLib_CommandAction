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

public struct GlobalOptions: Sendable {
    public var userName: String?
    public var verbose: Bool
    public var textFormat: PhraseFormatter
    public var mathOptions: MathOptions
    public init(name: String? = nil, verbose: Bool = false) {
        self.userName = name
        self.verbose = verbose
        self.textFormat = PhraseFormatter()
        self.mathOptions = MathOptions()
    }
    init() {
        self.init(name: nil, verbose: false)
    }
}

public struct MathOptions: Sendable {
    public let formatStyle: FloatingPointFormatStyle<Double>
    public init(decimals: Int = 2, group: Bool = true) {
        var style = FloatingPointFormatStyle<Double>(locale: Locale(identifier: "en_US"))
        style = style.precision(.fractionLength(decimals...decimals))
        self.formatStyle = style.grouping(group ? .automatic : .never)
    }
}

public struct PhraseFormatter: Sendable {
    private let upper: Bool
    private let lower: Bool

    public init(upper: Bool = false, lower: Bool = false) {
        self.upper = upper
        self.lower = lower
    }

    public func format(_ string: String) -> String {
        upper ? string.uppercased() : lower ? string.lowercased() : string
    }
}
