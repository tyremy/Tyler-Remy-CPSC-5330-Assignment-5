//
//  ViewController.swift
//  Tyler Remy CPSC 5330 Assignment 5
//
//  Created by user251942 on 2/10/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameLabel: UILabel!
    
    @IBOutlet weak var decisionLabel: UILabel!
    
    @IBOutlet weak var optionOne: UIButton!
    
    @IBOutlet weak var optionTwo: UIButton!
    
    var molelogic = moleLogic()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Set random department for the mole
        molelogic.setMoleDept()
        
        //Update UI
        updateUI()
    }

    @IBAction func optionSelected(_ sender: UIButton) {
        
        let userSelection = sender.titleLabel!.text!
        
        molelogic.checkDepartment(userSelection)
        
        if molelogic.foundMole {
            sender.backgroundColor = UIColor.green
        }
        
        molelogic.updateInvestigationIndex(userSelection)
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
               
    }
    
   @objc func updateUI() {
        
    let moleFound = molelogic.foundMole
    let gameover = molelogic.gameover
       
       //Check if game not over
       if !gameover {
           
           decisionLabel.text = molelogic.getNextInvestigationStep()
           optionOne.setTitle(molelogic.getOptionOne(), for: .normal)
           optionTwo.setTitle(molelogic.getOptionTwo(), for: .normal)
           
           optionOne.backgroundColor = UIColor.clear
           optionTwo.backgroundColor = UIColor.clear
           
       }
       else {
           
           //Set message based on whether mole was found
           var endMessage = ""
           if moleFound {
               endMessage = "Mole found! Resetting Game!"
           } else {
               endMessage = "Mole Not Found! Resetting Game!"
               decisionLabel.textColor = UIColor.red
               optionOne.backgroundColor = UIColor.red
               optionTwo.backgroundColor = UIColor.red
           }
           
           //Display ending message
           decisionLabel.text = endMessage
           //optionOne.setTitle("", for: .normal)
           //optionTwo.setTitle("", for: .normal)
           
           //Wait 1 seconds and reset game
           Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(resetView), userInfo: nil, repeats: false)
       }
    
    }
    
    //Call function from logic to reset variables and then call update UI
    @objc func resetView() {
        molelogic.resetGame()
        decisionLabel.textColor = UIColor.black
        optionOne.backgroundColor = UIColor.clear
        optionTwo.backgroundColor = UIColor.clear
        updateUI()
    }
    
}

