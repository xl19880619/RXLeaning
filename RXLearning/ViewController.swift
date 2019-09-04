//
//  ViewController.swift
//  RXLearning
//
//  Created by 谢雷 on 2019/9/2.
//  Copyright © 2019 谢雷. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print(TypeViewController().increment(array: [1,2,3]))
        
        /**
         筛选局面数量至少100万的城市，打印城市名字以及总人口列表
         */
        let string = cities.filter { $0.population > 1000 }.map { $0.scalingPopulation() }.reduce("City:Population") { (result, city) -> String in
                return result + "\n" + "\(city.name):\(city.population)"
        }
        print(string)
        
        

    }
    typealias detailActionCloser = (_ node : String?) -> ()
    var detailAction : ((_ node : String?) -> ())?

    
    func test(_ with: detailActionCloser) -> Void {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let action = self.detailAction {
            action("test")
        }
        
        self.test { (value) in
            if let value = value {
                print(value)
            }
        }
//        self.navigationController?.pushViewController(FilterViewController(), animated: true)
    }


}

