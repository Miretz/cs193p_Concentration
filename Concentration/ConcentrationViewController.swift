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
        return (visibleCardButtons.count + 1)/2
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
        let separator = traitCollection.verticalSizeClass == .compact ? "\n" : ":"
        let gameOverText = game.isGameOver ? "Well done!" : ""
        let text = "\(gameOverText) Score\(separator) \(game.score)"
        flipCountLabel.attributedText = NSAttributedString(string: text, attributes: attributes)
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateScoreLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var visibleCardButtons: [UIButton]! {
        return cardButtons?.filter { !$0.superview!.isHidden }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    
    private var lastCardButtonTouched: UIButton?
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = visibleCardButtons.index(of: sender){
            lastCardButtonTouched = sender
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            updateScoreLabel()
        }
    }
    
    @objc func flipCardAnimation(_ button: UIButton, emojiForCard: String){
        UIView.transition(
            with: button,
            duration: 0.3,
            options: [.transitionFlipFromLeft],
            animations: {
                button.setTitle(emojiForCard, for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
        )
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateScoreLabel()
    }
    
    private func updateViewFromModel(){
        if visibleCardButtons != nil {
            for index in visibleCardButtons.indices {
                let button = visibleCardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    if button == lastCardButtonTouched {
                        flipCardAnimation(button, emojiForCard: emoji(for: card))
                    } else {
                        button.setTitle(emoji(for: card), for: UIControlState.normal)
                        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    }
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

