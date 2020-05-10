import UIKit
public struct Raffle {
    var ID:Int32 = 1
    var name:String
    
    var description:String
    
    
    
    var type: Int32
    var maxNumber: Int32
    var ticketPrice: Int32
    var launchStatus: Int32
    var drawStatus: Int32
    var drawTime: String
    
    
  
}

                  
public struct Ticket {
    var ID:Int32 = 1
    var raffleID:Int32
    var raffleName:String
    var ticketPrice: Int32
    var customerID: Int32
    var customerName: String
    var purchaseDate: String
    var winStatus: Int32
    var ticketNumber: Int32
 
}
public struct Customer{
    var ID:Int32 = 1
    var customerName:String
    
}


struct RaffleNew {
    var name: String
    var raffleDate: String
    var img: String
}
