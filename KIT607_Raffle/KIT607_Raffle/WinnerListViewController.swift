//
//  WinnerListViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 23/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class WinnerListViewController: UIViewController {
var tickets1 = [TicketNOArrayForDraw]()
    @IBOutlet weak var ticketTable: UITableView!
    
    var customerName=""
      var raffleID = 0
       var ticketNumber = 0
      
    override func viewDidLoad() {
        super.viewDidLoad()
       ticketTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
}

extension WinnerListViewController: UITableViewDataSource{
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tickets1.count
}
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "WonTicketCell", for: indexPath)
    
    // Configure the cell...
    let ticket = tickets1[indexPath.row]
    if   let  ticketCell = cell as? WonTicketTableViewCell
    {
        ticketCell.ticketNo.text = String(ticket.ticketNumber)
//        ticketCell.customerName.text = ticket.customerName
//        ticketCell.price.text = String(ticket.ticketPrice)
//        ticketCell.purchaseDate.text = String(ticket.ticketPrice)
//        ticketCell.raffleName.text = ticket.raffleName
        
    }
    return cell
   
    
}
}
