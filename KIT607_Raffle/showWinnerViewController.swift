//
//  showWinnerViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 24/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class showWinnerViewController: UIViewController {
    var tickets1 = [Ticket]()
    var raffle : Raffle?
    var customerName=""
    var raffleID = 0
     var ticketNumber = 0
      var ticketwinneraray = [Ticket]()
    @IBOutlet weak var ticketTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         ticketTable.dataSource = self

        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase");
        tickets1 = database.selectWonTicketByRaffleID(id: raffle!.ID)
        ticketwinneraray = tickets1.filter{$0.winStatus == 1}
        print(ticketwinneraray)
    }
    
   
    @IBAction func returnRaffleDetailView(_ sender: UIButton) {
        performSegue(withIdentifier: "returnRaffleDetailFromWinner", sender: self)
    }
    
}
extension showWinnerViewController: UITableViewDataSource{
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return ticketwinneraray.count
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
       let cell = tableView.dequeueReusableCell(withIdentifier: "WinnerCell", for: indexPath)
       
       // Configure the cell...
       let ticket = ticketwinneraray[indexPath.row]
       if   let  ticketCell = cell as? WinnersTableViewCell
       {
//           ticketCell.ticketNo.text = String(ticket.ticketNumber)
//           ticketCell.customerName.text = ticket.customerName
        ticketCell.ticketNO.text = String(ticket.ticketNumber)
        ticketCell.winner.text = ticket.customerName
           
       }
       return cell
      
       
   }
     override func   prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            super.prepare(for: segue, sender: sender)
            if segue.identifier == "returnRaffleDetailFromWinner"
            {
              
             let   detailViewController = segue.destination as! RaffleDetailViewController
                let  selectedRaffle = raffle
             detailViewController.raffle = selectedRaffle
            }
         
             else
            {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            }
}
