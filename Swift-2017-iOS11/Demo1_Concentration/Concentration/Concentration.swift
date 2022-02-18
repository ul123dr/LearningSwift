//
//  Concentration.swift
//  Concentration
//
//  Created by BecksZ on 2/15/22.
//

import Foundation

struct Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        // lecture 3 compute the value of a property
        get {
            // look at all the cards and see if you find only one that face up
            // if so, return it, else return nil
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        foundIndex = nil
                    }
                }
            }
            return foundIndex
        }
        set {
            // turn all the cards face down except the card at newValue
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    // at: external name 参数标签
    // index: internal name 参数名称
    // lecture 4 struct函数不能直接调用self，需要加mutating修饰（无修饰cards报错：Cannot assign to property: 'self' is immutable）
    mutating func chooceCard(at index: Int) {
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
            /*
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
            }*/
            
            // lecture 3 indexOfOneAndOnlyFaceUpCard转换成计算属性，set已做cards计算，所以可以精简
            // lecture 3 断言，调试时保护API正常执行，发布到App Store后会忽略
            assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        // lecture 1
        /*
         // ..< from a to b witch not contained b 从a到b不包含b
         // ... from a to b witch containted b 从a到b包含b
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
        
        // lecture 3 断言判断输入内容
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        // lecture 1 第二种 struct 创建方法
        // 因为循环内部未使用参数，这了使用 _ 代替
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
