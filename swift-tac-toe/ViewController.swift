//
//  ViewController.swift
//  swift-tac-toe
//
//  Created by Robert Horngren on 2020-12-15.
//

import UIKit

class ViewController: UIViewController {
    
    var gameIsStopped = true
    
    var activePlayer = 1
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var winningCombinationSmall = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
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
        for i in 1...9{
            let button = view.viewWithTag(i) as! UIButton
            button.isEnabled = false
        }
    }
    
    func enableInput() {
        for i in 1...9{
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
        
        for combination in winningCombinationSmall {
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
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
        
        while (gameTurn == 9) && (winner == false) {
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
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        gameIsActive = true
        activePlayer = 1
        gameTurn = 0
        winner = false
        
        currentPlayerLabel.text = "Current player:"
        currentPlayerName.text = player1Name
        
        playAgainButton.isHidden = true
        winningPlayer.isHidden = true
        
        for i in 1...9{
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControl.State())
        }
        enableInput()
    }
    
    
}

