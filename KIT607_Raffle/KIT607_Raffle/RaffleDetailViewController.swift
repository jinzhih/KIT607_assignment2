//
//  RaffleDetailViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 26/4/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class RaffleDetailViewController: UIViewController {
    var raffle : Raffle?
    var displayDrawType=""
    var lowscore : Int!
    var highscore : Int!
    var ticketsArray = [Int32]()
    var timepassed = 0
    var ticket = [TicketNOArrayForDraw]()
    var ticketwinneraray = [TicketNOArrayForDraw]()
   
    @IBOutlet var nameRaffle: UILabel!
    
    @IBOutlet var desRaffle: UILabel!
    
    @IBOutlet weak var drawDate: UILabel!
    var winnerName = String()
    
    @IBOutlet weak var drawButton: UIButton!
    @IBOutlet weak var drawType: UILabel!
    @IBOutlet weak var drawLimit: UILabel!
    @IBOutlet weak var drawPrice: UILabel!
    @IBOutlet weak var winnerQty: UILabel!
    @IBOutlet weak var drawImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Do any additional setup after loading the view.
        if let  displayRaffle = raffle
               {
               
                if(displayRaffle.type == 0){
                    displayDrawType = "Normal Raffle"

                } else {
                    displayDrawType = "Marging Raffle"
                }
                
                nameRaffle.text  = displayRaffle.name
                desRaffle.text = displayRaffle.description
                drawDate.text = displayRaffle.drawTime
                drawType.text = displayDrawType
                drawLimit.text = String(displayRaffle.maxNumber)
                drawPrice.text = String(displayRaffle.ticketPrice)
                winnerQty.text = String( displayRaffle.winQty)
              //set time

                let imgArray = [#imageLiteral(resourceName: "671590154412_.pic"), #imageLiteral(resourceName: "Draw Time is not up!")]
                     
                     let drawDateFlag = convertDateFormat(inputDate: drawDate.text!)
                     if(drawDateFlag >
                         Date()){
                         drawImg.image = imgArray[1]
                       drawButton.isEnabled = false
                      
                    //     viewDidLoad()
                      return
                     }
                drawImg.image = imgArray[0]
                  drawButton.isEnabled = true
                   
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
//    let segue: UIStoryboardSegue
    @IBAction func sellTicket(_ sender: UIButton) {
        performSegue(withIdentifier: "SellingTicket", sender: self)
    }
    
    //delte raffle
    @IBAction func deleteRaffleBtn(_ sender: UIButton) {
        //justify if sold tickets
        if(soldTicketsYes(id: raffle!.ID)){
            let deleteSuccessAlert=UIAlertController(title: "CANNOT delete", message: "There are sold tickets", preferredStyle: .alert)
            deleteSuccessAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                  
               
            present(deleteSuccessAlert, animated: true, completion: nil)
            return
        }
        alertDelete(id: raffle!.ID)
      
    }

    
    @IBAction func ticketListShowBtn(_ sender: UIButton) {
              performSegue(withIdentifier: "ShowTicketList", sender: self)
        
    }
    
    @IBAction func drawRaffleBtn(_ sender: UIButton) {
        print(raffle!.type)
        let identifier = Bool(raffle!.type as NSNumber)
        if identifier {
            performSegue(withIdentifier: "DrawWinner", sender: self)
        } else{
            
                 let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase");
                                   ticket = database.selectTicketNoAndIDByRaffleID(id: raffle!.ID)
                                   print(ticket)
                                   //let soldTicketLength = ticket.count
                                   //reorder ticket by ID
            var drawnumber = 1
            if ticket.count < raffle!.winQty{
                 drawnumber = ticket.count
                let newticket = ticket.shuffled().prefix(drawnumber)
                
               
                print(newticket)
                
                var a = 0
                while a<drawnumber{
                    let ID = newticket[0].ID
                    
                }
                
                
                return
            }
            drawnumber = Int(raffle!.winQty)
                                   let newticket = ticket.shuffled().prefix(drawnumber)
                                   print(newticket)
        }
         
    }
    //alert
    func alertSomeTextFieldNull(name: String){
              let inputAlert=UIAlertController(title: "Congratulation", message: "The winners are \(name)", preferredStyle: .alert)
                      inputAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            
                         
                      present(inputAlert, animated: true, completion: nil)
          }

    //goToEditRaffleSegue
    
    override func   prepare(for segue: UIStoryboardSegue, sender: Any?)
       {
           super.prepare(for: segue, sender: sender)
           if segue.identifier == "SellingTicket"
           {
             
            let   detailViewController = segue.destination as! SellTicketViewController
               let  selectedRaffle = raffle
            detailViewController.raffleselling = selectedRaffle
           }
           else if segue.identifier == "ShowTicketList"
           {
                let ticketListViewController = segue.destination as! TicketCusTableViewController
            ticketListViewController.raffleID = Int(raffle!.ID)
           }
            else if segue.identifier == "goToEditRaffleSegue"
                      {
                           let editRaffleViewController = segue.destination as! RaffleEditViewController
                        editRaffleViewController.raffle = raffle
                      }
            else if segue.identifier == "DrawWinner"
            {
                 let DrawWinnerViewController = segue.destination as! DrawWinnerViewController
             DrawWinnerViewController.raffleID = Int(raffle!.ID)
            }
           else if segue.identifier == "returnRaffleList"
           {
            print("delet successed")
           }
            else
           {
               fatalError("Unexpected destination: \(segue.destination)")
           }
           
           }
    // normal raffle select winner
  
    //Alert Function
    func alertDelete(id: Int32){
        let warningAlert=UIAlertController(title: "Delete", message: "Are you want to delete raffle", preferredStyle: .alert)
        
        
        warningAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
            let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase");
            database.deleteRaffleBy(id: id)
            self.deleteSuccessAlert()
            
        }))
        warningAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            //returnRaffleList
            
            // self.dismiss(animated: true, completion: nil)
        }))
        present(warningAlert, animated: true, completion: nil)
        
    }
    
    //Delet success function
    func deleteSuccessAlert(){
        let deleteSuccessAlert=UIAlertController(title: "Delete", message: "Succesfully delete", preferredStyle: .alert)
        deleteSuccessAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction!) in
            self.performSegue(withIdentifier: "returnRaffleList", sender: self)        }))
              
           
               present(deleteSuccessAlert, animated: true, completion: nil)
    }
    //update cnnot alert
    func editImpossibleAlert(){
        let editAlert=UIAlertController(title: "CANNOT EDIT", message: "There are sold tickets", preferredStyle: .alert)
        editAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction!) in
              }))
              
               present(editAlert, animated: true, completion: nil)
    }
    

    // delete vertification if have sold tickets no delete
    func soldTicketsYes(id: Int32)  -> Bool {
             let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase");
           ticketsArray = database.selectAllTicketNumberByRaffleID(raffleId: id) ?? [Int32]();
           let existingTicketArrayLength = ticketsArray.count
             if (existingTicketArrayLength > 0) {
                 
                 return  true
             }
    
             return false
        
         }
        
    @IBAction func editRaffleBtn(_ sender: UIButton) {
        if(!soldTicketsYes(id: raffle!.ID)){
           performSegue(withIdentifier: "goToEditRaffleSegue", sender: self)
            return
        }
        editImpossibleAlert()
        
    }
    
    
    @IBAction func backToRaffle(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
}


