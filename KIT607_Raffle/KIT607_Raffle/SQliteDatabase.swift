//
//  SQliteDatabase.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 26/4/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import Foundation
import SQLite3

class SQLiteDatabase
{
    /* This variable is of type OpaquePointer, which is effectively the same as a C pointer (recall the SQLite API is a C-library). The variable is declared as an optional, since it is possible that a database connection is not made successfully, and will be nil until such time as we create the connection.*/
    private var db: OpaquePointer?
    
    /* Change this value whenever you make a change to table structure.
        When a version change is detected, the updateDatabase() function is called,
        which in turn calls the createTables() function.
     
        WARNING: DOING THIS WILL WIPE YOUR DATA, unless you modify how updateDatabase() works.
     */
    private let DATABASE_VERSION = 10
    
    
    
    // Constructor, Initializes a new connection to the database
    /* This code checks for the existence of a file within the application’s document directory with the name <dbName>.sqlite. If the file doesn’t exist, it attempts to create it for us. Since our application has the ability to write into this directory, this should happen the first time that we run the application without fail (it can still possibly fail if the device is out of storage space).
     The remainder of the function checks to see if we are able to open a successful connection to this database file using the sqlite3_open() function. With all of the SQLite functions we will be using, we can check for success by checking for a return value of SQLITE_OK.
     */
    init(databaseName dbName:String)
    {
        //get a file handle somewhere on this device
        //(if it doesn't exist, this should create the file for us)
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("\(dbName).sqlite")
        
        //try and open the file path as a database
        if sqlite3_open(fileURL.path, &db) == SQLITE_OK
        {
            print("Successfully opened connection to database at \(fileURL.path)")
            self.dbName = dbName
            checkForUpgrade();
        }
        else
        {
            print("Unable to open database at \(fileURL.path)")
            printCurrentSQLErrorMessage(db)
        }
        
    }
    
    deinit
    {
        /* We should clean up our memory usage whenever the object is deinitialized, */
        sqlite3_close(db)
    }
    private func printCurrentSQLErrorMessage(_ db: OpaquePointer?)
    {
        let errorMessage = String.init(cString: sqlite3_errmsg(db))
        print("Error:\(errorMessage)")
    }
    
    private func createTables()
    {
        //INSERT YOUR createTable function calls here
        //e.g. createMovieTable()
        createRaffleTable()
        createTicket()
        createCustomer()
    }
    private func dropTables()
    {
        //INSERT YOUR dropTable function calls here
        //e.g. dropTable(tableName:"Movie")
        dropTable(tableName:"Raffle")
    }
    
    /* --------------------------------*/
    /* ----- VERSIONING FUNCTIONS -----*/
    /* --------------------------------*/
    private var dbName:String = ""
    func checkForUpgrade()
    {
        // get the current version number
        let defaults = UserDefaults.standard
        let lastSavedVersion = defaults.integer(forKey: "DATABASE_VERSION_\(dbName)")
        
        // detect a version change
        if (DATABASE_VERSION > lastSavedVersion)
        {
            onUpdateDatabase(previousVersion:lastSavedVersion, newVersion: DATABASE_VERSION);
            
            // set the stored version number
            defaults.set(DATABASE_VERSION, forKey: "DATABASE_VERSION_\(dbName)")
        }
    }
    
    func onUpdateDatabase(previousVersion : Int, newVersion : Int)
    {
        print("Detected Database Version Change (was:\(previousVersion), now:\(newVersion))")
        
        //handle the change (simple version)
        dropTables()
        createTables()
    }
    
    
    
    /* --------------------------------*/
    /* ------- HELPER FUNCTIONS -------*/
    /* --------------------------------*/
    
    /* Pass this function a CREATE sql string, and a table name, and it will create a table
        You should call this function from createTables()
     */
    private func createTableWithQuery(_ createTableQuery:String, tableName:String)
    {
        /*
         1.    sqlite3_prepare_v2()
         2.    sqlite3_step()
         3.    sqlite3_finalize()
         */
        //prepare the statement
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK
        {
            //execute the statement
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("\(tableName) table created.")
            }
            else
            {
                print("\(tableName) table could not be created.")
                printCurrentSQLErrorMessage(db)
            }
        }
        else
        {
            print("CREATE TABLE statement for \(tableName) could not be prepared.")
            printCurrentSQLErrorMessage(db)
        }
        
        //clean up
        sqlite3_finalize(createTableStatement)
        
    }
    /* Pass this function a table name.
        You should call this function from dropTables()
     */
    private func dropTable(tableName:String)
    {
        /*
         1.    sqlite3_prepare_v2()
         2.    sqlite3_step()
         3.    sqlite3_finalize()
         */
        
        //prepare the statement
        let query = "DROP TABLE IF EXISTS \(tableName)"
        var statement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, query, -1, &statement, nil)     == SQLITE_OK
        {
            //run the query
            if sqlite3_step(statement) == SQLITE_DONE {
                print("\(tableName) table deleted.")
            }
        }
        else
        {
            print("\(tableName) table could not be deleted.")
            printCurrentSQLErrorMessage(db)
        }
        
        //clear up
        sqlite3_finalize(statement)
    }
    
    //helper function for handling INSERT statements
    //provide it with a binding function for replacing the ?'s for setting values
    private func insertWithQuery(_ insertStatementQuery : String, bindingFunction:(_ insertStatement: OpaquePointer?)->())
    {
        /*
         Similar to the CREATE statement, the INSERT statement needs the following SQLite functions to be called (note the addition of the binding function calls):
         1.    sqlite3_prepare_v2()
         2.    sqlite3_bind_***()
         3.    sqlite3_step()
         4.    sqlite3_finalize()
         */
        // First, we prepare the statement, and check that this was successful. The result will be a C-
        // pointer to the statement:
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementQuery, -1, &insertStatement, nil) == SQLITE_OK
        {
            //handle bindings
            bindingFunction(insertStatement)
            
            /* Using the pointer to the statement, we can call the sqlite3_step() function. Again, we only
             step once. We check that this was successful */
            //execute the statement
            if sqlite3_step(insertStatement) == SQLITE_DONE
            {
                print("Successfully inserted row.")
            }
            else
            {
                print("Could not insert row.")
                printCurrentSQLErrorMessage(db)
            }
        }
        else
        {
            print("INSERT statement could not be prepared.")
            printCurrentSQLErrorMessage(db)
        }
    
        //clean up
        sqlite3_finalize(insertStatement)
    }
    
    //update function
    
   
  
    //helper function to run Select statements
    //provide it with a function to do *something* with each returned row
    //(optionally) Provide it with a binding function for replacing the "?"'s in the WHERE clause
    private func selectWithQuery(
        _ selectStatementQuery : String,
        eachRow: (_ rowHandle: OpaquePointer?)->(),
        bindingFunction: ((_ rowHandle: OpaquePointer?)->())? = nil)
    {
        //prepare the statement
        var selectStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, selectStatementQuery, -1, &selectStatement, nil) == SQLITE_OK
        {
            //do bindings, only if we have a bindingFunction set
            //hint, to do selectMovieBy(id:) you will need to set a bindingFunction (if you don't hardcode the id)
            bindingFunction?(selectStatement)
            
            //iterate over the result
            while sqlite3_step(selectStatement) == SQLITE_ROW
            {
                eachRow(selectStatement);
            }
            
        }
        else
        {
            print("SELECT statement could not be prepared.")
            printCurrentSQLErrorMessage(db)
        }
        //clean up
        sqlite3_finalize(selectStatement)
    }
    //delete
       private func deleteWithQuery(
             _ deleteStatementQuery : String,
             bindingFunction: ((_ rowHandle: OpaquePointer?)->()))
         {
             //prepare the statement
             var deleteStatement: OpaquePointer? = nil
             if sqlite3_prepare_v2(db, deleteStatementQuery, -1, &deleteStatement, nil) == SQLITE_OK
             {
                 //do bindings
                 bindingFunction(deleteStatement)
                 
                 //execute
                 if sqlite3_step(deleteStatement) == SQLITE_DONE
                 {
                     print("Successfully deleted row.")
                 }
                 else
                 {
                     print("Could not delete row.")
                     printCurrentSQLErrorMessage(db)
                 }
             }
             else
             {
                 print("DELETE statement could not be prepared.")
                 printCurrentSQLErrorMessage(db)
             }
             //clean up
             sqlite3_finalize(deleteStatement)
         }

    
    //helper function to run update statements.
    //Provide it with a binding function for replacing the "?"'s in the WHERE clause
    private func updateWithQuery(
        _ updateStatementQuery : String,
        bindingFunction: ((_ rowHandle: OpaquePointer?)->()))
    {
        //prepare the statement
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementQuery, -1, &updateStatement, nil) == SQLITE_OK
        {
            //do bindings
            bindingFunction(updateStatement)
            
            //execute
            if sqlite3_step(updateStatement) == SQLITE_DONE
            {
                print("Successfully updateded row.")
            }
            else
            {
                print("Could not update row.")
                printCurrentSQLErrorMessage(db)
            }
        }
        else
        {
            print("UPDATE statement could not be prepared.")
            printCurrentSQLErrorMessage(db)
        }
        //clean up
        sqlite3_finalize(updateStatement)
    }
    
    /* --------------------------------*/
    /* --- ADD YOUR TABLES ETC HERE ---*/
    /* --------------------------------*/
    func createRaffleTable() {
        let createRafflesTableQuery = """
            CREATE TABLE Raffle(
                ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                Name CHAR(255),
                Description CHAR(255),
                
                Raffletype INTEGER,
                Maxnumber INTEGER,
                Ticketprice INTEGER,
                Launchstatus INTEGER,
                Drawstatus INTEGER,
                Drawtime CHAR(255)
                

 );
 """
       createTableWithQuery(createRafflesTableQuery,tableName: "Raffle")
    }
    
    //create customer
       func createCustomer() {
           let createCustomersTableQuery = """
               CREATE TABLE Customer(
                   ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                   CustomerName CHAR(255)
            
    );
    """
          createTableWithQuery(createCustomersTableQuery,tableName: "Customer")
       }
    
    //create ticket
    func createTicket() {
           let createTicketsTableQuery = """
               CREATE TABLE Ticket(
                   ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                   RaffleID INTEGER,
                   RaffleName CHAR(255),
                   Ticketprice INTEGER,
                   CustomerID INTEGER,
                   CustomerName CHAR(255),
                   PurchaseDate CHAR(255),
                   Winstatus INTEGER,
                   TicketNumber INTEGER
                   

    );
    """
          createTableWithQuery(createTicketsTableQuery,tableName: "Ticket")
       }
    
    
    func insert(raffle:Raffle){
        let insertStatementQuery =
        "INSERT INTO Raffle (Name, Description, Raffletype, Maxnumber, Ticketprice, Launchstatus, Drawstatus, Drawtime) VALUES (?, ?, ?, ?, ?, ?, ?, ?);"
        insertWithQuery(insertStatementQuery, bindingFunction: { (insertSatement) in
            sqlite3_bind_text(insertSatement, 1, NSString(string: raffle.name).utf8String, -1, nil)
            sqlite3_bind_text(insertSatement, 2, NSString(string: raffle.description).utf8String, -1, nil)
           sqlite3_bind_int(insertSatement, 3, raffle.maxNumber)
            sqlite3_bind_int(insertSatement, 4, raffle.type)
            sqlite3_bind_int(insertSatement, 5, raffle.ticketPrice)
            sqlite3_bind_int(insertSatement, 6, raffle.launchStatus)
            sqlite3_bind_int(insertSatement, 7, raffle.drawStatus)
            
            sqlite3_bind_text(insertSatement, 8, NSString(string: raffle.drawTime).utf8String, -1, nil)
            
        })
    }

    
    func insert(customer:Customer){
           let insertStatementQuery =
           "INSERT INTO Customer (CustomerName) VALUES (?);"
           insertWithQuery(insertStatementQuery, bindingFunction: { (insertSatement) in
            sqlite3_bind_text(insertSatement, 1, NSString(string: customer.customerName).utf8String, -1, nil)
               
           })
       }


    
    func insert(ticket:Ticket){
        let insertStatementQuery =
        "INSERT INTO Ticket (RaffleID, RaffleName, Ticketprice, CustomerID, CustomerName, PurchaseDate, Winstatus, TicketNumber) VALUES (?, ?, ?, ?, ?, ?, ?, ?);"
        insertWithQuery(insertStatementQuery, bindingFunction: { (insertSatement) in
            sqlite3_bind_int(insertSatement, 1, ticket.raffleID)
            sqlite3_bind_text(insertSatement, 2, NSString(string: ticket.raffleName).utf8String, -1, nil)
            sqlite3_bind_int(insertSatement, 3, ticket.ticketPrice)
            sqlite3_bind_int(insertSatement, 4, ticket.customerID)
             sqlite3_bind_text(insertSatement, 5, NSString(string: ticket.customerName).utf8String, -1, nil)
            sqlite3_bind_text(insertSatement, 6, NSString(string: ticket.purchaseDate).utf8String, -1, nil)
            sqlite3_bind_int(insertSatement, 7, ticket.winStatus)
            sqlite3_bind_int(insertSatement, 8, ticket.ticketNumber)
            
            
        })
    }
    
    
    
   func updateRaffle(raffle:Raffle,id:Int32){
        
        let updateStatementQuery = "UPDATE Raffle SET Name=?, Description=?, Raffletype=?, Maxnumber=?, Ticketprice=?, Launchstatus=?, Drawstatus=?, Drawtime=? WHERE ID=?"
        updateWithQuery(
        updateStatementQuery, bindingFunction: { (updateSatement) in
            
            
          sqlite3_bind_text(updateSatement, 1, NSString(string: raffle.name).utf8String, -1, nil)
            sqlite3_bind_text(updateSatement, 2, NSString(string: raffle.description).utf8String, -1, nil)
           sqlite3_bind_int(updateSatement, 3, raffle.maxNumber)
            sqlite3_bind_int(updateSatement, 4, raffle.type)
            sqlite3_bind_int(updateSatement, 5, raffle.ticketPrice)
            sqlite3_bind_int(updateSatement, 6, raffle.launchStatus)
            sqlite3_bind_int(updateSatement, 7, raffle.drawStatus)
            
            sqlite3_bind_text(updateSatement, 8, NSString(string: raffle.drawTime).utf8String, -1, nil)
             sqlite3_bind_int(updateSatement, 9, id)
         })
     
    }
    
    func updateCustomer(customerName:String,id:Int32){
         
         let updateStatementQuery = "UPDATE Customer SET CustomerName=? WHERE ID=?"
         updateWithQuery(
         updateStatementQuery, bindingFunction: { (updateSatement) in
             
             
           sqlite3_bind_text(updateSatement, 1, NSString(string: customerName).utf8String, -1, nil)
           
              sqlite3_bind_int(updateSatement, 2, id)
          })
      
     }
    

    func updateTicket(customerName:String,id:Int32){
           
           let updateStatementQuery = "UPDATE Ticket SET CustomerName=? WHERE ID=?"
           updateWithQuery(
           updateStatementQuery, bindingFunction: { (updateSatement) in
               
               
            sqlite3_bind_text(updateSatement, 1, NSString(string: customerName).utf8String, -1, nil)
           
                sqlite3_bind_int(updateSatement, 2, id)
            })
        
         
       }
    
    
    


    func selectAllRaffles() -> [Raffle]{
        var result = [Raffle]()
        let selectStatementQuery = "SELECT ID, Name, Description, Raffletype, Maxnumber, Ticketprice, Launchstatus, Drawstatus, Drawtime FROM Raffle"
        selectWithQuery(selectStatementQuery, eachRow: { (row) in
            //create a movie object from each result
            let raffle = Raffle(
                ID: sqlite3_column_int(row, 0),
                name: String(cString:sqlite3_column_text(row, 1)),
                description: String(cString:sqlite3_column_text(row, 2)),
                type: sqlite3_column_int(row, 3),
                maxNumber: sqlite3_column_int(row, 4),
                ticketPrice: sqlite3_column_int(row, 5),
                launchStatus: sqlite3_column_int(row, 6),
                drawStatus: sqlite3_column_int(row, 7),
                drawTime: String(cString:sqlite3_column_text(row, 8))
                 
            )
            //add it to the result array
            result += [raffle] })
        return result
    }
    
    
    
    func selectAllCustomers() -> [Customer]{
           var result = [Customer]()
           let selectStatementQuery = "SELECT ID, CustomerName FROM Customer"
           selectWithQuery(selectStatementQuery, eachRow: { (row) in
               //create a movie object from each result
               let customer = Customer(
                   ID: sqlite3_column_int(row, 0),
                   customerName: String(cString:sqlite3_column_text(row, 1))
                   
               )
               //add it to the result array
               result += [customer] })
           return result
       }
    

    
   
    func selectRaffleBy(id:Int32) -> Raffle?{
        var result : Raffle?
        let selectStatementQuery = "SELECT ID, Name, Description, Raffletype, Maxnumber, Ticketprice, Launchstatus, Drawstatus, Drawtime FROM Raffle WHERE ID=?"
        selectWithQuery(
        selectStatementQuery,
        eachRow: { (id) in
        //create a movie object from each result
        let raffle = Raffle(
            ID: sqlite3_column_int(id, 0),
            name: String(cString:sqlite3_column_text(id, 1)),
            description: String(cString:sqlite3_column_text(id, 2)),
            type: sqlite3_column_int(id, 3),
            maxNumber: sqlite3_column_int(id, 4),
            ticketPrice: sqlite3_column_int(id, 5),
            launchStatus: sqlite3_column_int(id, 6),
            drawStatus: sqlite3_column_int(id, 7),
            drawTime: String(cString:sqlite3_column_text(id, 8))
            
        )
            result = raffle
         },
        bindingFunction: {(selectSatement) in
       
            sqlite3_bind_int(selectSatement, 1, id)
           })
        
        return result
    }
    
    
    
    func selectCustomerBy(id:Int32) -> Customer?{
        var result : Customer?
        let selectStatementQuery = "SELECT ID, CustomerName FROM Customer WHERE ID=?"
        selectWithQuery(
        selectStatementQuery,
        eachRow: { (id) in
        //create a movie object from each result
        let customer = Customer(
            ID: sqlite3_column_int(id, 0),
            customerName: String(cString:sqlite3_column_text(id, 1))
            
        )
            result = customer
         },
        bindingFunction: {(selectSatement) in
       
            sqlite3_bind_int(selectSatement, 1, id)
           })
        
        return result
    }
    
    func selectCustomerByName(customerName:String) -> [Customer]{
        var result = [Customer]()
        let selectStatementQuery = "SELECT ID, CustomerName FROM Customer WHERE CustomerName LIKE ?"
        selectWithQuery(
        selectStatementQuery,
        eachRow: { (id) in
        //create a movie object from each result
        let customer = Customer(
            ID: sqlite3_column_int(id, 0),
            customerName: String(cString:sqlite3_column_text(id, 1))
            
        )
             result += [customer]
         },
        bindingFunction: {(selectSatement) in
       
            sqlite3_bind_text(selectSatement, 1, NSString(string: customerName).utf8String, -1, nil)
              
           })
        
        return result
    }
        
    
     func selectTicketBy(id:Int32) -> [Ticket]{
           var result = [Ticket]()
           let selectStatementQuery = "SELECT ID, RaffleID, RaffleName, Ticketprice, CustomerID, CustomerName, PurchaseDate, Winstatus, TicketNumber FROM Ticket WHERE RaffleID=?"
           selectWithQuery(
           selectStatementQuery,
           eachRow: { (id) in
           //create a movie object from each result
           let ticket = Ticket(
               ID: sqlite3_column_int(id, 0),
               raffleID: sqlite3_column_int(id, 1),
               raffleName: String(cString:sqlite3_column_text(id, 2)),
         
               ticketPrice: sqlite3_column_int(id, 3),
               customerID: sqlite3_column_int(id, 4),
               customerName: String(cString:sqlite3_column_text(id, 5)),
               purchaseDate: String(cString:sqlite3_column_text(id, 6)),
               winStatus: sqlite3_column_int(id, 7),
               ticketNumber: sqlite3_column_int(id, 8)
              
               
           )
               result += [ticket]
            },
           bindingFunction: {(selectSatement) in
          
               sqlite3_bind_int(selectSatement, 1, id)
              })
           
           return result
       }
  ///find max ticket

    func selectMaxTicketBy(id:Int32) -> Int32?{
        var result : Int32?
       
        let selectStatementQuery = "SELECT MAX(TicketNumber) FROM Ticket WHERE RaffleID=?"
        selectWithQuery(
        selectStatementQuery,
        eachRow: { (id) in
        //create a movie object from each result
        let maxTicketNumber = sqlite3_column_int(id, 0)
           
            
        
            result = maxTicketNumber
         },
        bindingFunction: {(selectSatement) in
       
            sqlite3_bind_int(selectSatement, 1, id)
           })
        
        return result
    }
    
    
    
    func deleteRaffleBy(id:Int32){
        
        let deleteStatementQuery = "DELETE FROM Raffle WHERE ID=?"
        deleteWithQuery(deleteStatementQuery, bindingFunction: {(deleteSatement) in
       
            sqlite3_bind_int(deleteSatement, 1, id)
           })
        
        
    }
    
    func deleteTicketBy(id:Int32){
          
          let deleteStatementQuery = "DELETE FROM Ticket WHERE ID=?"
          deleteWithQuery(deleteStatementQuery, bindingFunction: {(deleteSatement) in
         
              sqlite3_bind_int(deleteSatement, 1, id)
             })
          
          
      }
    
    func deleteCustomerBy(id:Int32){
           
           let deleteStatementQuery = "DELETE FROM Customer WHERE ID=?"
           deleteWithQuery(deleteStatementQuery, bindingFunction: {(deleteSatement) in
          
               sqlite3_bind_int(deleteSatement, 1, id)
              })
           
           
       }
    
    
    
    
    
    
    
    
}
