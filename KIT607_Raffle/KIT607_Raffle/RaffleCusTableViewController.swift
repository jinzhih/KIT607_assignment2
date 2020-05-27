//
//  RaffleCusTableViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 7/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit
var raffles1 = [Raffle]()
class RaffleCusTableViewController: UIViewController {
    var raffleName = ""
    var raffleDes = ""
    var raffleType = 0
    var raffleDrawDate = "21/05/2020"
    var raffleLimit = 10000
    var rafflePrice = 5
    var launtchStatus = 0
    var drawStatus = 0
    var searchResult = [Raffle]()
    var searching = false
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var raffleTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        raffleTable.dataSource = self
//               raffleTable.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")

          var database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")

        raffles1 = database.selectAllRaffles()
        
        
    }
    
 
  //Go to create raffle view
    @IBAction func newRaffleBtn(_ sender: UIButton) {
          performSegue(withIdentifier: "newRaffleSegue", sender: self)
    }
    
    //Go to customer
    
    @IBAction func goCustomerBtn(_ sender: UIButton) {
            performSegue(withIdentifier: "goCustomerSegue", sender: self)
    }
    

    
}

func getDocumentsDirectory() -> URL {
       let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
       let documentsDirectory = paths[0]
       return documentsDirectory
   }
//retrievimagehttps://stackoverflow.com/questions/41641771/save-image-to-library-from-url-rename-and-share-it-using-swift
func loadImageFromName(name: String) -> UIImage? {
    print("Loading image with name \(name)")
    let path = //getDocumentsDirectory().appendingPathComponent(name).path
        getDocumentsDirectory().appendingPathComponent("\(name).jpg").path

    let image = UIImage(contentsOfFile: path)

    if image == nil {

        print("missing image at: \(path)")
    }
    return image
}
extension RaffleCusTableViewController:UISearchBarDelegate{


func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
     var database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabase")
    print(searchBar.text!)
    searchResult = //database.selectCustomerByName(customerName: searchBar.text!)
    database.selectRaffleByName(raffleName: searchBar.text!)
   // print("hello")
    searching = true
    raffleTable.reloadData()
}

func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text?.count == 0 {
        searching = false
        raffleTable.reloadData()
        }
    }
}
    extension RaffleCusTableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching{
            return searchResult.count
        }else{
            return raffles1.count
        }
       // return raffles1.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

if searching {
       print(searching)
    print(searchResult)
   var raffle = searchResult[indexPath.row]
    
       if   let  raffleCell = cell as? RaffleUITableViewCell
       {
           raffleCell.nameRaffle.text = raffle.name
           raffleCell.desRaffle.text = raffle.description
        if(raffle.imageURL != "1"){
        
             raffleCell.raffleImage.image = loadImageFromName(name: raffle.name)
           
        }
       }
    
   } else{
       
       // Configure the cell...
       let raffle = raffles1[indexPath.row]
       if   let  raffleCell = cell as? RaffleUITableViewCell
       {
        raffleCell.nameRaffle.text = raffle.name
           raffleCell.desRaffle.text = raffle.description
        
      //  raffleCell.raffleView.backgroundColor = UIColorFromHex(rgbValue: 0xd4f3ef,alpha: 1)
          if(raffle.imageURL != "1"){
                  
                       raffleCell.raffleImage.image = loadImageFromName(name: raffle.name)
                      
                  }
                    
           
       }
        
        }
                return cell
         
        
    }
    
        override func   prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            super.prepare(for: segue, sender: sender)
            if segue.identifier == "ShowRaffleDetailSegue"
            {
                guard let   detailViewController = segue.destination as? RaffleDetailViewController
                
          
            else
            {
                fatalError("Unexpected destination: \(segue.destination)")
                
                }
                guard let   selectedRaffleCell = sender as? RaffleUITableViewCell else
                {            fatalError("Unexpected sender: \( String(describing: sender))")
                    
                }
                guard let   indexPath = raffleTable.indexPath(for: selectedRaffleCell) else
                {
                    fatalError("The selected cell is not being displayed by the table")
                    
                }
                let  selectedRaffle = raffles1[indexPath.row]
                detailViewController.raffle = selectedRaffle
                
            }
            else if segue.identifier == "goCustomerSegue"
                                     {
                                          let CustomerListViewController = segue.destination as! CustomerCusTableViewController
                                     
                                         CustomerListViewController.isChooseCustomer = 0
                                     }
            
            }

        func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
            let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
            let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
            let blue = CGFloat(rgbValue & 0xFF)/256.0

            return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
        }
}

