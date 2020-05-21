//
//  DrawWinnerViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 20/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class DrawWinnerViewController: UIViewController {
    @IBOutlet weak var lowScoreTextField: UITextField!
    @IBOutlet weak var highScoreTextField: UITextField!
    var raffleID = 0
    var lowScore = 1
    var highScore = 2
    var difference = 1
    var winnerName = String()
    var ticket = [TicketNOArrayForDraw]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //get ticketlist by raffleID
          let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase");
        ticket = database.selectTicketNoAndIDByRaffleID(id: Int32(raffleID))
    }
    
    @IBAction func drawWinnerBtn(_ sender: UIButton) {
        let verifyFlag1 = validateTextField(value: lowScoreTextField)
        let verifyFlag2 = validateTextField(value: highScoreTextField)
        if(!verifyFlag1 || !verifyFlag2){
            return
        }
        
        lowScore = Int(lowScoreTextField.text!)!
        highScore = Int(highScoreTextField.text!)!
        difference = highScore - lowScore
        print (ticket)
        
      var WinnerFiltered = ticket.filter{$0.ticketNumber == difference}
        if WinnerFiltered.count > 0{
            let ID = WinnerFiltered[0].ID
        
             let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase");
            winnerName = database.selectWinnerNameByTicketID(id: ID)
            
            print(winnerName)
        } else{
            print("no winner")
        }
        
    }
    
    //verify textfield
  func validateTextField(value: UITextField)  -> Bool {
        
            if (value.text == "") {
                let warningAlert=UIAlertController(title: "Verification", message: "Please enter in Text Box", preferredStyle: .alert)


                warningAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                         
                         }))
                present(warningAlert, animated: true, completion: nil)
                return  false
            }
   
            return true
       
        }
}
