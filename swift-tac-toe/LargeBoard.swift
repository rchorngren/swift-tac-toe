//
//  LargeBoard.swift
//  swift-tac-toe
//
//  Created by Robert Horngren on 2021-01-06.
//

import Foundation

import UIKit

class LargeBoard: UIViewController {
    
    var gameIsStopped = true
    
    var activePlayer = 1
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var winningCombinationLarge =
        [[0, 1, 2, 3], [1, 2, 3, 4],
         [5, 6, 7, 8], [6, 7, 8, 9],
         [10, 11, 12, 13], [11, 12, 13, 14],
         [15, 16, 17, 18], [16, 17, 18, 19],
         [20, 21, 22, 23], [21, 22, 23, 24],
         
         [0, 5, 10, 15], [5, 10, 15, 20],
         [1, 6, 11, 16], [6, 11, 16, 21],
         [2, 7, 12, 17], [7, 12, 17, 22],
         [3, 8, 13, 18], [8, 13, 18, 23],
         [4, 9, 14, 19], [9, 14, 19, 24],
        
         [0, 6, 12, 18], [1, 7, 13, 19],
         [5, 11, 17, 23], [6, 12, 18, 24],
        
         [2, 6, 10, 14], [3, 7, 11, 15],
         [7, 11, 15, 19], [8, 12, 16, 20]]
    
    var gameIsActive = true
    
    var gameTurn = 0
    var winner = false
    
    var player1Name : String? = "Player One"
    var player2Name : String? = "Player Two"
    
    var counter = 0
    
    var player1Score = 0
    var player2Score = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playAgainButton.isHidden = true
        winningPlayer.isHidden = true
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if(counter == 0) {
            enterPlayerNames()
            counter -= 1
        }
    }
    
    func enterPlayerNames() {
        let alert = UIAlertController(title: "New game", message: "Enter the names of who is playing", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Play!", style: .default) { [self] action in
            guard let player1nameField = alert.textFields?.first else { return }
            guard let player1NameInput = player1nameField.text else { return }
            if player1NameInput == "" { return }
            
            guard let player2NameField = alert.textFields?[1] else { return }
            guard let player2NameInput = player2NameField.text else { return }
            if player2NameInput == "" { return }
            
            player1Name = player1NameInput
            player2Name = player2NameInput
            
            currentPlayerName.text = player1Name
            player1ScoreName.text = player1Name
            player2ScoreName.text = player2Name
            
        }
        alert.addAction(saveAction)
        
        alert.addTextField{ textField in
            textField.placeholder = "Player one"
            textField.autocapitalizationType = .words
        }
        alert.addTextField{ textField in
            textField.placeholder = "Player two"
            textField.autocapitalizationType = .words
        }
        
        currentPlayerName.text = player1Name
        
        present(alert, animated: true)
    }
    
    func disableInput() {
        for i in 1...25{
            let button = view.viewWithTag(i) as! UIButton
            button.isEnabled = false
        }
    }
    
    func enableInput() {
        for i in 1...25{
            let button = view.viewWithTag(i) as! UIButton
            button.isEnabled = true
        }
    }
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var winningPlayer: UILabel!
    @IBOutlet weak var currentPlayerName: UILabel!
    @IBOutlet weak var currentPlayerLabel: UILabel!
    
    @IBOutlet weak var player1ScoreName: UILabel!
    @IBOutlet weak var player2ScoreName: UILabel!
    @IBOutlet weak var player1ScoreValue: UILabel!
    @IBOutlet weak var player2ScoreValue: UILabel!
    
    @IBAction func action(_ sender: Any) {
        if gameState[(sender as AnyObject).tag-1] == 0 && gameIsActive == true {
            gameState[(sender as AnyObject).tag-1] = activePlayer
            gameTurn += 1
            
            if activePlayer == 1 {
                (sender as AnyObject).setImage(UIImage(named: "Cross.png"), for: UIControl.State())
                currentPlayerName.text = player2Name
                activePlayer = 2
                
            } else {
                (sender as AnyObject).setImage(UIImage(named: "Nought.png"), for: UIControl.State())
                currentPlayerName.text = player1Name
                activePlayer = 1
            }
        }
        
        for combination in winningCombinationLarge {
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] && gameState[combination[2]] == gameState[combination[3]] {
                gameIsActive = false
                
                if gameState[combination[0]] == 1 {
                    winner = true
                    winningPlayer.text = "\(player1Name!) Won!"
                    currentPlayerLabel.text = "Winner:"
                    currentPlayerName.text = player1Name
                    
                    player1Score+=1
                    player1ScoreValue.text = String(player1Score)
                    
                    disableInput()
                } else {
                    winner = true
                    winningPlayer.text = "\(player2Name!) Won!"
                    currentPlayerLabel.text = "Winner:"
                    currentPlayerName.text = player2Name
                    
                    player2Score+=1
                    player2ScoreValue.text = String(player2Score)
                    
                    disableInput()
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
        
        while (gameTurn == 25) && (winner == false) {
            //setting gameTurn to 255 to break while-loop
            gameTurn = 255
            winningPlayer.text = "Draw!"
            
            currentPlayerLabel.text = "Winner:"
            currentPlayerName.text = "None!"
            
            winningPlayer.isHidden = false
            playAgainButton.isHidden = false
            
            disableInput()
        }
    }
    
    @IBAction func playAgain(_ sender: Any) {
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        gameIsActive = true
        activePlayer = 1
        gameTurn = 0
        winner = false
        
        currentPlayerLabel.text = "Current player:"
        currentPlayerName.text = player1Name
        
        playAgainButton.isHidden = true
        winningPlayer.isHidden = true
        
        for i in 1...25{
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControl.State())
        }
        enableInput()
    }
    
}
