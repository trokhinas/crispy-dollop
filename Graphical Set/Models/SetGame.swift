//
//  SetGame.swift
//  Graphical Set
//
//  Created by xcode on 21.12.2018.
//  Copyright © 2018 VSU. All rights reserved.
//

import Foundation
//
//  SetGame.swift
//  Set
//
//  Created by xcode on 09.11.2018.
//  Copyright © 2018 VSU. All rights reserved.
//

import Foundation


class SetGame  {
    //-----SCORE CONSTANTS-----//
    let selectPentalty: Int = -5
    let setConfirmedBonus: Int = 30
    let hintPenalty: Int = -15
    var Score: Int
    
    //-----WIN CONDITION-----//
    var isWin: Bool {
        get {
            return deckIsEmpty && hint().count == 0
        }
    }
    
    //-----DECK STRUCTURE-----//
    var deckOfCards = SetCardDeck()
    var deckIsEmpty: Bool {return deckOfCards.cards.isEmpty}
    
    //-----SET CALCULATING OPTIONAL-----//
    var isSet: Bool? {
        get
        {
            guard matchedCards.count == 3 else {return nil}
            return CheckSet(cards: matchedCards)
        }
        set
        {
            if newValue != nil {
                matchedCards = selectedCards
                selectedCards.removeAll()
            } else {
                matchedCards.removeAll()
            }
        }
    }
    
    //-----CARDS ARRAYS-----//
    var displayedCards = [SetCard]()
    var selectedCards = [SetCard]()
    var matchedCards = [SetCard]()
    var removedCards = [SetCard]()
    
    init() {
        print("initial cards: /n")
        for _ in 0...11 {
            let cardFromDeck = deckOfCards.draw()
            displayedCards.append(cardFromDeck!)
            print(cardFromDeck!)
        }
        Score = 0
    }
    
    func chooseCard(at index: Int) {
        //если индекс карты не попадает в отображаемые, например была кликнута несуществующая карта, которая не была почему-либо задизейблена
        if(!displayedCards.indices.contains(index)) {return}
        
        let card = displayedCards[index]
        if !removedCards.contains(card) {
            if isSet != nil {
                if isSet! { replaceOrRemove(); Score += setConfirmedBonus}
                isSet = nil
            }
            if selectedCards.count == 2 , !selectedCards.contains(card) {
                selectedCards += [card]
                isSet = CheckSet(cards: selectedCards)
                Score += selectPentalty
            }
            else if displayedCards.contains(card){
                //если карты нет - добавляем ее
                if(!selectedCards.contains(card)) {selectedCards += [card]; Score += selectPentalty}
                    //если есть - убираем
                else {selectedCards.remove(at: selectedCards.index(of: card)!)}
            }
        }
    }
    
    public func deal() {
        //если сет есть, то метод replaceOrRemove сам
        //возьмет 3 карты из колоды если это возможно
        if isSet != nil {
            if isSet! { replaceOrRemove(); Score += setConfirmedBonus}
            isSet = nil
        }
            //если сета нет, то требуется просто добавить 3 карты на стол, если это возможно
        else {
            if let deal = takeThreeCards() {
                displayedCards += deal
            }
        }
        
        
    }
    public func hint() -> [SetCard] {
        var hints = [SetCard]()
        for i in 0..<displayedCards.count {
            for j in (i + 1)..<displayedCards.count{
                for k in (j + 1)..<displayedCards.count
                {
                    let threeCards = [displayedCards[i], displayedCards[j], displayedCards[k]]
                    if(CheckSet(cards: threeCards)) {
                        hints.append(displayedCards[i])
                        hints.append(displayedCards[j])
                        hints.append(displayedCards[k])
                    }
                }
                
            }
        }
        //если подсказок нет, то штрафовать пользователя не за что
        if(!hints.isEmpty){
            Score += hintPenalty
        }
        return hints
    }
    private func replaceOrRemove() {
        if let newCards = takeThreeCards() {
            //replace
            for i in 0...2 {
                let index = displayedCards.index(of: matchedCards[i])
                displayedCards.remove(at: index!)
                displayedCards.insert(newCards[i], at: index!)
            }
        }
        else {
            //remove
            for i in 0...2 {
                let index = displayedCards.index(of: matchedCards[i])
                displayedCards.remove(at: index!)
            }
        }
        removedCards += matchedCards
        matchedCards.removeAll()
    }
    private func takeThreeCards() -> [SetCard]? {
        var cards = [SetCard]()
        
        for _ in 0...2 {
            if let card = deckOfCards.draw() {
                cards += [card]
            }
            else {return nil}// вообще такого не может произойти но на всякий случай
        }
        return cards
    }
    private func CheckSet(cards : [SetCard] ) -> Bool{
        if(cards.count != 3) {
            return false
        }
        
        let card1 = cards[0]
        let card2 = cards[1]
        let card3 = cards[2]
        
        //ОТВРАТИТЕЛЬНО!
        if (isSetParam(param1: card1.fill, param2: card2.fill, param3: card3.fill)) {
            if (isSetParam(param1: card1.color, param2: card2.color, param3: card3.color)) {
                if (isSetParam(param1: card1.number, param2: card2.number, param3: card3.number)) {
                    if (isSetParam(param1: card1.symbol, param2: card2.symbol, param3: card3.symbol)) {
                        return true
                    }
                }
            }
        }
        return false
        
    }
    
    private func isSetParam(param1: Type, param2: Type, param3: Type) -> Bool {
        if(param1 == param2 && param2 == param3){return true}
        else if(param1 != param2 && param1 != param3 && param3 != param2){return true}
        return false
    }
    
    
    
}
