//
//  QuickCheck.swift
//  RXLearning
//
//  Created by 谢雷 on 2019/9/5.
//  Copyright © 2019 谢雷. All rights reserved.
//

import Foundation
import UIKit

func plusIsComutative(x: Int, y: Int) -> Bool {
    return x + y == y + x
}

protocol Smaller {
    func smaller() -> Self?
}

protocol Arbitrary: Smaller {
    static func arbitrary() -> Self
}

extension Int: Arbitrary {
    static func arbitrary() -> Int {
        return Int(arc4random())
    }
    
    func smaller() -> Int? {
        return self == 0 ? nil : self / 2
    }
    
    static func arbitrary(in range: CountableRange<Int>) -> Int {
        let diff = range.upperBound - range.lowerBound
        return range.lowerBound + (Int.arbitrary() % diff)
    }
}

extension UnicodeScalar: Arbitrary {
    static func arbitrary() -> Unicode.Scalar {
        return UnicodeScalar(Int.arbitrary(in: 65 ..< 90))!
    }
    
    func smaller() -> Unicode.Scalar? {
        return nil
    }
}

extension String : Arbitrary, Smaller {
    static func arbitrary() -> String {
        let randomLength = Int.arbitrary(in: 0 ..< 40)
        let randomScalars = (0 ..< randomLength).map{_ in UnicodeScalar.arbitrary()}
        return String(UnicodeScalarView(randomScalars))
    }
    
    func smaller() -> String? {
        return isEmpty ? nil : String(self.dropFirst())
    }
}

let numberOfIteractions = 10

func check1<A: Arbitrary>(_ message: String, _ property:(A) -> Bool) -> () {
    for _ in 0 ..< numberOfIteractions {
        let value = A.arbitrary()
        guard property(value) else {
            print("\(message) doesn`t hold: \(value)")
            return
        }
        print("\(message) passed \(numberOfIteractions) tests.")
    }
}

extension CGSize {
    var area: CGFloat {
        return width * height
    }
}

extension CGSize: Arbitrary {
    static func arbitrary() -> CGSize {
        return CGSize(width: Int.arbitrary(), height: Int.arbitrary())
    }
    
    func smaller() -> CGSize? {
        return CGSize(width: Int(width).smaller() ?? 0, height: Int(height).smaller() ?? 0)
    }
}

func iterate<A>(while condition:(A) -> Bool, initial: A, next: (A) -> A?) -> A {
    guard let x = next(initial), condition(x) else {
        return initial
    }
    return iterate(while: condition, initial: x, next: next)
}

func check2<A: Arbitrary>(_ message: String, _ property: (A) -> Bool) -> () {
    for _ in 0 ..< numberOfIteractions {
        let value = A.arbitrary()
        guard property(value) else {
            let smallerValue = iterate(while: {!property($0)}, initial: value){
                $0.smaller()
            }
            print("\(message) doesn`t hold:\(smallerValue)")
            return
        }
        print("\(message) passed \(numberOfIteractions) tests.")
    }
}

func qsort(_ input: [Int]) -> [Int] {
    var array = input
    if array.isEmpty {
        return []
    }
    let value = array.removeFirst()
    let left = array.filter{$0 < value}
    let right = array.filter{$0 > value}
    return qsort(left) + [value] + qsort(right)
}

extension Array: Smaller {
    func smaller() -> Array<Element>? {
        guard !isEmpty else {
            return nil
        }
        return Array(dropLast())
    }
}

extension Array where Element: Arbitrary {
    
}
