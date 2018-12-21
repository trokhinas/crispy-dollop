//
//  Int.swift
//  Set
//
//  Created by xcode on 30.11.2018.
//  Copyright © 2018 VSU. All rights reserved.
//

import Foundation

extension Int {
    var acr4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}
