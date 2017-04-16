//
//  ViewController.swift
//  Shopping List – Mel-chan & Binh-kun
//
//  Created by Thanh-Binh TANG on 14/12/2016.
//  Copyright © 2016 Thanh-Binh TANG. All rights reserved.
//

import UIKit

class ShoppingList: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, SplashDelegate {

    // Variables
    
    @IBOutlet weak var tableViewElement: UITableView!
    var modelController = ModelController()
    
    var splashFlag = false
    
    @IBOutlet weak var blackCover: UIView!
    
    var categories = ["Rice", "Noodles", "Sweet", "Sea food", "Meat", "Soup", "Other"]
    
    @IBOutlet weak var titleViewAdd: UILabel!
    @IBOutlet var viewAdd: UIView!
    @IBOutlet weak var nameAdd: UITextField!
    @IBOutlet weak var amountAdd: UITextField!
    @IBOutlet weak var categoryAdd: UIPickerView!
    @IBOutlet weak var warningAdd: UILabel!
    @IBOutlet weak var listButton: UIBarButtonItem!
    
    var idCategory = 0
    var currentRow = 0
    
    
    // MARK: - Action buttons
    @IBAction func blackCoverAction(_ sender: AnyObject) {
        resetForm()
        viewAdd.isHidden = true
        blackCover.isHidden = true
    }
    
    @IBAction func listAction(_ sender: AnyObject) {
        
        if listButton.image == UIImage(named: "order"){
            listButton.image = UIImage(named: "done_order")
            self.tableViewElement.isEditing = true
        } else {
            listButton.image = UIImage(named: "order")
            self.tableViewElement.isEditing = false
        }
    }
    
    @IBAction func plusAction(_ sender: AnyObject) {
        resetForm()
        
        viewAdd.isHidden = false
        blackCover.isHidden = false
    }
    
    @IBAction func okAction(_ sender: AnyObject) {
        
        if !nameAdd.text!.isEmpty && !amountAdd.text!.isEmpty {
            if titleViewAdd.text == "Edit item" {
                modelController.items[currentRow].name = nameAdd.text!
                modelController.items[currentRow].amount = amountAdd.text!
                modelController.items[currentRow].category = categories[idCategory]
            
                modelController.items[currentRow].idCategory = idCategory
       
                
                let indexPath = IndexPath(row: currentRow, section: 0)
                tableViewElement.reloadRows(at: [indexPath], with: .automatic)
                
            } else {
                modelController.addItem(name: nameAdd.text!, amount: amountAdd.text!, category: categories[idCategory], idCategory: idCategory, isChecked: false)
                
                
                self.tableViewElement.reloadData()
            }
            
            view.endEditing(true)
            blackCover.isHidden = true
            viewAdd.isHidden = true
            warningAdd.isHidden = true
        } else {
            warningAdd.text = "Oops, there is empty field !"
            warningAdd.isHidden = false
        }
        
        saveData()
        
    }
    
    func resetForm() {
        titleViewAdd.text = "New item"
        nameAdd.text = ""
        amountAdd.text = ""
        idCategory = 0
        
        categoryAdd.selectRow(0, inComponent: 0, animated: true)
    }
    
    // MARK: - Default functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewAdd.layer.shadowColor = UIColor.black.cgColor
        viewAdd.layer.shadowOpacity = 1
        viewAdd.layer.shadowOffset = CGSize.zero
        viewAdd.layer.shadowRadius = 10
     
        viewAdd.layer.cornerRadius = view.frame.width/90
        viewAdd.clipsToBounds = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadData()
        tableViewElement.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if splashFlag == false {
            splashFlag = true
            let splashVC = storyboard?.instantiateViewController(withIdentifier: "splash") as! SplashViewController
            splashVC.delegate = self
            navigationController?.present(splashVC, animated: false, completion: nil)
            
        }
        
        warningAdd.isHidden = true
        blackCover.isHidden = true
        viewAdd.isHidden = true

    }
    

    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return modelController.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath) as! ItemTableViewCell
        
        let item = modelController.items[indexPath.row]
        
        cell.titleCell.text = item.name
        cell.amountCell.text = "Quantité : \(item.amount)"
        
        var imageName = String()
        
        switch item.idCategory {
        case 0:
            imageName = "rice"
        case 1:
            imageName = "noodles"
        case 2:
            imageName = "candy"
        case 3:
            imageName = "shrimp"
        case 4:
            imageName = "pomeranian"
        case 5:
            imageName = "soup"
        default:
            imageName = "pagoda"
        }
        
        cell.imageCell.image = UIImage(named: "\(imageName)")
        
        if item.isChecked == true {
            cell.checkmark.image = UIImage(named: "isChecked")
        } else {
            cell.checkmark.image = UIImage(named: "isNotChecked")
        }
        
        
        return cell
    }
    
    //     Override to support rearranging the table view.
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let item = modelController.items.remove(at: fromIndexPath.row)
        modelController.items.insert(item, at: to.row)
        
        saveData()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let checkAction = UITableViewRowAction(style: .normal, title: "          ") { (UITableViewRowAction, IndexPath) in
            self.modelController.items[indexPath.row].isChecked = !self.modelController.items[indexPath.row].isChecked
            tableView.reloadRows(at: [indexPath], with: .fade)
            self.saveData()
        }
        if self.modelController.items[indexPath.row].isChecked == true {
            if let image = UIImage(named: "uncheck_action"){
                checkAction.backgroundColor = UIColor(patternImage: image)
            }
        } else {
            if let image = UIImage(named: "check_action"){
                checkAction.backgroundColor = UIColor(patternImage: image)
            }
        }
        
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "          ") { (UITableViewRowAction, IndexPath) in
            self.modelController.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.saveData()
        }
        if let image = UIImage(named: "trash"){
            deleteAction.backgroundColor = UIColor(patternImage: image)
        }
        
        
        let editAction = UITableViewRowAction(style: .normal, title: "          ") { (UITableViewRowAction, IndexPath) in
            self.titleViewAdd.text = "Edit item"
            self.nameAdd.text = self.modelController.items[indexPath.row].name
            self.amountAdd.text = self.modelController.items[indexPath.row].amount
            self.categoryAdd.selectRow(self.modelController.items[indexPath.row].idCategory, inComponent: 0, animated: true)
            self.idCategory = self.modelController.items[indexPath.row].idCategory
            
            self.currentRow = indexPath.row
            
            self.blackCover.isHidden = false
            self.viewAdd.isHidden = false
            
        }
        if let image = UIImage(named: "edit_action"){
            editAction.backgroundColor = UIColor(patternImage: image)
        }
        
        return [checkAction, editAction, deleteAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        modelController.items[indexPath.row].isChecked = !modelController.items[indexPath.row].isChecked
        
        tableViewElement.reloadRows(at: [indexPath], with: .automatic)
        saveData()
    }
    
    
    // MARK: - Picker view data source
    
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        idCategory = row
    }
    
    
    //MARK: – TextField delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        navigationController!.popToRootViewController(animated: true)
        return false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    // MARK: - Splash delegate
    
    func splashDidFinish() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: – Persistence
    
    func saveData() {
        let docFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let path = docFolder.strings(byAppendingPaths: ["LocalStorage.plist"])[0]
        let array = NSMutableArray()
        for item in modelController.items {
            array.add(item.dictionary())
        }
        array.write(toFile: path, atomically: true)
    }
    
    func loadData() {
        let docFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let path = docFolder.strings(byAppendingPaths: ["LocalStorage.plist"])[0]
        if let array = NSArray.init(contentsOfFile: path) {
            modelController.items.removeAll()
            for item in array {
                let dict = item as! NSDictionary
                modelController.items.append(Item.itemWith(dictionary: dict))
            }
        }
    }
    
}
