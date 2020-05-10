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

    @IBOutlet weak var customerTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        customerTable.dataSource = self
        var database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabasesdfg")
        customers1 = database.selectAllCustomers()

        // Do any additional setup after loading the view.
    }
    

}

extension CustomerCusTableViewController: UITableViewDataSource{
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return customers1.count
}
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerCell", for: indexPath)
    
    // Configure the cell...
    let customer = customers1[indexPath.row]
    if   let  customerCell = cell as? CustomerTableViewCell
    {
        customerCell.customerID.text = String(customer.ID)
        customerCell.customerName.text = customer.customerName
        
        
    }
    return cell
   
    
}
    
    override func   prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
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
            
        }
        
        }
}
