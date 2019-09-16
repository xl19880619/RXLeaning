//
//  DictionaryTests.swift
//  RXLearning
//
//  Created by 谢雷 on 2019/9/5.
//  Copyright © 2019 谢雷. All rights reserved.
//

import Foundation

//Dictionary<String, Int> ==== [String: Int]

infix operator ??

func ??<T>(optional: T?, defaultValue: @autoclosure () throws -> T) rethrows -> T {
    if let x = optional {
        return x
    } else {
        return try defaultValue()
    }
}

struct Order {
    let orderNumber: Int
    let person: Person?
}

struct Person {
    let name: String
    let address: Address?
}

struct Address {
    let streetdtName: String
    let city: String
    let state: String
}

let order = Order(orderNumber: 42, person: nil)

func query() -> String {
    if let state = order.person?.address?.state {
        print("state \(state)")
    } else {
        print("unknown")
    }

    return "OK"
}

let citiess = ["Paris": 2241, "Madrid": 3165, "Amsterdam": 826]

func switchTest() {
    
    let madridPopulation = citiess["Madrid"]
    
    switch madridPopulation {
        case 0?: print("Noboddy in Madrid")
        case (1 ..< 1000)?: print("Less than a million in Madrid")
        case let x?: print("\(x) people in Madird")
        case nil: print("We don`t know about Madrid")
    }

}

func increment(optional: Int?) -> Int? {
    return optional.map{ $0 + 1 }
}

func add(_ optionalX: Int?, _ optionalY: Int?) -> Int? {
    return optionalX.flatMap{ x in
        optionalY.flatMap{ y in
            return x + y
        }
    }
}

let capitals = [
    "France": "Paris",
    "Spain": "Madrid",
    "The Netherlands": "Amsterdam",
    "Belgium": "Brussels"
]

func populationOfCapital(country: String) -> Int? {
//    return capitals[country].flatMap{ capital in
//        citiess[capital].flatMap{ population in
//            return population * 1000
//        }
//    }
    return capitals[country].flatMap{ capital in citiess[capital]}.flatMap{ poplation in poplation * 1000}
}

extension Optional {
    func map<U>(_ transform: (Wrapped) -> U) -> U? {
        guard let x = self else { return nil }
        return transform(x)
    }
}
