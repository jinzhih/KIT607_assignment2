//
//  ViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 26/4/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit
var tickets = [Ticket]()
var raffles = [Raffle]()
var customers = [Customer]()
var ticketNumber = Int32()
var tickets2 : Ticket?
class ViewController: UIViewController {
var ticketID : [Int32]?
    // a handle to the database itself
    // you can switch databases or create new blank ones by changing databaseName
    var database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabase")

    override func viewDidLoad() {
        super.viewDidLoad()
     //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//        database.insert(raffle:Raffle(name:"Raffle1",  description:"Normal Raffle"))
////        database.insert(raffle:Raffle(name:"Raffle2", description:"Margin Raffle"))
//database.insert(ticket: Ticket(raffleID:1,  raffleName:"raffle55667", ticketPrice:0,customerID:30, customerName: "hello", purchaseDate: "89/987/99", winStatus:0, ticketNumber: 5))
        
//        UPDATE Ticket SET CustomerName=? WHERE ID=?
//        database.updateTicket(customerName: "houjinzhi", id: 2)
//        (raffle: Raffle(name: "fengle2", description: "Raffle1", type: 3, maxNumber: 5, ticketPrice: 7, launchStatus: 9, drawStatus: 1, drawTime: "hello" ), id: 2)
       
       // database.insert(customer: Customer(customerName:"Judy"))
       // database.updateCustomer(customerName: "jessie", id: 1)
      //  database.selectCustomerByName(customerName: "Judy")
       // ticketNumber = database.selectMaxTicketBy(id: 1)!
      //  tickets = database.selectTicketBy(id: 1)
      //        print(database.selectRaffleBy(id: 4) ??  "Raffle not found")
      //  customers = database.selectAllCustomers()
      //  print(tickets)
        //      print(ticketNumber)
       // ticketID=database.selectWinnerBy(raffleId: 1, difference: 1)
        //ticketID = database.selectAllTicketNoByRaffleID(raffleId: 1)
       // print(ticketID!)
       
      //  raffles = database.selectAllRaffles()
      //  print(raffles)
     
       // database.updateWinStatusbyID(winStatus: 1, id: 49)
       print(database.selectAllRaffles())
         // tickets2=database.selectTicketNoAndIDByRaffleID(id: 6)
      //  tickets2=database.selectTicketByTicketID(id: 49)
      //   print(tickets2)
      //  database.updateTicket(customerName: <#T##String#>, id: <#T##Int32#>)
        
    }

}

