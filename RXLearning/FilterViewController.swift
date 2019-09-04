//
//  FilterViewController.swift
//  RXLearning
//
//  Created by 谢雷 on 2019/9/2.
//  Copyright © 2019 谢雷. All rights reserved.
//

import UIKit
import CoreImage

typealias Filter = (CIImage) -> CIImage

infix operator >>>

func >>>(filter1: @escaping Filter, filter2: @escaping Filter) -> Filter {
    return { image in filter2(filter1(image))}
}


class FilterViewController: UIViewController {
    
    /// 高斯模糊滤镜
    ///
    /// - Parameter radius: 弧度
    /// - Returns: Filter函数
    func blur(radius: Double) -> Filter {
        return { image in
            let parameters: [String: Any] = [
                kCIInputRadiusKey: radius,
                kCIInputImageKey: image
            ]
            guard let filter = CIFilter(name: "CIGaussianBlur", parameters: parameters) else {
                fatalError()
            }
            guard let outputImage = filter.outputImage else {
                fatalError()
            }
            return outputImage
        }
    }
    
    
    /// 固定颜色的滤镜
    ///
    /// - Parameter color: 颜色
    /// - Returns: Filter函数
    func generate(color: UIColor) -> Filter {
        return { _ in
            let parameters = [kCIInputColorKey : CIColor(cgColor: color.cgColor)]
            guard let filter = CIFilter(name: "CIConstantColorGenerator", parameters: parameters) else {
                fatalError()
            }
            guard let outputImage = filter.outputImage else {
                fatalError()
            }
            return outputImage
        }
    }
    
    
    /// 图像覆盖合成滤镜
    ///
    /// - Parameter overlay: 覆盖源
    /// - Returns: Filter函数
    func compositeSourceOver(overlay: CIImage) -> Filter {
        return { image in
            let parameters: [String: Any] = [
                kCIInputBackgroundImageKey: image,
                kCIInputImageKey: overlay
            ]
            guard let filter = CIFilter(name: "CISourceOverCompositing", parameters: parameters) else {
                fatalError()
            }
            guard let outputImage = filter.outputImage else {
                fatalError()
            }
            return outputImage.cropped(to: image.extent)
        }
    }
    
    func overlay(color: UIColor) -> Filter {
        return { image in
            let overlay = self.generate(color: color)(image).cropped(to: image.extent)
            return self.compositeSourceOver(overlay: overlay)(image)
        }
    }
    
    func compose(filter filter1: @escaping Filter, with filter2: @escaping Filter) -> Filter {
        return { image in filter2(filter1(image))}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = URL(string: "http://via.placeholder.com/500x500")
        if let url = url {
            let image = CIImage(contentsOf: url)
            let radius = 5.0
            let color = UIColor.red.withAlphaComponent(0.2)
            if let image = image {
//                let blurredImage = self.blur(radius: radius)(image)
//                let overlayedImage = self.overlay(color: color)(blurredImage)
                
//                let overlayedImage = self.overlay(color: color)(self.blur(radius: radius)(image))
                
//                let blurAndOverlay = compose(filter: blur(radius: radius), with: overlay(color: color))
                let blurAndOverlay = blur(radius: radius) >>> overlay(color: color)
                let overlayedImage = blurAndOverlay(image)
                
                let imageView = UIImageView(image: UIImage(ciImage: overlayedImage))
                imageView.frame = CGRect(x: 100, y: 100, width: 200, height: 200);
                self.view.addSubview(imageView)
            }
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
