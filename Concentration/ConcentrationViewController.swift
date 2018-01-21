//
//  ViewController.swift
//  Concentration
//
//  Created by Miretz Dev on 13/12/2017.
//  Copyright © 2017 Miretz. All rights reserved.
//

import UIKit

final class ConcentrationViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1)/2
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game.startNewGame()
        emojiChoices = Theme.randomTheme().rawValue
        emoji.removeAll()
        updateViewFromModel()
        updateScoreLabel()
    }
    
    private func updateScoreLabel(){
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        ]
        let text = (game.isGameOver) ? "Well done! Score: \(game.score)" : "Score: \(game.score)"
        flipCountLabel.attributedText = NSAttributedString(string: text, attributes: attributes)
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateScoreLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            updateScoreLabel()
        }
    }
    
    private func updateViewFromModel(){
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                } else {
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
                }
            }
        }
    }
    
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    
    private var emojiChoices = Theme.randomTheme().rawValue

    private var emoji = [Card: String]()  // alternative to Dictionary<Int,String>
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?" // optional or default value
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

