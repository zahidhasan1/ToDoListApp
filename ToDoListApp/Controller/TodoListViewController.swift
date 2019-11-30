//
//  ViewController.swift
//  ToDoListApp
//
//  Created by ZEUS on 29/11/19.
//  Copyright © 2019 ZEUS. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Kill the dragons"
        itemArray.append(newItem2)

        let newItem3 = Item()
        newItem3.title = "Dont forget to fring the sword"
        itemArray.append(newItem3)
        

        
        
        // Do any additional setup after loading the view.
       if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
        itemArray = items
       }
    }
    
    // MARK: - TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = item.title
        
        //Setting checkmarks for itemArray
        cell.accessoryType = item.done  ? .checkmark : .none
        
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        } else{
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    // MARK: - TableView Delegete Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row].title)
        
        //Setting up a CheckMark for every selected Items
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - Add New Items at button pressed

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new TO-DO Item", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
                  alertTextField.placeholder = "Create New Item"
                  textField = alertTextField
              }
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            //Data will be saved in UserDefaults database
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
      
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    } 
}























