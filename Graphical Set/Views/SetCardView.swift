//
//  SetButton.swift
//  Set
//
//  Created by xcode on 10.12.2018.
//  Copyright © 2018 VSU. All rights reserved.
//

import Foundation
import UIKit

class SetCardView: UIView {
    let defaultColor = #colorLiteral(red: 0.714486698, green: 0.7708367465, blue: 0.7669996681, alpha: 1)
    
    var symbol = Type.type1
    var fill = Type.type1
    var count = Type.type1
    var color = Type.type1
   
    
    
    @IBInspectable
    var isSelected: Bool = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var isMatched: Bool? { didSet { setNeedsDisplay(); setNeedsLayout() } }

    
    override func draw(_ rect: CGRect) {
        let roundRect = UIBezierPath(roundedRect: bounds, cornerRadius: 16)
        roundRect.addClip()
        
        UIColor.white.setFill()
        roundRect.fill()
    }
    public func drawButton() {
        drawBorder()
        
    }
    
    
    
    private func configureState() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        isOpaque = false
        contentMode = .redraw
        
//        layer.cornerRadius = cornerRadius
//        layer.borderWidth = borderWidth
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        // highlights selected card view
        if isSelected {
            layer.borderColor = BorderColorConstants.select
        }
        // highlights matched 3 cards
        if let matched = isMatched {
            if matched {
                layer.borderColor = BorderColorConstants.isSet
            } else {
                layer.borderColor = BorderColorConstants.notSet
            }
        }
    }
  
    
    
    private func drawBorder() {
        
    }
    
    // Изменить цвета!
    static let green = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
    static let red = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    static let purple = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
    
    struct BorderColorConstants {

        
        static let select = UIColor.blue.cgColor
        static let isSet = UIColor.green.cgColor
        static let notSet = UIColor.red.cgColor
        static let hint = UIColor.orange.cgColor
        static let deselect = UIColor.clear.cgColor
        
        
    }
}

