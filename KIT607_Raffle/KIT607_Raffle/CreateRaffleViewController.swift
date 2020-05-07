//
//  CreateRaffleViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 29/4/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit
import SwiftUI

var raffles2 = [Raffle]()
class CreateRaffleViewController: UIViewController {

    var raffleName = ""
    var raffleDes = ""
    var raffleType = 0
    var raffleDrawDate = "21/05/2020"
    var raffleLimit = 10000
    var rafflePrice = 5
    var launtchStatus = 0
    var drawStatus = 0

    @IBOutlet weak var raffleNameTextField: UITextField!
    
    @IBOutlet weak var drawDateTextField: UITextField!
    @IBOutlet weak var maxTicketNumberTextField: UITextField!
    
    @IBOutlet weak var createNewRaffleButton: UIButton!
    
    @IBOutlet weak var raffleDescriptionTextField: UITextField!
    
    @IBOutlet weak var rafflePriceTextField: UITextField!
    @IBOutlet weak var marginRaffleBtn: UIButton!
    
    @IBOutlet weak var normalRaffleBtn: UIButton!
    
    //click normal raffle button,raffle type=0
    
    @IBAction func raffleTypeBtn(_ sender: UIButton) {
        if sender.tag == 1 {
            normalRaffleBtn.isSelected = true
            marginRaffleBtn.isSelected = false
            raffleType = 0
            print("normal")
            print(raffleType)
        } else if sender.tag == 2 {
            marginRaffleBtn.isSelected = true
            normalRaffleBtn.isSelected = false
            raffleType = 1
            print("margin")
            print(raffleType)
        }
    }
    
  

 let datePciker = UIDatePicker()
    
    
    
//        let dateFormatter = DateFormatter()
//
//        dateFormatter.dateStyle = DateFormatter.Style.short
//        dateFormatter.timeStyle = DateFormatter.Style.short
//
//        let strDate = dateFormatter.string(from: raffleDataPicker.date)
//        raffleDatePick.text = strDate
   
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
          
        
       
    }
    //https://www.youtube.com/watch?v=8NngJrVFfUw
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        drawDateTextField.inputAccessoryView = toolbar
        drawDateTextField.inputView = datePciker
        
        
    }
    
    @objc func donePressed(){
        drawDateTextField.text = "\(datePciker.date)"
        self.view.endEditing(true)
    }
    
    @IBAction func newRaffleClicked(_ sender: UIButton) {
        raffleName = raffleNameTextField.text ?? "Raffle"
        raffleDes = raffleDescriptionTextField.text ?? "null"
        
        raffleDrawDate = drawDateTextField.text ?? "null"
        raffleLimit = Int( maxTicketNumberTextField.text!) ?? 10000
        rafflePrice = Int( rafflePriceTextField.text!) ?? 5
        launtchStatus = 0
        drawStatus = 0
        
        
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase");        database.insert(raffle:Raffle(name:raffleName,  description:raffleDes, type: Int32(Int(raffleType)),maxNumber:Int32(raffleLimit), ticketPrice: Int32(rafflePrice), launchStatus: 0, drawStatus:0, drawTime: raffleDrawDate))
        var refreshAlert=UIAlertController(title: "RaffleCreated", message: "", preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
          self.performSegue(withIdentifier: "goToRaffleTableView", sender: self)
          }))

//        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
//          print("Handle Cancel Logic here")
//          }))

        present(refreshAlert, animated: true, completion: nil)
                
        
//        self.performSegue(withIdentifier: "goToRaffleTableView", sender: self)

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoRaffleList" {
            
            let destinationVC = segue.destination as! RaffleCusTableViewController
            destinationVC.raffleName = raffleNameTextField.text ?? "Raffle"
            destinationVC.raffleDes = raffleDescriptionTextField.text ?? "null"
            destinationVC.raffleDrawDate = drawDateTextField.text ?? "null"
            destinationVC.raffleType = raffleType
            destinationVC.raffleLimit = Int( maxTicketNumberTextField.text!) ?? 10000
            
            
            
           
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
