//
//  CreateRaffleViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 29/4/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class CreateRaffleViewController: UIViewController {

    @IBOutlet weak var raffleNameTextField: UITextField!
    
    @IBOutlet weak var drawDateTextField: UITextField!
    @IBOutlet weak var maxTicketNumberTextField: UITextField!
    
    @IBOutlet weak var createNewRaffleButton: UIButton!
    
    @IBOutlet weak var raffleDescriptionTextField: UITextField!
    
    @IBOutlet weak var rafflePriceTextField: UITextField!
    @IBOutlet weak var nomalRaffleButton: UIButton!
    
    //click normal raffle button,raffle type=0
    @IBAction func normalRaffleButton(_ sender: UIButton) {
    }
    
        //click normal raffle button,raffle type=1
    @IBAction func marginRaffleButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func newRaffleClicked(_ sender: UIButton) {
        
        
        
        self.performSegue(withIdentifier: "goToRaffleTableView", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToRaffleTableView" {
            
            let destinationVC = segue.destination as! RaffleUITableViewController
            destinationVC.raffleName = raffleNameTextField.text!
            destinationVC.raffleDes = raffleDescriptionTextField.text!
           
        }
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
