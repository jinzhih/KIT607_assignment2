//
//  WinnerListViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 23/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class WinnerListViewController: UIViewController {
var tickets1 = [Ticket]()
    var raffle : Raffle?
    @IBOutlet weak var ticketTable: UITableView!
    
    var customerName=""
      var raffleID = 0
       var ticketNumber = 0
      
    override func viewDidLoad() {
        super.viewDidLoad()
       ticketTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func returnRaffleDetial(_ sender: UIButton) {
        performSegue(withIdentifier: "backToRaffleDetailSegue", sender: self)
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
        ticketCell.customerName.text = ticket.customerName
        ticketCell.price.text = String(ticket.ticketPrice)
        ticketCell.purchaseDate.text = String(ticket.ticketPrice)
        ticketCell.raffleName.text = ticket.raffleName
        
    }
    return cell
   
    
}
    override func   prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "backToRaffleDetailSegue"
        {
          
         let   detailViewController = segue.destination as! RaffleDetailViewController
            let  selectedRaffle = raffle
         detailViewController.raffle = selectedRaffle
        }
       
         //showWonTicketsSegue
//         else if segue.identifier == "showWonTicketsSegue"
//                    {
//                         let DrawWinnerViewController = segue.destination as! WinnerListViewController
//                     DrawWinnerViewController.tickets1 = ticketwinneraray
//                    }
//        else if segue.identifier == "returnRaffleList"
//        {
//         print("delet successed")
//        }
         else
        {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        }
}
