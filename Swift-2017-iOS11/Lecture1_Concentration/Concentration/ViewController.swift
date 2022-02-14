//
//  ViewController.swift
//  Concentration
//
//  Created by BecksZ on 2/14/22.
//

import UIKit

class ViewController: UIViewController
{
    
    var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }

    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["👻","🎃","👻","🎃"]
    
    @IBAction func touchCard(_ sender: UIButton) {
//        print("agh! a ghost!")
        flipCount += 1
//        flipCard(withEmoji: "👻", on: sender)
        // variable 可变变量 修饰符：var
        // constant 固定变量 修饰符：let
        // Optional(?) 只有两种状态（set 和 not set)
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            print("cardNumber = \(cardNumber)")
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("shosen card was not in cardButtons")
        }
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

