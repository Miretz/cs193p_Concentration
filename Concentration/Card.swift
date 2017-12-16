//
//  Card.swift
//  Concentration
//
//  Created by Miretz Dev on 13/12/2017.
//  Copyright © 2017 Miretz. All rights reserved.
//

import Foundation

struct Card : Hashable {
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    var wasSeen = false
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
    
    var hashValue: Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
        
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    
}
