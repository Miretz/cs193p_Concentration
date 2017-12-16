//
//  Concentration.swift
//  Concentration
//
//  Created by Miretz Dev on 13/12/2017.
//  Copyright © 2017 Miretz. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    private(set) var score = 0
    private(set) var isGameOver = false
    
    init (numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0,
               "Concentration.init(\(numberOfPairsOfCards)): you must have atleast one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
    }
    
    mutating func startNewGame(){
        isGameOver = false
        score = 0
        shuffleCards()
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].wasSeen = false
        }
    }
    
    mutating private func shuffleCards(){
        for index in cards.indices {
            let temp = cards[index]
            let randomIndex = cards.count.arc4random
            cards[index] = cards[randomIndex]
            cards[randomIndex] = temp
        }
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating private func checkGameOver(){
        isGameOver = (cards.count == cards.indices.filter({ cards[$0].isMatched }).count)
    }
    
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if cards[index].isMatched {
            return
        }
        if let matchedIndex = indexOfOneAndOnlyFaceUpCard, matchedIndex != index {
            //check if cards match
            if cards[matchedIndex] == cards[index] {
                cards[matchedIndex].isMatched = true
                cards[index].isMatched = true
                score += 2
            } else {
                if cards[index].wasSeen { //only decrease score if card was seen
                    score -= 1
                }
            }
            cards[index].isFaceUp = true
        } else {
            //no cards or 2 cards face up
            indexOfOneAndOnlyFaceUpCard = index
        }
        cards[index].wasSeen = true
        checkGameOver()
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return 1 == count ? first : nil
    }
}
