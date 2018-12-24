//
//  ViewController.swift
//  Graphical Set
//
//  Created by xcode on 21.12.2018.
//  Copyright © 2018 VSU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //-----MODEL-----//
    private var model = SetGame()
    
    //-----GAME TABLE (VIEW)-----//
    @IBOutlet weak var gameTable: Table!
    
    //-----COLOR CONSTANTS-----//
    private var cardColor: UIColor = #colorLiteral(red: 0.714486698, green: 0.7708367465, blue: 0.7669996681, alpha: 1)
    private var bgColor: UIColor = #colorLiteral(red: 0.9058823529, green: 0.8650250873, blue: 0.8585260985, alpha: 1)
    
    //-----BODRED COLOR CONSTANTS-----//
    private let selectBorderColor = UIColor.blue.cgColor
    private let setBorderColor = UIColor.green.cgColor
    private let notSetBorderColor = UIColor.red.cgColor
    private let hintBorderColor = UIColor.orange.cgColor
    
    // Gesture

    //
    
    
    //-----BUTTONS-----//
    @IBOutlet weak var dealButton: UIButton!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    
    //-----ACTIONS-----//
    @IBAction func HintButton(_ sender: SetCardView) {
        var hints = model.hint()
//        if(hints.count != 0) {
//            for i in 0...2 {
//                hintCard(index: model.displayedCards.index(of: hints[i])!)
//            }
//        }
        updateScore()
    }
    @IBAction func deal3CardsButton(_ sender: SetCardView) {
        model.deal()
        updateViewFromModel()
        
    }
    @IBAction func NewGameButton(_ sender: SetCardView) {
        model = SetGame()
        updateViewFromModel()
    }
    
    //----LABELS-----//
    @IBOutlet weak var ScoreLabel: UILabel! {
        didSet{
            updateScore()
        }
    }
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var cardsInDeck: UILabel!
    
    //-----MAIN ACTION-----//
    @IBAction func touchCard(_ sender: SetCardView) {
        
    }
    
    //-----XCODE GENERATED FUNCTIONS-----//
    override func viewDidLoad() {
        super.viewDidLoad()
        //updateViewFromModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    private func updateViewFromModel(){
        updateCardsFromModel()
        
        updateButtons()
        updateScore()
        updateDeckCount()
        checkWinner()
    }
    private func updateCardsFromModel() {
        if gameTable.cardsCount - model.cardsModelCount > 0 {
            let cardView = gameTable.cardViews[..<model.cardsModelCount]
            gameTable.cardViews = Array(cardView)
        }
        let numberCardViews =  gameTable.cardViews.count
        
        for index in model.displayedCards.indices {
            let card = model.displayedCards[index]
            if  index > (numberCardViews - 1) { // new cards
                
                let cardView = SetCardView()
                updateCardView(cardView,for: card)
                addTapGestureRecognizer(for: cardView) // gesture tap
                gameTable.cardViews.append(cardView)
                
            } else {                                // old cards(0лды тут B))
                let cardView = gameTable.cardViews[index]
                updateCardView(cardView,for: card)
            }
        }
    }
    
    //rename
    private func addTapGestureRecognizer(for cardView: SetCardView) {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tapCard(recognizedBy:))
        )
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        cardView.addGestureRecognizer(tap)
    }
        
    @objc
    private func tapCard(recognizedBy recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            if let cardView = recognizer.view! as? SetCardView {
                model.chooseCard(at: gameTable.cardViews.index(of: cardView)!)
            }
        default:
            break;
        }
        updateViewFromModel()
    }
    private func updateCardView(_ cardView: SetCardView, for card: SetCard) {
        cardView.symbol = card.symbol
        cardView.fill = card.fill
        cardView.count = card.count
        cardView.color = card.color
        cardView.isSelected =  model.selectedCards.contains(card)
        if let itIsSet = model.isSet {
            if model.selectedCards.contains(card) {
                cardView.isMatched = itIsSet
            }
        } else {
            cardView.isMatched = nil
        }
    }

    
    //-----LABEL SECTION-----//
    //-----Она очень тупая и я не знаю как ее красиво убрать-----//
    private func updateButtons() {
        //проверить корректностт
        dealButton.isEnabled = !model.deckIsEmpty && !(model.displayedCards.count == gameTable.cardViews.count)
    }
    private func updateScore() {
        ScoreLabel.text = ("Score: " + String(model.Score))
    }
    private func updateDeckCount() {
        cardsInDeck.text = ("Cards in deck:" + String(model.deckOfCards.cards.count))
    }
    private func checkWinner() {
        let condition = model.isWin
        
        if(condition) {
            winnerLabel.text = "YOU ARE WINNER"
        }
        else {
            winnerLabel.text = ""
        }
    }
    
    //-----BORDER SECTION-----//
    //-----Она очень тупая и я не знаю как ее красиво убрать-----//
//    private func selectCard(index: Int) {
//        let button = Cards[index]
//        button.borderStatus = BorderStatus.selected
//    }
//    private func hintCard(index: Int) {
//        let button = Cards[index]
//        button.borderStatus = BorderStatus.hint
//        button.setCard = model.displayedCards[index]
//    }
//    private func selectAsSetOrNot(index: Int) {
//        let button = Cards[index]
//        if(model.isSet)! {
//            button.borderStatus = BorderStatus.setMatched
//        }
//        else{
//            button.borderStatus = BorderStatus.setNotMathced
//        }
//    }
//    private func deselectCard(index: Int) {
//        let button = Cards[index]
//        button.borderStatus = BorderStatus.deselected
//    }
    
    
    
}

