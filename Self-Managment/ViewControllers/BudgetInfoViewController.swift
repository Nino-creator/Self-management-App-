//
//  BudgetInfoViewController.swift
//  Self-Managment
//
//  Created by Nini mekhashishvili on 9/13/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//

import UIKit

class BudgetInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var spendLabel: UILabel!
    //change the names
    @IBOutlet weak var leftMoneyLabel: UILabel!
    @IBOutlet weak var statisticButton: UIButton!
    var user = Person()
    var categories = [Dictionary<String,String>]()
    var totalSpend = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        changeEdge()
        showLabels()
        notifications()
        
        statisticButton.isHidden = true
        
    }
    @IBAction func onGraph(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.goGraph, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == Segue.goGraph{
            if let graphVC = segue.destination as? GraphViewController {
                graphVC.user = self.user
                graphVC.categories = self.categories
                
            }
        }
    }
}

extension BudgetInfoViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category_spend_cell_id", for: indexPath) as! CategorySpendCell
        
        let category = self.categories[indexPath.row]
        let spend = Float(category["money"] ?? "0")
        let x = spend! / Float(user.salary)
        let y = Float(round(1000*x))/10
        
        cell.categoryNameLabel.text = category["title"]
        cell.categoryPercentageLabel.text = "\(y)%"
        return cell
    }
    
}

extension BudgetInfoViewController {
    func notifications(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(deleteCategory),
            name: .deleteCategoryChannelID,
            object: nil)
            
            NotificationCenter.default.addObserver(
            self,
            selector: #selector(saveCategory),
            name: .addCategoryChannelID,
            object: nil)
            
            NotificationCenter.default.addObserver(
            self,
            selector: #selector(addMoney),
            name: .addSpendChannelID,
            object: nil)
            
            NotificationCenter.default.addObserver(
            self,
            selector: #selector(changeSalary),
            name: .ChangeInfoChannelID,
            object: nil)
    }
    
    
}


extension BudgetInfoViewController {
    
    func showLabels(){
        totalSpend = calculateSpend()
        self.moneyLabel.text = " Salary: \(user.salary)"
        self.spendLabel.text = " Spend: \(totalSpend) "
        self.leftMoneyLabel.text = " Left: \(Int(user.salary) - totalSpend)"
        
    }
    func changeEdge(){
        
        statisticButton.layer.cornerRadius = 15
        
        self.moneyLabel.layer.cornerRadius = 15
        self.moneyLabel.layer.masksToBounds = true
        
        self.leftMoneyLabel.layer.cornerRadius = 15
        self.leftMoneyLabel.layer.masksToBounds = true
        
        self.spendLabel.layer.cornerRadius = 15
        self.spendLabel.layer.masksToBounds = true
    }
    
    func calculateSpend() -> Int{
        var spend = 0
        for category in categories {
            spend += Int(category["money"] ?? "0")!
        }
        return spend
    }
    
    @objc func deleteCategory(wiht notification: Notification){
        if let info = notification.userInfo{
            
            let index = info["index"] as! Int
            categories.remove(at: index)
            showLabels()
            self.tableView.reloadData()
        }
        
    }
    
    @objc func saveCategory(with notification: Notification){
        if let info = notification.userInfo{
            
            let title = info["name"] as? String
            var newCategory =  Dictionary<String,String>()
            
            newCategory["title"] = title
            newCategory["image"] = "food"
            newCategory["money"] = "0"
            
            categories.append(newCategory)
            showLabels()
            self.tableView.reloadData()
        }
    }
    
    @objc func addMoney(with notification: Notification){
        if let info = notification.userInfo{
            
            let index = info["index"] as! Int
            let money = info["money"] as! Int
            
            let category = categories[index]
            let spend = String(Int(category["money"] ?? "0")! + money)
            print(spend)
            categories[index]["money"] = String(spend)
            showLabels()
            self.tableView.reloadData()
        }
    }
    
    @objc func changeSalary(with notification: Notification){
        if let info = notification.userInfo{
            let salary = info["salary"]
            self.user.salary = salary as! Int16
            showLabels()
            self.tableView.reloadData()
        }
    }
}



  


