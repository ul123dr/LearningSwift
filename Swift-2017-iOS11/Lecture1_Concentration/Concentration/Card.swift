//
//  Card.swift
//  Concentration
//
//  Created by BecksZ on 2/15/22.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMetched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifire() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        identifier = Card.getUniqueIdentifire()
    }
}
