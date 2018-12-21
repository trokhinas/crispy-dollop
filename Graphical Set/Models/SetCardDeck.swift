//
//  SetDeckCards.swift
//  Set
//
//  Created by xcode on 30.11.2018.
//  Copyright © 2018 VSU. All rights reserved.
//

import Foundation

struct SetCardDeck {
    
    private(set) var cards = [SetCard]()
    
    init() {
        for number in Type.all {
            for color in Type.all {
                for symbol in Type.all {
                    for fill in Type.all {
                        cards.append(SetCard(num: number, col: color, sym: symbol, fill: fill))
                    }
                }
            }
        }
    }
    
    mutating func draw() -> SetCard? {
        if(cards.count > 0) {
            return cards.remove(at: cards.count.acr4random)
        }
        return nil
    }
}
