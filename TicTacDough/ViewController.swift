//
//  ViewController.swift
//  TicTacDough
//
//  Created by Erik Dungan on 2/25/17.
//  Copyright © 2017 Callmeed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum Players {
        case Player1
        case Player2
    }
    
    @IBOutlet var buttonA1: UIButton!
    @IBOutlet var buttonB1: UIButton!
    @IBOutlet var buttonC1: UIButton!
    @IBOutlet var buttonA2: UIButton!
    @IBOutlet var buttonB2: UIButton!
    @IBOutlet var buttonC2: UIButton!
    @IBOutlet var buttonA3: UIButton!
    @IBOutlet var buttonB3: UIButton!
    @IBOutlet var buttonC3: UIButton!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var resetButton: UIButton!
    var currentPlayer = Players.Player1
    var boardMatrix = Array(repeating: 0, count: 9)
    var moveCount = 0
    var gameOver = false
    let winningTags = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
        [1, 4, 7],
        [2, 5, 8],
        [3, 6, 9],
        [1, 5, 9],
        [3, 5, 7]
    ]
    
    // MARK: UIViewController overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Utility functions for fetching values, tags, and coords
    
    func imageForPlayer() -> String {
        switch currentPlayer {
        case .Player1:
            return "X"
        case .Player2:
            return "Pizza"
        }
    }
    
    func valueForPlayer() -> Int {
        switch currentPlayer {
        case .Player1:
            return 1
        case .Player2:
            return 2
        }
    }
    
    func valueForTag(tag: Int) -> Int {
        let index = tag - 1
        let val = boardMatrix[index]
        return val
    }
    
    func spaceOpen(tag: Int) -> Bool {
        return valueForTag(tag: tag) == 0
    }
    
    // MARK: Main game logic for starting game, moves, and checking for winner
    
    func resetBoard() {
        currentPlayer = Players.Player1
        boardMatrix = Array(repeating: 0, count: 9)
        moveCount = 0
        for tag in 1...9 {
            if let btn = self.view.viewWithTag(tag) as? UIButton {
                btn.setImage(nil, for: .normal)
            }
        }
        infoLabel.text = "Player 1 (X): Your move"
        gameOver = false
    }
    
    func checkForWinner() {
        // Loop through all possible winning scenarios
        // and checks for a winner or cat's game
        var a = 0
        var b = 1
        var c = 2
        for winSet in winningTags {
            a = valueForTag(tag: winSet[0])
            b = valueForTag(tag: winSet[1])
            c = valueForTag(tag: winSet[2])
            print("Checking \(winSet): \(a) \(b) \(c)")
            if a == 1 && b == 1 && c == 1 {
                print("Player 1 wins!")
                infoLabel.text = "Player 1 Wins!"
                gameOver = true
                break
            } else if a == 2 && b == 2 && c == 2 {
                print("Player 2 wins!")
                infoLabel.text = "Player 2 Wins!"
                gameOver = true
                break
            } else {
                print("No winner yet")
            }
        }
        if !gameOver && moveCount == 9 {
            print("Cat's Game!");
            infoLabel.text = "Cat's Game!"
        }
    }
    
    func nextMove() {
        currentPlayer = (currentPlayer == Players.Player1) ? Players.Player2 : Players.Player1
        if currentPlayer == Players.Player1 {
            infoLabel.text = "Player 1 (X): Your move"
        } else {
            infoLabel.text = "Player 2 (O): Your move"
        }
        moveCount += 1
    }
    
    // MARK: Actions for UIButtons in storyboard
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        resetBoard()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let tag = sender.tag
        if !gameOver && spaceOpen(tag: tag) {
            if let image = UIImage(named: imageForPlayer()) {
                sender.setImage(image, for: .normal)
            }
            let index = tag - 1
            boardMatrix[index] = valueForPlayer()
            debugBoard()
            nextMove()
            checkForWinner()
        } else {
            print("This space is not open")
        }
    }
    
    // MARK: Debugging 
    
    // Prints board to console
    func debugBoard() {
        print("\(boardMatrix[0]) | \(boardMatrix[1]) | \(boardMatrix[2])")
        print("_________")
        print("\(boardMatrix[3]) | \(boardMatrix[4]) | \(boardMatrix[5])")
        print("_________")
        print("\(boardMatrix[6]) | \(boardMatrix[7]) | \(boardMatrix[8])")
    }

    
}

