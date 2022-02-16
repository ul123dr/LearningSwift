//
//  ViewController.swift
//  Concentration
//
//  Created by BecksZ on 2/14/22.
//

import UIKit

class ViewController: UIViewController
{
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    // lecture 3 计算属性, 将game中的定义单独拿出来了
    // 这里使用return，已经表示了只读属性
    var numberOfPairsOfCards: Int {
        // 如果只有返回，可以不用get{}
        return (cardButtons.count + 1) / 2
    }
    
    // lecture 3 由于需要给UI传值，这里使用private(set)
    private(set) var flipCount: Int = 0 { didSet { flipCountLabel.text = "Flips: \(flipCount)" } }

    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
//        print("agh! a ghost!")
        flipCount += 1
//        flipCard(withEmoji: "👻", on: sender)
        // variable 可变变量 修饰符：var
        // constant 固定变量 修饰符：let
        // Optional(?) 只有两种状态（set 和 not set)
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooceCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("shosen card was not in cardButtons")
        }
    }
    
    /// 从模型内容更新UI
    private func updateViewFromModel()  {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : .systemOrange
            }
        }
    }
    
    private var emojiChoices = ["👻","👽","💀","🎃","👹","🤡","🦇","🐙","🦎"]
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        } else {
//            return "?"
//        }
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
//            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
//            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            // lecture 3 使用扩展生成随机数
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    /// lecture1: 卡片翻转
    /// - Parameters:
    ///   - withEmoji: 外部参数
    ///   - emoji: 内部参数
    ///   - on: external parameter
    ///   - button: internal parameter
    private func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = _ColorLiteralType.systemOrange
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = .white
        }
    }
}

// lecture 3 扩展
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
