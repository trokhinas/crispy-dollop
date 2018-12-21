//
//  String.swift
//  Set
//
//  Created by xcode on 10.12.2018.
//  Copyright © 2018 VSU. All rights reserved.
//

import Foundation

extension String {
    func multiplyString(n: Int, with separator: String) -> String {
        if n <= 1  {return self}
        
        var result = [String] ()
        for _ in 1...n {
            result.append(self)
        }
        //превращает массив в строку, вставляя сепаратор между каждой парой элементов
        return result.joined(separator: separator)
    }
}
