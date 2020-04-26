//
//  ViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 26/4/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // a handle to the database itself
    // you can switch databases or create new blank ones by changing databaseName
    var database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabasesdfg")

    override func viewDidLoad() {
        super.viewDidLoad()
        database.insert(raffle:Raffle(name:"Raffle1",  description:"Normal Raffle"))
        database.insert(raffle:Raffle(name:"Raffle2", description:"Margin Raffle"))

        print(database.selectAllRaffles())
      print(database.selectRaffleBy(id: 1) ??  "Raffle not found")
    }

}

