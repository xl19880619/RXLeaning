//
//  TypeViewController.swift
//  RXLearning
//
//  Created by 谢雷 on 2019/9/3.
//  Copyright © 2019 谢雷. All rights reserved.
//

import UIKit

class TypeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //简单的数组循环
    public func increment(array: [Int]) -> [Int] {
        var result: [Int] = []
        array.forEach { (value) in
            result.append(value + 1)
        }
        return result
    }
    
    public func double(array: [Int]) -> [Int] {
        var result: [Int] = []
        array.forEach { (value) in
            result.append(value * 2)
        }
        return result
    }
    
    func compute(array: [Int], transform:((Int) -> Int)) -> [Int] {
        var result: [Int] = []
        array.forEach { (value) in
            result.append(transform(value))
        }
        return result
    }
    
    public func double2(array: [Int]) -> [Int] {
//        return array.map{return $0 * 2}
        return compute(array: array){return $0 * 2}
    }
    
    func isEven(array: [Int]) -> [Bool] {
        return genericCompute(array: array){return $0 % 2 == 0}
    }
    
    func genericCompute<T>(array: [Int], transform: (Int) -> T) -> [T] {
//        return array.map({ (value) -> T in
//            transform(valu)
//        })
        return array.map(transform);
//        var result: [T] = []
//        array.forEach { (value) in
//            result.append(transform(value))
//        }
//        return result
    }
    

    let exampleFiles = ["Readme.md","HelloWorld.swift","FlappyBird.swift"]
    
    func getSwiftFiles(in files: [String]) -> [String] {
//        var result: [String] = []
//        files.forEach { (name) in
//            if name.hasSuffix("swift") {
//                result.append(name)
//            }
//        }
//        return result
        return files.filter{ file in file.hasSuffix("swift") }
    }
    
    func productUsingReduce(integers: [Int]) -> Int {
        return integers.reduce(1, combine: *)
    }
    
    func concatUsingReduce(strings: [String]) -> String {
        return strings.reduce("", combine: { (result, element) -> String in
            return result + element
        })
        
        return strings.reduce("", combine: +)
    }


}

extension Array {
    func map<T>(_ transform: (Element) -> T) -> [T] {
        var result: [T] = []
        self.forEach { (value) in
            result.append(transform(value))
        }
        return result
    }
    
    func filter(_ includeElement: (Element) -> Bool) -> [Element] {
        var result: [Element] = []
        for value in self where includeElement(value) {
            result.append(value)
        }
//        self.forEach { (value) in
//            if includeElement(value) {
//                result.append(value)
//            }
//        }
        return result
    }
    
    func reduce<T>(_ initial: T, combine: (T, Element) -> T) -> T {
        var result = initial
        self.forEach { (value) in
            result = combine(result, value)
        }
        return result
    }
}
