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
class CreateRaffleViewController: UIViewController, UITextFieldDelegate {

    var raffleName = ""
    var raffleDes = ""
    var raffleType = 0
    var raffleDrawDate = "21/05/2020"
    var raffleLimit = 10000
    var rafflePrice = 5
    var launtchStatus = 0
    var drawStatus = 0
    var winnerQty = 1

    @IBOutlet weak var raffleNameTextField: UITextField!
    
    @IBOutlet weak var drawDateTextField: UITextField!
    @IBOutlet weak var maxTicketNumberTextField: UITextField!
    
    @IBOutlet weak var createNewRaffleButton: UIButton!
    
    @IBOutlet weak var winnerQtyTextField: UITextField!
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
    
  

 let datePicker = UIDatePicker()
  //  datePciker.minimumDate = Date()
    
    
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
        raffleNameTextField.delegate = self
        maxTicketNumberTextField.delegate = self
        rafflePriceTextField.delegate = self
        raffleDescriptionTextField.delegate = self
        winnerQtyTextField.delegate = self
        
          
        
       
    }
    //https://www.youtube.com/watch?v=8NngJrVFfUw
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        drawDateTextField.inputAccessoryView = toolbar
        drawDateTextField.inputView = datePicker
        datePicker.minimumDate = Date()
        
    }
    
    @objc func donePressed(){
        drawDateTextField.text = "\(datePicker.date)"
        self.view.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        raffleDescriptionTextField.endEditing(true)
        winnerQtyTextField.endEditing(true)
        raffleNameTextField.endEditing(true)
        maxTicketNumberTextField.endEditing(true)
        rafflePriceTextField.endEditing(true)
        return true
    }
    
    @IBAction func newRaffleClicked(_ sender: UIButton) {
        raffleName = raffleNameTextField.text ?? "Raffle"
        raffleDes = raffleDescriptionTextField.text ?? "null"
        
        raffleDrawDate = drawDateTextField.text ?? "null"
        raffleLimit = Int( maxTicketNumberTextField.text!) ?? 10000
        rafflePrice = Int( rafflePriceTextField.text!) ?? 5
        launtchStatus = 0
        drawStatus = 0
        winnerQty=Int(winnerQtyTextField.text!) ?? 1
        //verify Int
        let isInt = isStringAnInt(string: winnerQtyTextField.text!)
        print(isInt)
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase");        database.insert(raffle:Raffle(name:raffleName,  description:raffleDes, type: Int32(Int(raffleType)),maxNumber:Int32(raffleLimit), ticketPrice: Int32(rafflePrice), launchStatus: 0, drawStatus:0, drawTime: raffleDrawDate, winQty: Int32(winnerQty)))
        
        var refreshAlert=UIAlertController(title: "RaffleCreated", message: "", preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
          self.performSegue(withIdentifier: "GoRaffleList", sender: self)
          }))



        present(refreshAlert, animated: true, completion: nil)
                


        
    }
   
    func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
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
