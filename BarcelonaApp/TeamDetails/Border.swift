//
//  File.swift
//  BarcelonaApp
//
//  Created by Apple on 17.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import Swift
import UIKit

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        var border = CALayer()
        
        switch edge {
        case UIRectEdge.left:
            border.frame = CGRect(x:0,y:0,width: thickness, height: self.frame.size.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.size.width-thickness,y: 0, width: thickness, height: self.frame.size.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
    
}
