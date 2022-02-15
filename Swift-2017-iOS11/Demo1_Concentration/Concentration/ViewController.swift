//
//  ViewController.swift
//  Concentration
//
//  Created by BecksZ on 2/14/22.
//

import UIKit

class ViewController: UIViewController
{
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount: Int = 0 { didSet { flipCountLabel.text = "Flips: \(flipCount)" } }

    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
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
    func updateViewFromModel()  {
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
    
    var emojiChoices = ["👻","👽","💀","🎃","👹","🤡","🦇","🐙","🦎"]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        } else {
//            return "?"
//        }
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    /// lecture1: 卡片翻转
    /// - Parameters:
    ///   - withEmoji: 外部参数
    ///   - emoji: 内部参数
    ///   - on: external parameter
    ///   - button: internal parameter
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = _ColorLiteralType.systemOrange
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = .white
        }
    }
}

