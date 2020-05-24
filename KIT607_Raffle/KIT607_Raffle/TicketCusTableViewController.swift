//
//  TicketCusTableViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 10/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit
var tickets1 = [Ticket]()

class TicketCusTableViewController:
UIViewController {
    @IBOutlet weak var ticketTable: UITableView!
       var searchResult = [Ticket]()
     var raffle : Raffle?
     var isNewTicket = Int()
    var customerName=""
    var raffleID = 0
     var ticketNumber = 0
    var searching = false
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ticketTable.dataSource = self
       var database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabase")
         tickets1 = database.selectTicketBy(id: Int32(raffleID))
    
    }
    @IBAction func returnRaffleList(_ sender: UIButton) {
        performSegue(withIdentifier: "backToRaffleList", sender: self)
    }
    
  
    @IBAction func goToCustomerList(_ sender: UIButton) {
        //goToCustomerListFromTicketList
        performSegue(withIdentifier: "goToCustomerListFromTicketList", sender: self)
    }
    
    
    @IBAction func returnRaffleDetial(_ sender: UIButton) {
       //backSelllingPortalSegue
        if(isNewTicket == 1){
 performSegue(withIdentifier: "backSelllingPortalSegue", sender: self)
            return
        }
        
       performSegue(withIdentifier: "backToRaffleDetailFromExistingTicketList", sender: self)
    }
}
extension TicketCusTableViewController:UISearchBarDelegate{


func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
     var database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabase")
    print(searchBar.text!)
    searchResult = tickets1.filter{$0.ticketNumber == Int32(searchBar.text!)}
    //ticketwinneraray = ticket.filter{$0.ticketNumber == difference}
    print("hello")
    searching = true
    ticketTable.reloadData()
}

func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text?.count == 0 {
        searching = false
        ticketTable.reloadData()
        }
    }
}
extension TicketCusTableViewController: UITableViewDataSource, UITableViewDelegate{
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searching{
        return searchResult.count
    }else{
         return tickets1.count
    }
    
}



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketCell", for: indexPath)
        
        // Configure the cell...
        
        
//        let ticket = tickets1[indexPath.row]
//        if   let  ticketCell = cell as? TicketUITableViewCell
//        {
//            ticketCell.ticketNO.text = String(ticket.ticketNumber)
//            ticketCell.customerName.text = ticket.customerName
//            ticketCell.purchaseDate.text = ticket.purchaseDate
//            ticketCell.price.text = String(ticket.ticketPrice)
//            ticketCell.raffleName.text = ticket.raffleName
//
//
//        }
        if searching {
               
           var ticket = searchResult[indexPath.row]
               if   let  ticketCell = cell as? TicketUITableViewCell
               {
                   ticketCell.ticketNO.text = String(ticket.ticketNumber)
                ticketCell.customerName.text = ticket.customerName
                ticketCell.price.text = String(ticket.ticketPrice)
                    ticketCell.purchaseDate.text = ticket.purchaseDate
                       ticketCell.raffleName.text = ticket.raffleName
               }
           }
   
        
        
        else{
               
               // Configure the cell...
               let ticket = tickets1[indexPath.row]
               if   let  ticketCell = cell as? TicketUITableViewCell
               {
                  ticketCell.ticketNO.text = String(ticket.ticketNumber)
                   ticketCell.customerName.text = ticket.customerName
                ticketCell.purchaseDate.text = ticket.purchaseDate
                   ticketCell.price.text = String(ticket.ticketPrice)
                  ticketCell.raffleName.text = ticket.raffleName
                
                   
                   
               }

           }
        return cell
       
        
    }
    
    override func   prepare(for segue: UIStoryboardSegue, sender: Any?)
      {
          super.prepare(for: segue, sender: sender)
          if segue.identifier == "backSelllingPortalSegue"
          {
            
           let   detailViewController = segue.destination as! SellTicketViewController
              let  selectedRaffle = raffle
           
              detailViewController.raffleselling = selectedRaffle
          }
             else if segue.identifier == "goToTicketDetail"
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
        else if segue.identifier == "backToRaffleDetailFromExistingTicketList"
                  {
                    
                   let   detailViewController = segue.destination as! RaffleDetailViewController
                      let  selectedRaffle = raffle
                   
                      detailViewController.raffle = selectedRaffle
                  }
          else if segue.identifier == "goToCustomerListFromTicketList"
                           {
                                let CustomerListViewController = segue.destination as! CustomerCusTableViewController
                           
                               CustomerListViewController.isChooseCustomer = 0
                           }
          
          }
//    override func   prepare(for segue: UIStoryboardSegue, sender: Any?)
//    {
//        super.prepare(for: segue, sender: sender)
//        if segue.identifier == "goToTicketDetail"
//        {
//            guard let   detailViewController = segue.destination as? TicketDetailViewController else
//        {
//            fatalError("Unexpected destination: \(segue.destination)")
//            
//            }
//            guard let   selectedTicketCell = sender as? TicketUITableViewCell else
//            {            fatalError("Unexpected sender: \( String(describing: sender))")
//                
//            }
//            guard let   indexPath = ticketTable.indexPath(for: selectedTicketCell) else
//            {
//                fatalError("The selected cell is not being displayed by the table")
//                
//            }
//            let  selectedTicket = tickets1[indexPath.row]
//            detailViewController.ticket = selectedTicket
//            
//        }
//        
//        }

    
}


