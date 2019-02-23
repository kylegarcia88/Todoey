//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Kyle Garcia on 2/21/19.
//  Copyright © 2019 Kyle Garcia. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    //shared constants
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    //MARK: - tableview Datasource Methods
    
    //Display categories
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
   
    //MARK: - Data Manipulation Methods
    
    
    
    //Save Data
    func saveCategories() {
        
        do {
            try  context.save()
        }
        catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
    }
    
    //Load Data
    func loadCategories (with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error fetching categories \(error)")
        }
        tableView.reloadData()
        
    }
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            
            self.saveCategories()
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
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
}
