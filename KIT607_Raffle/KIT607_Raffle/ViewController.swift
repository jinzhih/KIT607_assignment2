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
class ViewController: UIViewController {

    // a handle to the database itself
    // you can switch databases or create new blank ones by changing databaseName
    var database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabasesdfg")

    override func viewDidLoad() {
        super.viewDidLoad()
//        database.insert(raffle:Raffle(name:"Raffle1",  description:"Normal Raffle"))
//        database.insert(raffle:Raffle(name:"Raffle2", description:"Margin Raffle"))
//database.insert(ticket: Ticket(raffleID:3,  raffleName:"raffle55667", ticketPrice:0,customerID:30, customerName: "hello", purchaseDate: "89/987/99", winStatus:0, ticketNumber: 1002))
        
//        UPDATE Ticket SET CustomerName=? WHERE ID=?
        database.updateTicket(customerName: "houjinzhi", id: 2)
//        (raffle: Raffle(name: "fengle2", description: "Raffle1", type: 3, maxNumber: 5, ticketPrice: 7, launchStatus: 9, drawStatus: 1, drawTime: "hello" ), id: 2)

     tickets = database.selectTicketBy(id: 3)
      //        print(database.selectRaffleBy(id: 4) ??  "Raffle not found")
              print(tickets )
        
        
    }

}

