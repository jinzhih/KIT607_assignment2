//
//  RaffleEditViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 22/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class RaffleEditViewController: UIViewController, UITextFieldDelegate {
    var raffles2 = [Raffle]()
    var raffle : Raffle?
    var raffleName = ""
    var raffleDes = ""
    var raffleType = 0
    var raffleDrawDate = "21/05/2020"
    var raffleLimit = 10000
    var rafflePrice = 5
    var launtchStatus = 0
    var drawStatus = 0
    var winnerQty = 1
     let datePicker = UIDatePicker()
    
    @IBOutlet weak var raffleNameTextField: UITextField!
    
    @IBOutlet weak var winnerQtyLable: UILabel!
    @IBOutlet weak var normalRaffleBtn: UIButton!
    @IBOutlet weak var marginRaffleBtn: UIButton!
    @IBOutlet weak var drawDateTextField: UITextField!
    @IBOutlet weak var maxTicketNumberTextField: UITextField!
    
    @IBOutlet weak var winnerQtyTextField: UITextField!
    @IBOutlet weak var raffleDescriptionTextField: UITextField!
    @IBOutlet weak var rafflePriceTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
               raffleNameTextField.delegate = self
               maxTicketNumberTextField.delegate = self
               rafflePriceTextField.delegate = self
               raffleDescriptionTextField.delegate = self
               winnerQtyTextField.delegate = self
        if let  displayRaffle = raffle
        {
                     raffleNameTextField.text  = displayRaffle.name
                     raffleDescriptionTextField.text = displayRaffle.description
                     drawDateTextField.text = displayRaffle.drawTime
                     
                     maxTicketNumberTextField.text = String(displayRaffle.maxNumber)
                     rafflePriceTextField.text = String(displayRaffle.ticketPrice)
                  //   winnerQtyTextField.text = String( displayRaffle.winQty)
            if(raffle!.type == 0){
                winnerQtyTextField.text = String( displayRaffle.winQty)
                normalRaffleBtn.isSelected = true
                marginRaffleBtn.isSelected = false
                return
            }else if (raffle!.type == 1){
                raffleType = 1
                marginRaffleBtn.isSelected = true
                normalRaffleBtn.isSelected = false
                winnerQtyLable.isHidden = true
                winnerQtyTextField.isHidden = true
            }
                        
      }
        
        
        
    }
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
        let dateformatter = DateFormatter()
         dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
       let  drawDate = dateformatter.string(from: datePicker.date)
        drawDateTextField.text = drawDate
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
    
    @IBAction func raffleTypeBtn(_ sender: UIButton) {
        if sender.tag == 1 {
                   normalRaffleBtn.isSelected = true
                   marginRaffleBtn.isSelected = false
                   raffleType = 0
                   
                   winnerQtyLable.isHidden = false
                     winnerQtyTextField.isHidden = false
               } else if sender.tag == 2 {
                   marginRaffleBtn.isSelected = true
                   normalRaffleBtn.isSelected = false
                   raffleType = 1
                   winnerQtyLable.isHidden = true
                   winnerQtyTextField.isHidden = true
               }
    }
    
    @IBAction func backToRaffleDetailBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func editRaffleBtn(_ sender: UIButton) {
        
        let validator = isAllFieldFilled(name: ((raffleNameTextField?.text) ?? ""), description: ((raffleDescriptionTextField?.text) ?? ""), maxTicketNumber: maxTicketNumberTextField.text!, price: rafflePriceTextField.text!, winnerQty: winnerQtyTextField.text!,date:((drawDateTextField?.text) ?? "") )
               let validatorForMargin = isAllFieldFilledForMargin(name: ((raffleNameTextField?.text) ?? ""), description: ((raffleDescriptionTextField?.text) ?? ""), maxTicketNumber: maxTicketNumberTextField.text!, price: rafflePriceTextField.text!,date:((drawDateTextField?.text) ?? ""))
              
               if(raffleType == 0){
                    
                   if (!validator){
                              alertSomeTextFieldNull()
                       
                              return
                          }
                   else if (!isWinnerQtySetRight()){
                       alertWinnerSetProblem()
                       return
                   }
                  
               }else if(raffleType == 1){
                   if (!validatorForMargin){
                              alertSomeTextFieldNull()
                              return
                          }
               
               }
               
               
               
               raffleName = raffleNameTextField.text ?? "Raffle"
               raffleDes = raffleDescriptionTextField.text ?? "null"
               
               raffleDrawDate = drawDateTextField.text ?? "null"
               raffleLimit = Int( maxTicketNumberTextField.text!) ?? 10000
               rafflePrice = Int( rafflePriceTextField.text!) ?? 5
               launtchStatus = 0
               drawStatus = 0
               winnerQty=Int(winnerQtyTextField.text!) ?? 1
               //verify
               
               
               let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase");        //database.insert(raffle:Raffle(name:raffleName,  description:raffleDes, type: Int32(Int(raffleType)),maxNumber:Int32(raffleLimit), ticketPrice: Int32(rafflePrice), launchStatus: 0, drawStatus:0, drawTime: raffleDrawDate, winQty: Int32(winnerQty)))
        database.updateRaffle(raffle: Raffle(name:raffleName,  description:raffleDes, type: Int32(Int(raffleType)),maxNumber:Int32(raffleLimit), ticketPrice: Int32(rafflePrice), launchStatus: 0, drawStatus:0, drawTime: raffleDrawDate, winQty: Int32(winnerQty)), id: raffle!.ID)
               
               var refreshAlert=UIAlertController(title: "RaffleUpdated", message: "", preferredStyle: .alert)

               refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                 self.performSegue(withIdentifier: "goToRaffleListFromEdit", sender: self)
                 }))



               present(refreshAlert, animated: true, completion: nil)
                       
    }
    //validate textfield if no input or string return false
        
       func isAnInt(string: String) -> Bool {
           if( Int(string) != nil)
           {
               return true
               
           }
               return false
       }
       // validate textfield if no input
       
         func isAnString(string: String) -> Bool {
             if( string != "")
             {
                 return true
                 
             }
                 return false
         }
       
       //validate all the field
       func isAllFieldFilled(name: String, description: String, maxTicketNumber: String, price: String, winnerQty: String, date: String) -> Bool{
           let isNameNull = isAnString(string: name)
           let isDesNull = isAnString(string: description)
           let isMaxTicketNumberInt = isAnInt(string: maxTicketNumber)
           let isPriceInt = isAnInt(string: price)
           let isWinnerQtyInt = isAnInt(string: winnerQty)
           let isDateNull = isAnString(string: date)
           
           if(isNameNull && isDesNull&&isMaxTicketNumberInt&&isPriceInt&&isWinnerQtyInt&&isDateNull){
               return true
           }
           return false
       }
       
       
       func isAllFieldFilledForMargin(name: String, description: String, maxTicketNumber: String, price: String, date: String) -> Bool{
           let isNameNull = isAnString(string: name)
           let isDesNull = isAnString(string: description)
           let isMaxTicketNumberInt = isAnInt(string: maxTicketNumber)
           let isPriceInt = isAnInt(string: price)
           let isDateNull = isAnString(string: date)
           if(isNameNull && isDesNull&&isMaxTicketNumberInt&&isPriceInt&&isDateNull){
               return true
           }
           return false
       }
       // if Winner Qty should be less than max ticket number
       func isWinnerQtySetRight()-> Bool{
           let difference = Int(winnerQtyTextField.text!)! - Int( maxTicketNumberTextField.text!)!
           if (difference <= 0){
               
               return true
           }
           return false
       }
       
       
       //Alert Function
       func alertSomeTextFieldNull(){
           let inputAlert=UIAlertController(title: "Alert", message: "Plesase input raffle information", preferredStyle: .alert)
                   inputAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                         
                      
                   present(inputAlert, animated: true, completion: nil)
       }
       
       func alertWinnerSetProblem(){
           let inputAlert=UIAlertController(title: "Alert", message: "Winner Qty should be less than max ticket number", preferredStyle: .alert)
           inputAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                 
              
           present(inputAlert, animated: true, completion: nil)
       }
   
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     if segue.identifier == "goToRaffleListFromEdit" {
         
         let destinationVC = segue.destination as! RaffleCusTableViewController
         destinationVC.raffleName = raffleNameTextField.text ?? "Raffle"
         destinationVC.raffleDes = raffleDescriptionTextField.text ?? "null"
         destinationVC.raffleDrawDate = drawDateTextField.text ?? "null"
         destinationVC.raffleType = raffleType
         destinationVC.raffleLimit = Int( maxTicketNumberTextField.text!) ?? 10000
         
         
         
        
     }
 }
    
    
    
}
