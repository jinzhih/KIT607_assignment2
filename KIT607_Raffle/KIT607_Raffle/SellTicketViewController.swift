//
//  SellTicketViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 10/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class SellTicketViewController: UIViewController {
   // var raffle : Raffle?
    var customer : Customer?
    var raffleselling : Raffle?
    var ticket = [Ticket]()
    var ticketsArray = [Int32]()
    var raffleID = 1
    var raffleName = ""
    var ticketPrice = 1
    var customerID = 1
    var customerName = ""
    var purchaseDate = ""
    var winStatus = 0
    var ticketNumber = 1
    var raffleType = 0
    var maxNumber = 0
    var numberOfTicket : Int!
    var restQtyOfTicket : Int!
    var displayDrawType=""
    
    @IBOutlet weak var raffleNameLable: UILabel!
    @IBOutlet weak var stepperForticketQty: UIStepper!
    
    @IBOutlet weak var raffleDes: UILabel!
    @IBOutlet weak var rafflePrice: UILabel!
    @IBOutlet weak var drawType: UILabel!
    @IBOutlet weak var ticketQty: UILabel!
    @IBOutlet weak var drawDate: UILabel!
    
    @IBOutlet weak var restTicketQty: UILabel!
    @IBOutlet weak var customerNameTextField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
 let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
        print(raffleselling?.ID)
        if(raffleselling?.ID == nil){
           // ticketQty.text = raffleselling?.maxNumber
        }
        ticketsArray = database.selectAllTicketNumberByRaffleID(raffleId: raffleselling!.ID) ?? [Int32]();
 
        let existingTicketArrayLength = ticketsArray.count
        restQtyOfTicket = Int(raffleselling!.maxNumber) - existingTicketArrayLength
        stepperForticketQty.maximumValue = Double(restQtyOfTicket)
        
        if let  displayCustomer = customer
        {
            customerNameTextField.text = displayCustomer.customerName 
           
        }
        if let displayRaffle = raffleselling{
            
            if(displayRaffle.type == 0){
                displayDrawType = "Normal Raffle"

            } else {
                displayDrawType = "Marging Raffle"
            }
            raffleNameLable.text = displayRaffle.name
            raffleDes.text = displayRaffle.description
            rafflePrice.text = String(displayRaffle.ticketPrice)
            drawType.text = displayDrawType
            drawDate.text = displayRaffle.drawTime
            restTicketQty.text = String(restQtyOfTicket)
            if numberOfTicket == nil{
                 numberOfTicket = 1
            }
            
            ticketQty.text = String(numberOfTicket)
            
        }
    }
    
    @IBAction func createNewTicket(_ sender: UIButton) {
        
          //verify if customer chosen
        if(customerNameTextField.text == ""){
            let refreshAlert=UIAlertController(title: "Verification", message: "Please choose a customer", preferredStyle: .alert)


            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                     
                     }))
            present(refreshAlert, animated: true, completion: nil)
            
        } else{
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
         raffleID = Int(raffleselling!.ID)
         raffleName = raffleselling!.name
         raffleType = Int(raffleselling!.type)
         ticketPrice = Int(raffleselling!.ticketPrice)
         customerID = Int(customer!.ID)
         customerName = customer!.customerName
         maxNumber = Int(raffleselling!.maxNumber)
         
            
         let dateformatter = DateFormatter()
         dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
         purchaseDate = dateformatter.string(from: Date())
        //这地方可以有一个买的票数+数据库现有票数<=最大票数的校验。不过更好的做法是，在售票界面上，显示余票还有多少。用户输入的购票数，必须小于等于余票，才能购买。否则第一时间就弹出提示。
        // Assign a ticket number
        
        //sell normal ticket
        func SaleNormalTicket(raffleID:Int,raffleName:String,raffleType:Int,ticketPrice:Int,customerID:Int,customerName:String,maxNumber:Int,purchaseDate:String
            ,numberOfTicket:Int)
         {
            if(raffleType != 0){
                return//不是普通票类型的，跳出该方法。
                
            }
        
             let currentMaxNumber = database.selectMaxTicketBy(id: Int32(raffleID)) ?? 0
             ticketNumber = Int(currentMaxNumber + 1)
             var a = 0
             while a < numberOfTicket
             {
                 database.insert(ticket: Ticket(raffleID:Int32(raffleID),  raffleName:raffleName, ticketPrice:Int32(ticketPrice),customerID:Int32(customerID), customerName: customerName, purchaseDate: purchaseDate, winStatus: Int32(winStatus), ticketNumber: Int32(ticketNumber)))
                ticket = database.selectTicketBy(id: Int32(raffleID))
                print(ticket.count)
                 ticketNumber += 1
                 a+=1
             }
         }
       func SaleMarginTicket(raffleID:Int,raffleName:String,raffleType:Int,ticketPrice:Int,customerID:Int,customerName:String,maxNumber:Int,purchaseDate:String
       ,numberOfTicket:Int)
                {
                    if(raffleType != 1) {
                        return
                    }
                    //先查下库里有哪些已经卖出的随机票。
                    //此处没有必要分成买过票和没买过票两种情况，因为没买过票，可以看成已卖过票(但票数为0)的一种特例
                    ticketsArray = database.selectAllTicketNumberByRaffleID(raffleId: Int32(raffleID)) ?? [Int32]();
                    let totalTicketArray = [Int32](1...Int32(maxNumber))
                    let restTicketNumberSet = Set(ticketsArray).symmetricDifference(totalTicketArray)
                    let restTicketNumberArray = [Int32](restTicketNumberSet)
                    let restTicketArrayLength = restTicketNumberArray.count
                    
                    var generatedIndexArray = [Int]()
                    var a = 0
                    while a < numberOfTicket {
                        let randomIndex = Int.random(in: 1...restTicketArrayLength)
                        if(generatedIndexArray.contains(randomIndex)){
                            continue
                        }
                          
                        //判断获取到的randomIndex下标是否已经存在，存在则继续下一次循环
                        ticketNumber = Int(restTicketNumberArray[randomIndex])
                        generatedIndexArray.append(randomIndex)
                        database.insert(ticket: Ticket(raffleID:Int32(raffleID),  raffleName:raffleName, ticketPrice:Int32(ticketPrice),customerID:Int32(customerID), customerName: customerName, purchaseDate: purchaseDate, winStatus: Int32(winStatus), ticketNumber: Int32(ticketNumber)))
                        print(tickets1.count)
                        a+=1
                    }
                }
        
        
        if raffleType == 0 {
             //For normal raffle
             SaleNormalTicket(raffleID: raffleID, raffleName: raffleName, raffleType: raffleType, ticketPrice: ticketPrice, customerID: customerID, customerName: customerName, maxNumber: maxNumber, purchaseDate: purchaseDate, numberOfTicket: numberOfTicket)
         } else if raffleType == 1 {
             //for margin raffle
             SaleMarginTicket(raffleID: raffleID, raffleName: raffleName, raffleType: raffleType, ticketPrice: ticketPrice, customerID: customerID, customerName: customerName, maxNumber: maxNumber, purchaseDate: purchaseDate, numberOfTicket: numberOfTicket)
         }
        
         let refreshAlert=UIAlertController(title: "TicketCreated", message: "", preferredStyle: .alert)


         refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                  self.performSegue(withIdentifier: "GoTicketList", sender: self)
                  }))
         present(refreshAlert, animated: true, completion: nil)

        }
    }
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        ticketQty.text = String(format: "%.0f", sender.value)
        numberOfTicket = Int(sender.value)
        if(numberOfTicket == restQtyOfTicket){
            let ticketLimitAlert=UIAlertController(title: "Warning", message: "Max ticket limit is \(String(restQtyOfTicket))", preferredStyle: .alert)


                    ticketLimitAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                             
                             }))
                    present(ticketLimitAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func addCustomerInfor(_ sender: UIButton) {
        performSegue(withIdentifier: "FindCustomer", sender: self)
    }
    

    
    override func   prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "FindCustomer"
        {
             let detailViewController = segue.destination as! CustomerCusTableViewController
             let selectedRaffle = raffleselling
         detailViewController.raffleTemp = selectedRaffle
            detailViewController.ticketQty = numberOfTicket
            detailViewController.restTicketQty = restQtyOfTicket
            
        }
        else if segue.identifier == "GoTicketList"
        {
             let ticketListViewController = segue.destination as! TicketCusTableViewController
         ticketListViewController.raffleID = raffleID
            ticketListViewController.raffle = raffleselling
            ticketListViewController.isNewTicket = 1
            print(raffleselling?.ID)
        }
         else
        {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        }

  

}
