//
//  TicketCusTableViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 10/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit
var tickets1 = [Ticket]()
class TicketCusTableViewController: UIViewController {
    @IBOutlet weak var ticketTable: UITableView!
    
    var customerName=""
    var raffleID = 0
     var ticketNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ticketTable.dataSource = self
       var database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabase")
         tickets1 = database.selectTicketBy(id: Int32(raffleID))
        //TODO raffleID from sell ticket
        print(tickets1)
    }
   }
extension TicketCusTableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets1.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketCell", for: indexPath)
        
        // Configure the cell...
        let ticket = tickets1[indexPath.row]
        if   let  ticketCell = cell as? TicketUITableViewCell
        {
            ticketCell.ticketNO.text = String(ticket.ticketNumber)
            ticketCell.customerName.text = ticket.customerName
            
            
        }
        return cell
       
        
    }
    

    override func   prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "goToTicketDetail"
        {
            guard let   detailViewController = segue.destination as? TicketDetailViewController else
        {
            fatalError("Unexpected destination: \(segue.destination)")
            
            }
            guard let   selectedTicketCell = sender as? TicketUITableViewCell else
            {            fatalError("Unexpected sender: \( String(describing: sender))")
                
            }
            guard let   indexPath = ticketTable.indexPath(for: selectedTicketCell) else
            {
                fatalError("The selected cell is not being displayed by the table")
                
            }
            let  selectedTicket = tickets1[indexPath.row]
            detailViewController.ticket = selectedTicket
            
        }
        
        }

    
}


