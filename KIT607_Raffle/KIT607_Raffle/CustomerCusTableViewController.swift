//
//  CustomerViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 11/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit
var customers1 = [Customer]()

class CustomerCusTableViewController: UIViewController {
     var searchResult = [Customer]()
     var raffleTemp : Raffle?
    var searching = false
    var ticketQty : Int!
    var restTicketQty : Int!
     var isChooseCustomer = 1
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var customerTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        customerTable.dataSource = self
       let database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabase")
        customers1 = database.selectAllCustomers()
//        print(ticketQty!)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func returnAny(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
    }
    @IBAction func newCustomer(_ sender: UIButton) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Customer", message: "", preferredStyle: .alert)
        alert.addTextField{(alertTextfield) in alertTextfield.placeholder="Create new customer"
            textField = alertTextfield
        }
      alert.addAction(UIAlertAction(title: "Add Customer", style: .default, handler: { (action: UIAlertAction!) in
          // insert customer into database
           var database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabase")
        
        database.insert(customer: Customer(customerName:textField.text!))
        self.customerTable.dataSource = self
       let database1 : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabase")
        customers1 = database.selectAllCustomers()
            self.customerTable.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(action: UIAlertAction!) in
        }))
       
            present(alert, animated:true, completion:nil)
      
        
    }
    
}
//TOdosearch Bar
extension CustomerCusTableViewController:UISearchBarDelegate{

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         var database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabase")
        print(searchBar.text!)
        searchResult = database.selectCustomerByName(customerName: searchBar.text!)
        print("hello")
        searching = true
        customerTable.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            searching = false
            customerTable.reloadData()
            }
        }
    }



extension CustomerCusTableViewController: UITableViewDataSource, UITableViewDelegate{
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searching{
        return searchResult.count
    }else{
        return customers1.count
    }
    
}
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
var cell = tableView.dequeueReusableCell(withIdentifier: "CustomerCell", for: indexPath)
    if isChooseCustomer == 0{
        cell.isUserInteractionEnabled = false
          if searching {
              
          var customer = searchResult[indexPath.row]
              if   let  customerCell = cell as? CustomerTableViewCell
              {
                  customerCell.customerID.text = String(customer.ID)
                  customerCell.customerName.text = customer.customerName
                  
                  
              }
          } else{
              
              // Configure the cell...
              let customer = customers1[indexPath.row]
              if   let  customerCell = cell as? CustomerTableViewCell
              {
                  customerCell.customerID.text = String(customer.ID)
                  customerCell.customerName.text = customer.customerName
                  
                  
              }

          }
                  return  cell
    }
    if searching {
        
    var customer = searchResult[indexPath.row]
        if   let  customerCell = cell as? CustomerTableViewCell
        {
            customerCell.customerID.text = String(customer.ID)
            customerCell.customerName.text = customer.customerName
            
            
        }
    } else{
        
        // Configure the cell...
        let customer = customers1[indexPath.row]
        if   let  customerCell = cell as? CustomerTableViewCell
        {
            customerCell.customerID.text = String(customer.ID)
            customerCell.customerName.text = customer.customerName
            
            
        }

    }
    
    return cell
    
}
    
    override func   prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
//        if isChooseCustomer == 0{
//            return
//        }
        if segue.identifier == "chooseCustomer"
        {
            guard let   sellViewController = segue.destination as? SellTicketViewController else
        {
            fatalError("Unexpected destination: \(segue.destination)")
            
            }
            guard let   selectedCustomerCell = sender as? CustomerTableViewCell else
            {            fatalError("Unexpected sender: \( String(describing: sender))")
                
            }
            guard let   indexPath = customerTable.indexPath(for: selectedCustomerCell) else
            {
                fatalError("The selected cell is not being displayed by the table")
                
            }
            let  selectedCustomer = customers1[indexPath.row]
            sellViewController.customer = selectedCustomer
            let  selectedRaffle = raffleTemp
            sellViewController.raffleselling = selectedRaffle
            sellViewController.numberOfTicket = ticketQty
            sellViewController.restQtyOfTicket = restTicketQty
        }
        
        }
}
