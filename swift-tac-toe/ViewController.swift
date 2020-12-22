//
//  ViewController.swift
//  swift-tac-toe
//
//  Created by Robert Horngren on 2020-12-15.
//

import UIKit

class ViewController: UIViewController {
    
    var activePlayer = 1
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var winningCombinationSmall = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    var gameIsActive = true
    
    var gameTurn = 0
    var winner = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playAgainButton.isHidden = true
        winningPlayer.isHidden = true

    }
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var winningPlayer: UILabel!
    
    @IBAction func action(_ sender: Any) {
        if gameState[(sender as AnyObject).tag-1] == 0 && gameIsActive == true {
            gameState[(sender as AnyObject).tag-1] = activePlayer
            gameTurn += 1
            if activePlayer == 1 {
                (sender as AnyObject).setImage(UIImage(named: "Cross.png"), for: UIControl.State())
                activePlayer = 2
                
            } else {
                (sender as AnyObject).setImage(UIImage(named: "Nought.png"), for: UIControl.State())
                activePlayer = 1
            }
        }
        
        for combination in winningCombinationSmall {
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
                gameIsActive = false
                
                if gameState[combination[0]] == 1 {
                    winner = true
                    winningPlayer.text = "Player One Won!"
                    
                } else {
                    winner = true
                    winningPlayer.text = "Player Two Won!"
                }
                
                playAgainButton.isHidden = false
                winningPlayer.isHidden = false
            }
        }
        gameIsActive = false
        
        for i in gameState {
            if i == 0 {
                gameIsActive = true
                break
            }
        }
        
        while (gameTurn == 9) && (winner == false) {
            //setting gameTurn to 255 to break while-loop
            gameTurn = 255
            winningPlayer.text = "Draw!"
            winningPlayer.isHidden = false
            playAgainButton.isHidden = false
        }
    }

    @IBAction func playAgain(_ sender: Any) {
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        gameIsActive = true
        activePlayer = 1
        gameTurn = 0
        winner = false
        
        playAgainButton.isHidden = true
        winningPlayer.isHidden = true
        
        for i in 1...9{
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControl.State())
        }
    }
    
    
}

