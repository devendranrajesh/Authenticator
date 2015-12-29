//
//  SegmentedControlRowModel.swift
//  Authenticator
//
//  Copyright (c) 2015 Authenticator authors
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import OneTimePassword

protocol SegmentedControlRowModel {
    typealias Action

    var segments: [(title: String, action: Action)] { get }
    var selectedSegmentIndex: Int? { get }
}

enum TokenType {
    case Counter, Timer
}

struct TokenTypeRowModel<Action>: SegmentedControlRowModel {
    let segments: [(title: String, action: Action)]
    let selectedSegmentIndex: Int?

    init(value: TokenType, @noescape changeAction: (TokenType) -> Action) {
        let options = [
            (title: "Time Based", value: TokenType.Timer),
            (title: "Counter Based", value: TokenType.Counter),
        ]
        segments = options.map({ option in
            (title: option.title, action: changeAction(option.value))
        })
        selectedSegmentIndex = options.map({ $0.value }).indexOf(value)
    }
}

struct DigitCountRowModel<Action>: SegmentedControlRowModel {
    let segments: [(title: String, action: Action)]
    let selectedSegmentIndex: Int?

    init(value: Int, @noescape changeAction: (Int) -> Action) {
        let options = [
            (title: "6 Digits", value: 6),
            (title: "7 Digits", value: 7),
            (title: "8 Digits", value: 8),
        ]
        segments = options.map({ option in
            (title: option.title, action: changeAction(option.value))
        })
        selectedSegmentIndex = options.map({ $0.value }).indexOf(value)
    }
}

struct AlgorithmRowModel<Action>: SegmentedControlRowModel {
    let segments: [(title: String, action: Action)]
    let selectedSegmentIndex: Int?

    init(value: Generator.Algorithm, @noescape changeAction: (Generator.Algorithm) -> Action) {
        let options = [
            (title: "SHA-1", value: Generator.Algorithm.SHA1),
            (title: "SHA-256", value: Generator.Algorithm.SHA256),
            (title: "SHA-512", value: Generator.Algorithm.SHA512),
        ]
        segments = options.map({ option in
            (title: option.title, action: changeAction(option.value))
        })
        selectedSegmentIndex = options.map({ $0.value }).indexOf(value)
    }
}
