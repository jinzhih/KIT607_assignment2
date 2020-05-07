//
//  RaffleCusTableViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 7/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit
var raffles1 = [Raffle]()
class RaffleCusTableViewController: UIViewController {
    var raffleName = ""
    var raffleDes = ""
    var raffles: [RaffleNew]=[
        RaffleNew(name: "Raffle1", raffleDate: "3/15/2020", img: "url"),
        RaffleNew(name: "Raffle2", raffleDate: "3/20/2020", img: "url"),
        RaffleNew(name: "Raffle1", raffleDate: "3/23/2020", img: "url")
    
    ]
    
    @IBOutlet weak var raffleTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        raffleTable.dataSource = self
//               raffleTable.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")

          let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
//        database.insert(raffle:Raffle(name:raffleName,  description:raffleDes, type:0,maxNumber:30, ticketPrice: 1, launchStatus: 0, drawStatus:0, drawTime: "tomorrow"))
        raffles1 = database.selectAllRaffles()
        
    }
    
}
    extension RaffleCusTableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return raffles1.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         let raffle = raffles1[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        as! Cell
//       cell.raffleName.text = raffle.name
//        cell.raffleDrawDate.text = raffle.drawTime
//
//        return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

                // Configure the cell...
                let raffle = raffles1[indexPath.row]
                if   let  raffleCell = cell as? RaffleUITableViewCell
                {
                    raffleCell.nameRaffle.text = raffle.name
                   raffleCell.desRaffle.text = raffle.description
                    
                }
                return cell
        
        
        
        
    }
    
        override func   prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            super.prepare(for: segue, sender: sender)
            if segue.identifier == "ShowRaffleDetailSegue"
            {         guard let   detailViewController = segue.destination as? RaffleDetailViewController else
            {
                fatalError("Unexpected destination: \(segue.destination)")
                
                }
                guard let   selectedRaffleCell = sender as? RaffleUITableViewCell else
                {            fatalError("Unexpected sender: \( String(describing: sender))")
                    
                }
                guard let   indexPath = raffleTable.indexPath(for: selectedRaffleCell) else
                {
                    fatalError("The selected cell is not being displayed by the table")
                    
                }
                let  selectedRaffle = raffles1[indexPath.row]
                detailViewController.raffle = selectedRaffle
                
            }
            
            }

}
