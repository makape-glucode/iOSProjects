//
//  ViewController.swift
//  toDoList
//
//  Created by Makape Tema on 2023/02/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let checkbox = CheckboxView(frame: CGRect(x: 70, y: 200, width: 40, height: 40))
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(UINib(nibName: String(describing: ToDoCell.self), bundle: .main), forCellReuseIdentifier: String(describing: ToDoCell.self))
        
        table.register(UINib(nibName: String(describing: CheckboxView.self), bundle: .main), forCellReuseIdentifier: String(describing: CheckboxView.self))
        
        return table
    }()
    
   

    
    //Date Picker
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.locale = .current
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = .systemBlue
        
        return datePicker
    }()
    
    private var models = [ToDoListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any addditional setup after loading the view.
        
        title = "To Do List"
        view.addSubview(tableView)
        getAllItems()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
       
    }
    
   
    
    func showAlert(item: ToDoListItem) {
        
        let alert = UIAlertController(title: " ", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: {
            action in
            self.setDueDate(item: item, dueDate: self.datePicker.date)
            //            print("Date and time is set")
        }))
        alert.view.addSubview(datePicker)
        
        present(alert, animated: true)
    }
    
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "New Item", message: "Enter new item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Select due date", style: .cancel, handler: { _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            
            let newItem = self.createItem(name: text)
            
            self.showAlert(item: newItem)
            
        }))
        
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ToDoCell.self), for: indexPath) as? ToDoCell
        
        
        var dateString = "No date"
        if let dueDate = model.dueDate {
            dateString = DateFormatter.dayMonthYearTimeFormatter.string(from: dueDate)
        }
        cell?.theLabel?.text = model.name!
        cell?.dueDateLabel.text = dateString
        
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
        let sheet = UIAlertController(title: "Make Changes", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
      
        
        sheet.addAction(UIAlertAction(title: "Edit", style: .default , handler: { _ in
            
            let alert = UIAlertController(title: "Edit Item", message: "Edit your item", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.name
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                    return
                }
                
                self?.updateItem(item: item, newName: newName)
                
            }))
            
            self.present(alert, animated: true)
            
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        
        present(sheet, animated: true)
    }
    
    // Core Data
    
    func getAllItems() {
        do {
            models = try context.fetch(ToDoListItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            // error
        }
    }
    
    func createItem(name: String) -> ToDoListItem {
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
        return newItem
    }
    
    func deleteItem(item: ToDoListItem) {
        context.delete(item)
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
    func updateItem(item: ToDoListItem, newName: String ) {
        item.name = newName
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
    func setDueDate(item: ToDoListItem, dueDate: Date) {
        item.dueDate = dueDate
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
    func setChecked(item: ToDoListItem, name: String, check: Bool) {
        item.name = name
        item.check = check
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
    
}

extension DateFormatter {
    static let dayMonthYearTimeFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM YYYY, HH:mm"
        
        return dateFormatter
    }()
}
