//
//  ImmutableTests.swift
//  RXLearning
//
//  Created by 谢雷 on 2019/9/9.
//  Copyright © 2019 谢雷. All rights reserved.
//

import Foundation

struct PointStruct {
    var x: Int
    var y: Int
}

class PointClass {
    var x: Int
    var y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

func valueChange() -> Void {
    let structPoint = PointStruct(x: 1, y: 2)
    var sameStructPoint = structPoint
    sameStructPoint.x = 3
    
    let classPoint = PointClass(x: 1, y: 2)
    let sameClassPoint = classPoint
    sameClassPoint.x = 3
}

func setStructPointToOrigin(point: PointStruct) -> PointStruct {
    var newPoint = point
    newPoint.x = 0
    newPoint.y = 0
    return newPoint
}

func setClassPointToOrigin(point: PointClass) -> PointClass {
    point.x = 0
    point.y = 0
    return point
}

extension PointStruct {
    mutating func setStructToOrigin() {
        x = 0
        y = 0
    }
}
