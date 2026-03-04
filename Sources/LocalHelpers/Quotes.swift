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

public typealias Count = Int
public typealias Author = String
public typealias Quote = String

public let generalQuotes: [(String, Author)] = [
    ("Simplicity is complexity resolved.", "Constantin Brancusi"),
    ("Well done is better than well said.", "Benjamin Franklin"),
    ("Where all think alike, no one thinks very much.", "Walter Lippmann"),
]

public let computingQuotes: [(Quote, Author)] = [
    ("It is much more rewarding to do more with less.", "Donald Knuth"),
    ("Programming is a skill best acquired by practice and example rather than from books.", "Alan Turing"),
    ("If a machine is expected to be infallible, it cannot also be intelligent.", "Alan Turing"),
]

public func printQuotesWith(_ formatter: PhraseFormatter, count: Count, quotes: [(String, Author)]) {
    let end = min(max(count, 1), quotes.count)
    let lines = quotes.shuffled()[0..<end].map { "  \($0.0) - \($0.1)" }
    print("Quote\(lines.count > 1 ? "s" : "")")
    let format = formatter.format(wordsIn:)
    lines.map(format).forEach { print($0) }
}
