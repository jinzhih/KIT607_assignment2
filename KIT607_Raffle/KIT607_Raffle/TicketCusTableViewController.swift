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
     var ticketNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ticketTable.dataSource = self
       var database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabasesdfg")
         tickets1 = database.selectTicketBy(id: 3)
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
            ticketCell.ticketNO.text = ticket.raffleName
            ticketCell.customerName.text = ticket.customerName
            
            
        }
        return cell
        
        
        
        
        
    }
}


