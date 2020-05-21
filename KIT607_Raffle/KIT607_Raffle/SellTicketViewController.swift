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
    var ticketsArray = [Int32]()
    var raffleID = 1
    var raffleName = ""
    var ticketPrice = 1
    var customerID = 1
    var customerName = ""
    var purchaseDate = ""
    var winStatus = 0
    var ticketNumber = 1
    var raffleType = 0
    var maxNumber = 0
    var numberOfTicket : Int!
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
            let numberofTicket = numberOfTicket ?? 1
            ticketQty.text = String(numberofTicket)
            
        }
    }
    
    @IBAction func createNewTicket(_ sender: UIButton) {
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
         raffleID = Int(raffleselling!.ID)
         raffleName = raffleselling!.name
         raffleType = Int(raffleselling!.type)
         ticketPrice = Int(raffleselling!.ticketPrice)
         customerID = Int(customer!.ID)
         customerName = customer!.customerName
         maxNumber = Int(raffleselling!.maxNumber)
         
         let dateformatter = DateFormatter()
         dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
         purchaseDate = dateformatter.string(from: Date())
         // Assign a ticket number
         if raffleType == 0 {
             //For normal raffle
             let currentMaxNumber = database.selectMaxTicketBy(id: Int32(raffleID)) ?? 0
             ticketNumber = Int(currentMaxNumber + 1)
             // Insert number of ticket
             var a = 0
             while a < numberOfTicket {
                 database.insert(ticket: Ticket(raffleID:Int32(raffleID),  raffleName:raffleName, ticketPrice:Int32(ticketPrice),customerID:Int32(customerID), customerName: customerName, purchaseDate: purchaseDate, winStatus: Int32(winStatus), ticketNumber: Int32(ticketNumber)))
                 ticketNumber += 1
                 a+=1
             }
         } else if raffleType == 1 {
             //for margin raffle
             ticketsArray = database.selectAllTicketNumberByRaffleID(raffleId: Int32(raffleID)) ?? [Int32]()
             let saledTicketNumber = ticketsArray.count
             if saledTicketNumber == 0 {
                 // No ticket have been saled before
                 var generatedNumberArray = [Int]()
                 var a = 0
                 while a < numberOfTicket {
                     ticketNumber = Int.random(in: 1...maxNumber)
                     generatedNumberArray.append(ticketNumber)
                     database.insert(ticket: Ticket(raffleID:Int32(raffleID),  raffleName:raffleName, ticketPrice:Int32(ticketPrice),customerID:Int32(customerID), customerName: customerName, purchaseDate: purchaseDate, winStatus: Int32(winStatus), ticketNumber: Int32(ticketNumber)))
                     var flag = true
                     while flag {
                         var nextTicketNumber = Int.random(in: 1...maxNumber)
                         if  (generatedNumberArray.contains(nextTicketNumber)) {
                             continue
                         } else {
                             ticketNumber = nextTicketNumber
                             flag = false
                         }
                     }
                     a+=1
                 }
                 ticketNumber = Int.random(in: 1...maxNumber)
                 
             } else {
                 let totalTicketArray = [Int32](1...Int32(maxNumber))
                 let restTicketNumberSet = Set(ticketsArray).symmetricDifference(totalTicketArray)
                 let restTicketNumberArray = [Int32](restTicketNumberSet)
                 let restTicketArrayLength = restTicketNumberArray.count
                 
                 var generatedIndexArray = [Int]()
                 var a = 0
                 while a < numberOfTicket {
                     let randomIndex = Int.random(in: 1...restTicketArrayLength)
                     ticketNumber = Int(restTicketNumberArray[randomIndex])//TODO crash
                     
                     generatedIndexArray.append(ticketNumber)
                     database.insert(ticket: Ticket(raffleID:Int32(raffleID),  raffleName:raffleName, ticketPrice:Int32(ticketPrice),customerID:Int32(customerID), customerName: customerName, purchaseDate: purchaseDate, winStatus: Int32(winStatus), ticketNumber: Int32(ticketNumber)))
                     
                     var flag = true
                     while flag {
                         var nextRandomIndex = Int.random(in: 1...restTicketArrayLength)
                         if  (generatedIndexArray.contains(nextRandomIndex)) {
                             continue
                         } else {
                             ticketNumber = Int(restTicketNumberArray[nextRandomIndex])
                             flag = false
                         }
                     }
                     a+=1
                 }
             }
         }
        
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
        {
             let detailViewController = segue.destination as! CustomerCusTableViewController
             let selectedRaffle = raffleselling
         detailViewController.raffleTemp = selectedRaffle
            detailViewController.ticketQty = numberOfTicket
            print(numberOfTicket)
        }
        else if segue.identifier == "GoTicketList"
        {
             let ticketListViewController = segue.destination as! TicketCusTableViewController
         ticketListViewController.raffleID = raffleID
        }
         else
        {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        }
 

}
