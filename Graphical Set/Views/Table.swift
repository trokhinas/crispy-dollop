//
//  Table.swift
//  Graphical Set
//
//  Created by xcode on 21.12.2018.
//  Copyright © 2018 VSU. All rights reserved.
//

import Foundation
import UIKit

class Table: UIView {
    
    override func draw(_ rect: CGRect) {
        let roundRect = UIBezierPath(roundedRect: bounds, cornerRadius: 16)
        roundRect.addClip()
        
        UIColor.white.setFill()
        roundRect.fill()
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: rect.midX, y:rect.midY), radius: CGFloat(199), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        UIColor.black.setFill()
        circlePath.fill()
        
    }
}
