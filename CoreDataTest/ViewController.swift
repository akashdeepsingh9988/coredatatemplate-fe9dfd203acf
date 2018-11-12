//
//  ViewController.swift
//  CoreDataTest
//
//  Created by MacStudent on 2018-11-06.
//  Copyright 2018 MacStudent. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var searchTx = "";

    // MARK: Outlets
    // ------------------------------
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var searchTxt: UITextField!
    // MARK: CoreDta variables
    @IBAction func searchButton(_ sender: Any) {
        searchTx = searchTxt.text!
        print("search tx" , searchTx)
        
        
    }
    // ------------------------------
    
    
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup your CoreData variable
        // ----------------------------------------
        
        // 1. Mandatory - copy and paste this
        // Explanation: try to create/initalize the appDelegate variable.
        // If creation fails, then quit the app
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // 2. Mandatory - initialize the context variable
        // This variable gives you access to the CoreData functions
        self.context = appDelegate.persistentContainer.viewContext

    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: Actions
    // ----------------------------
    
    // This function adds a user to the database
    // -----------------------------------------------
    @IBAction func signupButtonPressed(_ sender: Any) {
        print("Signup button pressed!")
        
        // Create the "row" you want to insert into the database
        // When using CoreData, you don't do a SQL statment
        // You create an OBJECT, and then insert the OBJECT
        
        // Below code is equivalent of:
        //      INSERT INTO User(email, password) VALUES ("michael@gmail.com", "1234")
        let u = User(context: self.context)
        u.email = usernameField.text
        u.password = passwordField.text
        
        do {
            // Save the user to the database
            // (Send the INSERT to the database)
            try self.context.save()
        }
        catch {
            print("Error while saving to database")
        }
        
    }
    
    // This function gets all users from the database
    // -----------------------------------------------
    @IBAction func showAllUsersPressed(_ sender: Any) {
        print("Show all users pressed!")
        
        //hgggh
        
        // This is the same as:  SELECT * FROM User
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        // like where
    fetchRequest.predicate = NSPredicate(format: "email == %@", "michael@gmail.com")
        
        do {
            // Send the "SELECT *" to the database
            //  results = variable that stores any "rows" that come back from the db
            // Note: The database will send back an array of User objects
            // (this is why I explicilty cast results as [User]
            let results = try self.context.fetch(fetchRequest) as [User]
            
            // Loop through the database results and output each "row" to the screen
            print("Number of items in database: \(results.count)")
            
            for x in results {
                print("User Email: \(x.email)")
                print("User Password: \(x.password)")
            }
        }
        catch {
            print("Error when fetching from database")
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("hello")
        //var e = ""
        print(searchTx)
        let secondS = segue.destination as! SecondVCViewController
        secondS.e = self.searchTxt.text!
        print(secondS.e)
        
    }
    
}

