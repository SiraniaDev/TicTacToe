//
//  ViewController.swift
//  TicTacToe
//
//  Created by Home on 01/12/2020.
//  Copyright © 2020 Siraniadam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK :  My Outlets
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var labelResult: UILabel!
    
    // MARK : Properties
    
    var activePlayer = 1 // Cross
    var gameStatus = [0,0,0,0,0,0,0,0,0] //  array of boolean -> test if nothing has played
    let okCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]] // 8 possibilties to win in a array of arrays
    var gameOn =  true // game ok
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.isHidden = true
        labelResult.isHidden = true
        setupDesign()
        // setupLabel()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func myAction(_ sender: AnyObject) {
        
        // Test 1 : // si la case cliquer est a valeur 0 => jamais cliquer && si le jeu n est pas fini
        if (gameStatus[sender.tag-1] == 0) && gameOn == true {
            gameStatus[sender.tag-1] = activePlayer // on change le status du gamestatus par activePalyer
            
            if (activePlayer == 1) { //if player 1 , set cross and change de player
                sender.setImage(UIImage(named: "cross"),for: UIControl.State())
                activePlayer = 2 // passer à l autre Player
            }
            else //
            {
                sender.setImage(UIImage(named: "cercle"),for: UIControl.State())
                activePlayer = 1
            }
        }
        // Test 2 :  check if one of the 8 combinaisons is OK
        for combi in okCombinations {
            if gameStatus[combi[0]] != 0 && gameStatus[combi[0]] == gameStatus[combi[1]] && gameStatus[combi[1]] == gameStatus[combi[2]] { //à chaque combinaison, on check si il a deja été cliqué !0=> donc cliqué  et voir si les 3 cases sont identiques alors on stoppe
                gameOn = false // stop the game win
                
                if gameStatus[combi[0]] == 1 { // par qui est occupé la case
                    //print("Cross")
                    labelResult.text = "Cross has won"
                }
                else {
                    //print("Circle")
                    labelResult.text = "Zero has won"
                    
                }
                disableButton()
                // End game
                playButton.isHidden = false //btn appear
                labelResult.isHidden = false
            }
            
        }
        // Test 3:   If no Winners
        gameOn = false
        for i in gameStatus { // parcourir array
            if i == 0 { // case active "cliquable" => on continue à jouer
                gameOn = true
                break
            }
        }
        if gameOn == false {
            labelResult.text = "Try Again..."
            labelResult.isHidden = false
            playButton.isHidden = false
        }
        
        
    }
    func disableButton()
       {
           for tag in 1...9        {
               let btnTemp = self.view.viewWithTag(tag) as! UIButton;
               btnTemp.isEnabled = false;
           }
       }
       
 func enableButton()
       {
           for tag in 1...9        {
               let btnTemp = self.view.viewWithTag(tag) as! UIButton;
               btnTemp.isEnabled = true;
           }
       }
    
    // PlayAgain clicked=> reinitialize the status of each buttons , set gameOn to true,setImage of each button  to nil
    
    @IBAction func playAgain(_ sender: AnyObject) {
        enableButton()
        gameStatus = [0,0,0,0,0,0,0,0,0] // remettre le status de chaque boutton à 0(non cliqué)
        gameOn = true
        activePlayer = 1
        playButton.isHidden = true
        labelResult.isHidden = true
        // clear de buton => parcourir les tag button de 0-> 8 et effacer image (setImage to nil)
        for i in 0...8 {
            let button = view.viewWithTag(i+1) as? UIButton
            button?.setImage(nil, for: UIControl.State())
            
        }
        
        
    }
    private func setupDesign(){
        myImageView.layer.shadowOpacity = 0.5
        playButton.layer.cornerRadius = 10
        labelResult.layer.cornerRadius = 10
        labelResult.layer.borderWidth = 2
        playButton.layer.borderWidth = 2
        playButton.layer.borderColor = UIColor.white.cgColor
        playButton.titleLabel!.textAlignment = NSTextAlignment.center
        
    }
    
}

