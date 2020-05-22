//
//  EditTicketViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 22/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class EditTicketViewController: UIViewController,UITextFieldDelegate {
    var ticket : Ticket?
    var raffle: Raffle?
   
    @IBOutlet weak var raffleName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var drawDate: UILabel!
    
    @IBOutlet weak var ticketNO: UILabel!
    @IBOutlet weak var customerID: UILabel!
    
    @IBOutlet weak var customerName: UITextField!
    
    @IBOutlet weak var purchaseDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customerName.delegate = self

            if let  displayTicket = ticket
            {//raffle draw time show
                var database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabase")
                raffle=database.selectRaffleBy(id: Int32(ticket!.raffleID))
                drawDate.text = raffle?.drawTime
                raffleName.text = displayTicket.raffleName
                price.text = String(displayTicket.ticketPrice)
                ticketNO.text = String(displayTicket.ticketNumber)
                customerID.text = String(displayTicket.customerID)
                customerName.text = displayTicket.customerName
                purchaseDate.text = displayTicket.purchaseDate
               
                           }
        
                
            }
    
    @IBAction func confirmEditTicket(_ sender: UIButton) {
        //validate textfield
        let isNameNull = isAnString(string: (customerName?.text) ?? "")
        if(!isNameNull){
            alertSomeTextFieldNull()
            return
        }
        
        var database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabase")
        let customerIDNumber = ticket?.customerID
        let newCustomerName = customerName.text!
        database.updateCustomer(customerName: newCustomerName, id: customerIDNumber!)
        database.updateTicket(customerName: newCustomerName, id: customerIDNumber!)
       alertSuccessfulUpdateCustomer()
    }
    
    @IBAction func backToTicketDetail(_ sender: UIButton) {
       dismiss(animated: true, completion: nil)
           
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        customerName.endEditing(true)
        
        return true
    }
    
    // validate textfield if no input
         
           func isAnString(string: String) -> Bool {
               if( string != "")
               {
                   return true
                   
               }
                   return false
           }
    //Alert Function
    func alertSomeTextFieldNull(){
        let inputAlert=UIAlertController(title: "Alert", message: "Plesase input customer name", preferredStyle: .alert)
                inputAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                      
                   
                present(inputAlert, animated: true, completion: nil)
    }
    
    func alertSuccessfulUpdateCustomer(){
           let inputAlert=UIAlertController(title: "Notice", message: "Customer name updated", preferredStyle: .alert)
                   inputAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                   self.performSegue(withIdentifier: "deliveryCustomerNameSegue", sender: self)
                   }))
              //performSegue(withIdentifier: "deliveryCustomerNameSegue", sender: self)
                      
                   present(inputAlert, animated: true, completion: nil)
       }
    
    override func   prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "deliveryCustomerNameSegue"
        {
            var database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabase");
            let   backToTicketDetailViewController = segue.destination as! TicketDetailViewController
            let  selectedTicket = database.selectTicketByTicketID(id: ticket!.ID)
            backToTicketDetailViewController.ticket = selectedTicket
        }
        
         else
        {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        }
    
         
    
    
}
    
    

