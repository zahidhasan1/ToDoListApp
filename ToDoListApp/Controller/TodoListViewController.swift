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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Loading item from userDefaults
        loadItems()
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
    //This is the method for selecting tableView data
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row].title)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
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
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.saveItems()
        }
        
      
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //This function will save data to Items.plist file
    func saveItems()  {
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding item array\(error)")
        }
        
        self.tableView.reloadData()
    }
    
    //This function will load data from Items.plist file
    func loadItems(){
       if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            } catch{
                print("Error decoding item array, \(error)")
            }
        }
    }
    
}























