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

typealias TextFile = String
typealias Directory = String
typealias Path = String

struct Files {

    static let command = SimpleCommand(
        name: "files", synopsis: "Print file names passed in from the command line.",
        action: action, config: actionConfig())

    @CommandAction
    private static func values(
        directory: Directory = "default_directory",
        file: TextFile = "default_file",
        _ paths: Variadic<Path>,
        h__help help: MetaFlag = MetaFlag(helpElements: helpElements)) throws
    {
        print("directory", directory)
        print("file: ", file)
        print("paths", paths)
    }

    private static let helpElements: [ShowElement] = [
        .text("DESCRIPTION\n", "Print file names passed in from the command line."),
        .synopsis("\nUSAGE\n"),
        .text("\nARGUMENTS"),
        .parameter("paths", "One or more file paths", .path),
        .text("\nOPTIONS"),
        .parameter("file", "A file with extension \"txt\"", .file("*.txt")),
        .parameter("directory", "A directory with name starting with \"S\"", .directory("S*")),
        .parameter("help", "Show this help message"),
    ]
}
