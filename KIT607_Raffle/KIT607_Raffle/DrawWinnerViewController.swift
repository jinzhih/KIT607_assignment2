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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
