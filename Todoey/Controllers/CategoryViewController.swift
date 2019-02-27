//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Kyle Garcia on 2/21/19.
//  Copyright © 2019 Kyle Garcia. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoryViewController: SwipeTableViewController {
    
    //shared constants
    //let realm = try! Realm()
    var realm: Realm!
    var categories : Results<Category>?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm()
        
        tableView.separatorStyle = .none
                
        loadCategories()
        
        
    }
    
    //MARK: - tableview Datasource Methods
    
    //Display categories
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        
        if let catagory = categories?[indexPath.row] {
            
            cell.textLabel?.text = catagory.name
            
            guard let categoryColor = UIColor(hexString: catagory.cellColor) else{fatalError()}
            
            cell.backgroundColor = categoryColor
            
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
            
        }
        
       
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
   
    //MARK: - Data Manipulation Methods
    
    
    
    //Save Data
    func save(category: Category) {
        
        do {
            try  realm.write {
                 realm.add(category)
                 }
        }
        catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
    }
    
    //Load Data
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        

        tableView.reloadData()

   }
    
    //Delete Data from Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }

            } catch {
                print("error deleting category; \(error)")
            }

        }
    }
    
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.cellColor = UIColor.randomFlat.hexValue()
            
            print(newCategory.cellColor)
        
            
            
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add A New Category"
            
        }
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
}


