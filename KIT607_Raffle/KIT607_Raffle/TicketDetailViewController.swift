//
//  TicketDetailViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 10/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class TicketDetailViewController: UIViewController {
var ticket : Ticket?
    
    @IBOutlet weak var raffleName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var drawDate: UILabel!
    @IBOutlet weak var ticketNO: UILabel!
    @IBOutlet weak var customerID: UILabel!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var purchaseDate: UILabel!
    @IBOutlet weak var winStatus: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let  displayTicket = ticket
        {
            raffleName.text = displayTicket.raffleName
            price.text = String(displayTicket.ticketPrice)
            ticketNO.text = String(displayTicket.ticketNumber)
            customerID.text = String(displayTicket.customerID)
            customerName.text = displayTicket.customerName
            purchaseDate.text = displayTicket.purchaseDate
            winStatus.text = String(displayTicket.winStatus)
            
            
                        
        }
                      
    }
    
    @IBAction func goToTicketTable(_ sender: UIButton) {
          dismiss(animated: true, completion: nil)
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
