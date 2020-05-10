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
    

    @IBAction func backToRaffle(_ sender: Any) {
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
