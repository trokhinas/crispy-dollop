////
////  ViewController.swift
////  Graphical Set
////
////  Created by xcode on 21.12.2018.
////  Copyright © 2018 VSU. All rights reserved.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//}
//

//
//  ViewController.swift
//  Set
//
//  Created by xcode on 09.11.2018.
//  Copyright © 2018 VSU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //-----MODEL-----//
    private var model = SetGame()
    
    //-----COLOR CONSTANTS-----//
    private var cardColor: UIColor = #colorLiteral(red: 0.714486698, green: 0.7708367465, blue: 0.7669996681, alpha: 1)
    private var bgColor: UIColor = #colorLiteral(red: 0.9058823529, green: 0.8650250873, blue: 0.8585260985, alpha: 1)
    
    //-----BODRED COLOR CONSTANTS-----//
    private let selectBorderColor = UIColor.blue.cgColor
    private let setBorderColor = UIColor.green.cgColor
    private let notSetBorderColor = UIColor.red.cgColor
    private let hintBorderColor = UIColor.orange.cgColor
    
    
    
    //-----BUTTONS-----//
    @IBOutlet weak var dealButton: UIButton!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet var Cards: [SetButton]!
    
    //-----ACTIONS-----//
    @IBAction func HintButton(_ sender: SetButton) {
        var hints = model.hint()
        if(hints.count != 0) {
            print("hint")
            for i in 0...2 {
                hintCard(index: model.displayedCards.index(of: hints[i])!)
            }
        }
        else {
            print("no hint")
        }
        updateScore()
    }
    @IBAction func deal3CardsButton(_ sender: SetButton) {
        model.deal()
        updateViewFromModel()
        
    }
    @IBAction func NewGameButton(_ sender: SetButton) {
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
    @IBAction func touchCard(_ sender: SetButton) {
        if let cardNumber = Cards.index(of: sender) {
            model.chooseCard(at: cardNumber)
            updateViewFromModel()
            
        } else {
            print("choosen card is not in cardButton")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    private func updateViewFromModel(){
        updateButtons()
        updateScore()
        updateDeckCount()
        for i in Cards.indices {
            draw(index: i)
        }
        checkWinner()
    }
    private func updateButtons() {
        dealButton.isEnabled = !model.deckIsEmpty && !(model.displayedCards.count == Cards.count)
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
    private func draw(index: Int) {
        let button = Cards[index]
        //проверяем отображается ли эта карта
        if(index < model.displayedCards.count) {
            let currentCard = model.displayedCards[index]
            button.setCard = currentCard
            if(model.selectedCards.contains(currentCard)) {
                selectCard(index: index)
            }
            else if(model.matchedCards.contains(currentCard)) {
                selectAsSetOrNot(index: index)
            }
            else {
                deselectCard(index: index)
            }
        }
        else {button.setCard = nil}
    }
    private func selectCard(index: Int) {
        let button = Cards[index]
        
        button.layer.borderWidth = 3.0
        button.layer.borderColor = selectBorderColor
    }
    private func hintCard(index: Int) {
        let button = Cards[index]
        print("hint: " + String(index))
        button.layer.borderWidth = 3.0
        button.layer.borderColor = hintBorderColor
    }
    private func selectAsSetOrNot(index: Int) {
        let button = Cards[index]
        button.layer.borderWidth = 3.0
        
        if(model.isSet)! {
            button.layer.borderColor = setBorderColor
        }
        else{
            button.layer.borderColor = notSetBorderColor
        }
    }
    private func deselectCard(index: Int) {
        let button = Cards[index]
        
        button.layer.borderWidth = 0.0
        button.layer.borderColor = UIColor.blue.cgColor
    }
    
    
    
}

