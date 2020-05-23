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
    var raffle: Raffle?
    var isRaffleClose = true
    var drawDateFlag = Date()
    var newcustomerName = ""
    @IBOutlet weak var raffleName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var drawDate: UILabel!
    @IBOutlet weak var ticketNO: UILabel!
    @IBOutlet weak var customerID: UILabel!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var purchaseDate: UILabel!
    @IBOutlet weak var winStatus: UILabel!
    
    @IBOutlet weak var winStatusShow: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            winStatus.text = String(displayTicket.winStatus)
            
                       let imgArray = [#imageLiteral(resourceName: "Won"), #imageLiteral(resourceName: "Lose"), #imageLiteral(resourceName: "NotStart")]
                       //if draw date over not show not started
                       //yes show winstatus
                      
                       
                       let drawDateFlag = convertDateFormat(inputDate: drawDate.text!)
                       if(drawDateFlag >
                           Date()){
                           winStatusShow.image = imgArray[2]
                        isRaffleClose = false
                        
                      //     viewDidLoad()
                        return
                       }else if(winStatus.text == "0"){
                           winStatusShow.image = imgArray[1]
                       
                        return
                         //  viewDidLoad()
                       }else if(winStatus.text == "1"){
                           winStatusShow.image = imgArray[0]
                  
                          // viewDidLoad()
                       }
                      
            
            
            
    //TODO search DrawDate according to Raffle ID
        
            
            
        }
                      
    }
    
    func convertDateFormat(inputDate: String) -> Date {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
         let newDate = convertDateFormatter.date(from: inputDate)
        return newDate!
    }
    
    @IBAction func goToTicketTable(_ sender: UIButton) {
        //  dismiss(animated: true, completion: nil)
        //backToTicketListSegue
        performSegue(withIdentifier: "backToTicketListSegue", sender: self)    }
    
    @IBAction func editTicketBtn(_ sender: UIButton) {
        //goToEditTicketSegue
           if(!isRaffleClose){
                     performSegue(withIdentifier: "goToEditTicketSegue", sender: self)
                      return
                  }
                  editImpossibleAlert()
        
    }
    func editImpossibleAlert(){
           let editAlert=UIAlertController(title: "CANNOT EDIT", message: "Raffle has already drawn", preferredStyle: .alert)
           editAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction!) in
                 }))
                 
                  present(editAlert, animated: true, completion: nil)
       }
   
    override func   prepare(for segue: UIStoryboardSegue, sender: Any?)
       {
           super.prepare(for: segue, sender: sender)
           if segue.identifier == "goToEditTicketSegue"
           {
             
            let   editViewController = segue.destination as! EditTicketViewController
               let  selectedRaffle = ticket
           editViewController.ticket = selectedRaffle
           } else if
            segue.identifier == "backToTicketListSegue"
                  {
                       let ticketListViewController = segue.destination as! TicketCusTableViewController
                    ticketListViewController.raffleID = Int(ticket!.raffleID)
                  }
           
            else
           {
               fatalError("Unexpected destination: \(segue.destination)")
           }
           
           }
    

}
