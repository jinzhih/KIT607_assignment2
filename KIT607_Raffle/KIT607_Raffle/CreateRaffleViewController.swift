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
class CreateRaffleViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var drawDateTextField: UITextField!
    @IBOutlet weak var maxTicketNumberTextField: UITextField!
    
    @IBOutlet weak var winnerQtyLable: UILabel!
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
    
  

 let datePicker = UIDatePicker()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        raffleNameTextField.delegate = self
        maxTicketNumberTextField.delegate = self
        rafflePriceTextField.delegate = self
        raffleDescriptionTextField.delegate = self
        winnerQtyTextField.delegate = self
        
          
        
       
    }
    
    @IBAction func returnRaffleList(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    //choose cover
    @IBAction func selectCoverBtn(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                   print("Gallery available")
                   
                   let imagePicker:UIImagePickerController = UIImagePickerController()
                   imagePicker.delegate = self
                   imagePicker.sourceType = .photoLibrary;
                   imagePicker.allowsEditing = false
                   
                   self.present(imagePicker, animated: true, completion: nil)
               }

        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imageView.image = image
            dismiss(animated: true, completion: nil)
        }
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
    //raffleDescriptionTextField
    @IBAction func newRaffleClicked(_ sender: UIButton) {
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
          let dateformatter = DateFormatter()
               dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let  drawDate = dateformatter.string(from: datePicker.date)
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase");        database.insert(raffle:Raffle(name:raffleName,  description:raffleDes, type: Int32(Int(raffleType)),maxNumber:Int32(raffleLimit), ticketPrice: Int32(rafflePrice), launchStatus: 0, drawStatus:0, drawTime: drawDate, winQty: Int32(winnerQty)))
        
        var refreshAlert=UIAlertController(title: "RaffleCreated", message: "", preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
          self.performSegue(withIdentifier: "GoRaffleList", sender: self)
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
