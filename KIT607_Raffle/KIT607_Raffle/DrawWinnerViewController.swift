//
//  DrawWinnerViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 20/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class DrawWinnerViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var lowScoreTextField: UITextField!
    @IBOutlet weak var highScoreTextField: UITextField!
    var raffleID = 0
     var raffle : Raffle?
    var lowScore = 1
    var highScore = 2
    var difference = 1
    var winnerName = String()
    var ticket = [Ticket]()
    var ticketwinneraray = [Ticket]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //get ticketlist by raffleID
           lowScoreTextField.delegate = self
           highScoreTextField.delegate = self
          let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase");
        ticket = database.selectTicketBy(id: Int32(raffleID))
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
        
      ticketwinneraray = ticket.filter{$0.ticketNumber == difference}
        if ticketwinneraray.count > 0{
            let ID = ticketwinneraray[0].ID
        
             let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase");
            winnerName = database.selectWinnerNameByTicketID(id: ID)
              database.updateWinStatusbyID(winStatus: 1, id: ID)
             database
            //goToWonTicketFromMargin
            performSegue(withIdentifier: "goToWonTicketFromMargin", sender: self)
                   
            
           // print(winnerName)
        } else{
            let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase");
             database.updateDrawStatusbyID(drawStatus: 1, id: raffle!.ID)
            alertNoWinner()
        }
        
    }
    
    @IBAction func backToRaffleDetail(_ sender: UIButton) {
        performSegue(withIdentifier: "backToRaffleDetailFromMargin", sender: self)
        
    }
    //Alert Function
    func alertNoWinner(){
        let inputAlert=UIAlertController(title: "Alert", message: "No Winner", preferredStyle: .alert)
                inputAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                      
                   
                present(inputAlert, animated: true, completion: nil)
    }
    //
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
           if textField.text != ""{
               return true
           }else {
               textField.placeholder = "Type something"
               return false
           }
       }
       
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           lowScoreTextField.endEditing(true)
           highScoreTextField.endEditing(true)
          
           return true
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
    override func   prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "goToWonTicketFromMargin"
        {
          
         let   detailViewController = segue.destination as! WinnerListViewController
            let  selectedWinner = ticketwinneraray
         detailViewController.tickets1 = selectedWinner
            detailViewController.raffle = raffle
        }
           else if segue.identifier == "backToRaffleDetailFromMargin"
            {
              
             let   detailViewController = segue.destination as! RaffleDetailViewController
                let  selectedWinner = raffle
            
                detailViewController.raffle = raffle
            }
       
         else
        {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        }
}
