//
//  Table.swift
//  Graphical Set
//
//  Created by xcode on 21.12.2018.
//  Copyright © 2018 VSU. All rights reserved.
//

import Foundation
import UIKit

class Table: UIView{
    
 
    var cardViews = [SetCardView](){
        // ПОСМОТРЕТЬ ЧТО ЭТО!
        willSet {removeSubviews()}
        didSet {addSubviews()}
    }
    var cardsCount: Int {
        return cardViews.count
    }
    
    private func removeSubviews(){
        for card in cardViews {
            card.removeFromSuperview()
        }
    }
    
    private func addSubviews() {
        for card in cardViews{
            card.addSubview(card)
        }
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        var cardsPlacing = Grid(
            layout: Grid.Layout.aspectRatio(Constant.cellAspectRatio),
            frame: bounds)
        //передаем количество ячеек в нашу сетку - количество SetCardView
        cardsPlacing.cellCount = cardViews.count
        for row in 0..<cardsPlacing.dimensions.rowCount {
            for column in 0..<cardsPlacing.dimensions.columnCount {
                if cardViews.count > (row * cardsPlacing.dimensions.columnCount + column) {
                    
                    cardViews[row * cardsPlacing.dimensions.columnCount + column].frame = cardsPlacing[row,column]!.insetBy(
                        dx: Constant.spacingDx, dy: Constant.spacingDy)
                }
            }
        }
    }
    
    struct Constant {
        static let cellAspectRatio: CGFloat = 0.7
        static let spacingDx: CGFloat  = 3.0
        static let spacingDy: CGFloat  = 3.0
    }
    
    override func draw(_ rect: CGRect) {
        layoutSubviews()
    }
}
