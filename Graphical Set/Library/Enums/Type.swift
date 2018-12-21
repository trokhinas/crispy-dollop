//
//  Type.swift
//  Set
//
//  Created by xcode on 23.11.2018.
//  Copyright © 2018 VSU. All rights reserved.
//

import Foundation

enum Type : Int{
    
    case type1 = 1, type2, type3
    
    static var all: [Type] {
        return [.type1, .type2, .type3]
    }
    func index() -> Int {
        return self.rawValue - 1
    }
}
