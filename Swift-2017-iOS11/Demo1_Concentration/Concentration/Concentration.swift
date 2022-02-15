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
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    // at: external name 参数标签
    // index: internal name 参数名称
    func chooceCard(at index: Int) {
        /*
        // lecture 1 简单翻牌
        if cards[index].isFaceUp {
            cards[index].isFaceUp = false
        } else {
            cards[index].isFaceUp = true
        }
        */
        
        // lecture 2 翻牌匹配判断
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards matched
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        // lecture 1
        // ..< from a to b witch not contained b 从a到b不包含b
        // ... from a to b witch containted b 从a到b包含b
        /*
         // 第一种 struct 创建方法
         for identifier in 0..<numberOfPairsOfCards {
         let card = Card(identifier: identifier)
         
         let matchedCard = Card(identifier: identifier)
         let matchedCard = card
         
         // value copy
         cards.append(card)
         cards.append(card)
         // 与下面相等
         cards += [card, card]
         }
         */
        
        // 第二种 struct 创建方法
        // 因为循环内部未使用参数，这了使用 _ 代替
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
