//
//  SellTicketViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 10/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class SellTicketViewController: UIViewController {
    
    var customer : Customer?
    var raffleselling : Raffle?
    
    var numberOfTicket = 1
    var customerName = ""
    var displayDrawType=""
    @IBOutlet weak var raffleName: UILabel!
    
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
            raffleName.text = displayRaffle.name
            raffleDes.text = displayRaffle.description
            rafflePrice.text = String(displayRaffle.ticketPrice)
            drawType.text = displayDrawType
            drawDate.text = displayRaffle.drawTime
            
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        ticketQty.text = String(format: "%.0f", sender.value)
        numberOfTicket = Int(sender.value)
    }
    
    @IBAction func addCustomerInfor(_ sender: UIButton) {
        performSegue(withIdentifier: "FindCustomer", sender: self)
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
