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
    @IBOutlet weak var ticketTable: UITableView!
    
    var customerName=""
      var raffleID = 0
       var ticketNumber = 0
      
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
