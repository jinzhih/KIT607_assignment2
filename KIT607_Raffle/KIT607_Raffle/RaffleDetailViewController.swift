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
//        super.prepare(for: segue, sender: self)
//        if segue.identifier == "SellingTicket"
//               {
//                   guard let   detailViewController = segue.destination as? SellTicketViewController else
//               {
//                   fatalError("Unexpected destination: \(segue.destination)")
//
//                   }
//
//                   let  selectedRaffle = raffle
//                   detailViewController.raffleselling = selectedRaffle
//
//               }
//
             
    override func   prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "SellingTicket"
        {         guard let   detailViewController = segue.destination as? SellTicketViewController else
        {
            fatalError("Unexpected destination: \(segue.destination)")
            
            }
            
            let  selectedRaffle = raffle
            detailViewController.raffleselling = selectedRaffle
      
            
        }
        
        }

       
        
 
    
    @IBAction func backToRaffle(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
}
