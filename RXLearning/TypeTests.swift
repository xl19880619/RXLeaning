//
//  TypeTests.swift
//  RXLearning
//
//  Created by 谢雷 on 2019/9/4.
//  Copyright © 2019 谢雷. All rights reserved.
//

import Foundation

struct City {
    let name: String
    let population: Int
}

let paris = City(name: "Paris", population: 2241)
let madrid = City(name: "Madrid", population: 3165)
let amsterdam = City(name: "Amsterdam", population: 827)
let berlin = City(name: "Berlin", population: 3562)

let cities = [paris, madrid, amsterdam, berlin]

extension City {
    func scalingPopulation() -> City {
        return City(name: name, population: population * 1000)
    }
}


