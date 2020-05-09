//
//  RaffleUITableViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 26/4/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

//var tickets = [Ticket]()

class TestViewController: UITableViewController {
//     var raffleID:Int32
//       var raffleName:String
//       var ticketPrice: Int32
//       var customerID: Int32
//       var customerName: String
//       var purchaseDate: String
//       var winStatus: Int32
//       var ticketNumber: Int32
//    RaffleID, RaffleName, Ticketprice, CustomerID, CustomerName, PurchaseDate, Winstatus, TicketNumber
//
    var raffleID = 1
    var raffleName = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
        

//
//        database.insert(raffle:Raffle(name:"Raffle1", description:"Normal Raffle",type:0, ticketPrice:1, launchStatus:0, Drawstatus:0, Drawtime:"08/Mar/2021"))
//         database.insert(raffle:Raffle(name:"Raffle2", description:"Normal Raffle",type:0, ticketPrice:1, launchStatus:0, Drawstatus:0, Drawtime:"08/Mar/2021"))
        
        database.insert(ticket: Ticket(raffleID:3,  raffleName:"raffleDes", ticketPrice:0,customerID:30, customerName: "hello", purchaseDate: "tommor", winStatus:0, ticketNumber: 1001))
//        database.insert(raffle:Raffle(name:"Raffle4",  description:"Normal Raffle", type:0,maxNumber:30, ticketPrice: 1, launchStatus: 0, drawStatus:0, drawTime: "tomorrow"))
//        
        
//        database.updateRaffle(raffle: Raffle(name: "fengle2", description: "Raffle1", type: 3, maxNumber: 5, ticketPrice: 7, launchStatus: 9, drawStatus: 1, drawTime: "hello" ), id: 2)
       // database.deleteRaffleBy(id: 1)
//          print(database.selectAllRaffles())
        tickets = database.selectTicketBy(id: 3)
//        print(database.selectRaffleBy(id: 4) ??  "Raffle not found")
        print(tickets )
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return raffles.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         let cell = tableView.dequeueReusableCell(withIdentifier: "RaffleUITableViewCell", for: indexPath)
//
//         // Configure the cell...
//         let raffle = raffles[indexPath.row]
//         if   let  raffleCell = cell as? RaffleUITableViewCell
//         {
//             raffleCell.nameRaffle.text = raffle.name
//            raffleCell.desRaffle.text = raffle.description
//             
//         }
//         return cell
//     }
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    /*
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
//    */
//
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }
//    */
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//    override func   prepare(for segue: UIStoryboardSegue, sender: Any?)
//    {
//        super.prepare(for: segue, sender: sender)
//        if segue.identifier == "ShowRaffleDetailSegue"
//        {         guard let   detailViewController = segue.destination as? RaffleDetailViewController else
//        {
//            fatalError("Unexpected destination: \(segue.destination)")
//            
//            }
//            guard let   selectedRaffleCell = sender as? RaffleUITableViewCell else
//            {            fatalError("Unexpected sender: \( String(describing: sender))")
//                
//            }
//            guard let   indexPath = tableView.indexPath(for: selectedRaffleCell) else
//            {
//                fatalError("The selected cell is not being displayed by the table")
//                
//            }
//            let  selectedRaffle = raffles[indexPath.row]
//            detailViewController.raffle = selectedRaffle
//            
//        }
//        
//        }
//
}
