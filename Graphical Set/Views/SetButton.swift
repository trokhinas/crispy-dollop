//
//  SetButton.swift
//  Set
//
//  Created by xcode on 10.12.2018.
//  Copyright © 2018 VSU. All rights reserved.
//

import Foundation
import UIKit

class SetButton: UIButton {
    let defaultColor = #colorLiteral(red: 0.714486698, green: 0.7708367465, blue: 0.7669996681, alpha: 1)
    let separator = " "
    var colors = [#colorLiteral(red: 0.9058823529, green: 0.1718198397, blue: 0.1607316637, alpha: 1), #colorLiteral(red: 0.5456089491, green: 0.2898029765, blue: 0.9058823529, alpha: 1), #colorLiteral(red: 0.06025670308, green: 0.8417556122, blue: 0.2083500489, alpha: 1)]
    var alphas:[CGFloat] = [1.00, 0.40, 0.15]
    var symbols = ["●", "■", "▲"]
    var strokeWidths:[CGFloat] = [ -8, 8, -8]
    
    var setCard: SetCard? {
        //отрисовка кнопки при передаче туда SetCard
        didSet{drawButton()}
        
    }
    
    
    private func drawButton() {
        if let card = setCard {
            let pictures = drawSymbols(setCard: card)
            setAttributedTitle(pictures, for: UIControlState.normal)
            backgroundColor = defaultColor
            isEnabled = true
        }
        else{
            setAttributedTitle(nil, for: UIControlState.normal)
            setTitle(nil, for: UIControlState.normal)
            backgroundColor = UIColor.clear
            layer.borderColor = UIColor.clear.cgColor
            isEnabled = false
        }
    }
    
    private func drawSymbols(setCard: SetCard) -> NSAttributedString {
        // он на нас ругался и заставил поставить селф и мы не знаем почему :c
        let symbol = self.symbols[setCard.symbol.index()]
        
        //формируем необходимое нам количество символов (см. Extensions)
        let attrString = symbol.multiplyString(n: setCard.number.rawValue, with: separator)
        
        let attr:[NSAttributedStringKey: Any] = [
            .strokeColor: colors[setCard.color.index()],
            .strokeWidth: strokeWidths[setCard.fill.index()],
            .foregroundColor: colors[setCard.color.index()].withAlphaComponent(alphas[setCard.fill.index()])
        ]
        
        return NSAttributedString(string: attrString, attributes: attr)
    }
}
