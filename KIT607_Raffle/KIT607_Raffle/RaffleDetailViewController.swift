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

    @IBOutlet var nameRaffle: UILabel!
    
    @IBOutlet var desRaffle: UILabel!
    
    @IBOutlet weak var drawDate: UILabel!
    
    @IBOutlet weak var drawType: UILabel!
    @IBOutlet weak var drawLimit: UILabel!
    @IBOutlet weak var drawPrice: UILabel!
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
                
                
                   
                   
               }
    }
//    let segue: UIStoryboardSegue
    @IBAction func sellTicket(_ sender: UIButton) {
        performSegue(withIdentifier: "SellingTicket", sender: self)
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
            print("this is normal raffle")
        }
         
    }
    

    
    
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
            else if segue.identifier == "DrawWinner"
            {
                 let DrawWinnerViewController = segue.destination as! DrawWinnerViewController
             DrawWinnerViewController.raffleID = Int(raffle!.ID)
            }
            else
           {
               fatalError("Unexpected destination: \(segue.destination)")
           }
           
           }
    


       
        
 
    
    @IBAction func backToRaffle(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
}
