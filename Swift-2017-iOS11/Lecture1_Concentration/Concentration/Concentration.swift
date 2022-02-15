//
//  Concentration.swift
//  Concentration
//
//  Created by BecksZ on 2/15/22.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    func chooceCard(at index: Int) {
        cards[index].isFaceUp = !cards[index].isFaceUp
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
//            cards.append(card)
//            cards.append(card)
            // 同样可以使用 +=
            cards += [card, card]
        }
    }
}
