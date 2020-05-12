//
//  SellTicketViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 10/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class SellTicketViewController: UIViewController {
    var raffle : Raffle?
    var customer : Customer?
    var raffleselling : Raffle?
    

   var raffleID = 1
    var raffleName = ""
    var ticketPrice = 1
    var customerID = 1
    var customerName = ""
    var purchaseDate = ""
    var winStatus = 0
    var ticketNumber = 1
   
    var numberOfTicket = 1

    var displayDrawType=""
    @IBOutlet weak var raffleNameLable: UILabel!
    
    @IBOutlet weak var raffleDes: UILabel!
    @IBOutlet weak var rafflePrice: UILabel!
    @IBOutlet weak var drawType: UILabel!
    @IBOutlet weak var ticketQty: UILabel!
    @IBOutlet weak var drawDate: UILabel!
    
    @IBOutlet weak var customerNameTextField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let  displayCustomer = customer
        {
            customerNameTextField.text = displayCustomer.customerName 
           
        }
        if let displayRaffle = raffleselling{
            
            if(displayRaffle.type == 0){
                displayDrawType = "Normal Raffle"

            } else {
                displayDrawType = "Marging Raffle"
            }
            raffleNameLable.text = displayRaffle.name
            raffleDes.text = displayRaffle.description
            rafflePrice.text = String(displayRaffle.ticketPrice)
            drawType.text = displayDrawType
            drawDate.text = displayRaffle.drawTime
            
        }
    }
    
    @IBAction func createNewTicket(_ sender: UIButton) {
        raffleID = Int(raffleselling!.ID)
        raffleName = raffleselling!.name
        ticketPrice = Int(raffleselling!.ticketPrice)
        customerID = Int(customer!.ID)
        customerName = customer!.customerName
        purchaseDate = "20/Mar/2020"
        ticketNumber = 1
        
        
        
        
        
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase");
       database.insert(ticket: Ticket(raffleID:Int32(raffleID),  raffleName:raffleName, ticketPrice:Int32(ticketPrice),customerID:Int32(customerID), customerName: customerName, purchaseDate: purchaseDate, winStatus: Int32(winStatus), ticketNumber: Int32(ticketNumber)))
        
//        database.insert(ticket: Ticket(raffleID:3,  raffleName:"raffle6666", ticketPrice:0,customerID:30, customerName: "hello", purchaseDate: "89/987/99", winStatus:0, ticketNumber: 1003))
        
       
        let refreshAlert=UIAlertController(title: "TicketCreated", message: "", preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                 self.performSegue(withIdentifier: "GoTicketList", sender: self)
                 }))
        present(refreshAlert, animated: true, completion: nil)
        
    }
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        ticketQty.text = String(format: "%.0f", sender.value)
        numberOfTicket = Int(sender.value)
    }
    
    @IBAction func addCustomerInfor(_ sender: UIButton) {
        performSegue(withIdentifier: "FindCustomer", sender: self)
    }
    
    override func   prepare(for segue: UIStoryboardSegue, sender: Any?)
       {
           super.prepare(for: segue, sender: sender)
           if segue.identifier == "FindCustomer"
           {         guard let   detailViewController = segue.destination as? CustomerCusTableViewController else
           {
               fatalError("Unexpected destination: \(segue.destination)")
               
               }
               
               let  selectedRaffle = raffleselling
               detailViewController.raffleTemp = selectedRaffle
         
               
           }
           
           }
 

}
