//
//  AddDeleteCellViewController.swift
//  Self-Managment
//
//  Created by Nini mekhashishvili on 9/13/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//

import UIKit

class AddDeleteCellViewController: UIViewController {

    @IBOutlet weak var addMoneyButton: UIButton!
    @IBOutlet weak var deleteButon: UIButton!
    var selectedIndex = 0
    var user = Person()
    var categories = [Dictionary<String,String>]()
    var totalSpend = 0
    var salary = 0
    
    let moneyField: UITextField = {
        let mf = UITextField()
        mf.translatesAutoresizingMaskIntoConstraints = false
        mf.backgroundColor = .systemGray5
        mf.placeholder = "spend"
        
        return mf
    }()
    
    let leftLabel: UILabel = {
        let sl = UILabel()
        sl.translatesAutoresizingMaskIntoConstraints = false
        return sl
    }()
    
    let warningLabel: UILabel = {
        let wl = UILabel()
        wl.translatesAutoresizingMaskIntoConstraints = false
        wl.textAlignment = .center
        return wl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deleteButon.layer.cornerRadius = 20
        addMoneyButton.layer.cornerRadius = 20
    }
    
    @IBAction func onDelete(_ sender: UIButton) {
        CoreDataFunc.deleteCategory(person: user, index: selectedIndex)
        
        NotificationCenter.default.post(
            name: .deleteCategoryChannelID,
            object: nil,
            userInfo: ["index":selectedIndex])
        
        self.dismiss(animated: true)
        
    }
    
    @IBAction func onSave(_ sender: UIButton) {
        
        self.totalSpend = calculateSpend()
        self.salary = Int(user.salary)

        print(totalSpend)
        
        if addMoneyButton.titleLabel?.text == "Add Money"{
            deleteButon.isHidden = true
            addTextField()
            addMoneyButton.setTitle("Save", for: .normal)
            leftLabel.text = "Left: \(Int(self.user.salary) - self.totalSpend)$"
        }else{
            //add money
            if let money = Int(moneyField.text ?? ""){
                
                if checkBudget(money: money) {
                    CoreDataFunc.addCategory(person: user, money: money, index: selectedIndex)
                    
                    NotificationCenter.default.post(
                        name: .addSpendChannelID,
                        object: nil,
                        userInfo: ["index":selectedIndex,
                                   "money": money ])
                    
                    self.dismiss(animated: true)
                }
            }else{
                warningLabel.textColor = .red
                warningLabel.text = "it is not a number"
            }
            
            
        }
        
    }
    
    func addTextField(){
        
        self.view.addSubview(moneyField)
        
        NSLayoutConstraint.activate([
            moneyField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 300),
            moneyField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            moneyField.widthAnchor.constraint(equalToConstant: 300),
            moneyField.heightAnchor.constraint(equalToConstant: 50)
        
        ])
        
        self.view.addSubview(warningLabel)
            
            NSLayoutConstraint.activate([
                warningLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 200),
                warningLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
                warningLabel.widthAnchor.constraint(equalToConstant: 300),
                warningLabel.heightAnchor.constraint(equalToConstant: 50)
            
            ])
        
        self.view.addSubview(leftLabel)
        
        NSLayoutConstraint.activate([
            leftLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
            leftLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            leftLabel.widthAnchor.constraint(equalToConstant: 300),
            leftLabel.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }

    func calculateSpend() -> Int{
        var spend = 0
        for category in categories {
            spend += Int(category["money"] ?? "0")!
        }
        return spend
    }
    
    func checkBudget(money: Int) -> Bool{
        print(totalSpend)
        var canAdd = true
        let willBeLelf = self.salary - (money + self.totalSpend)
        if willBeLelf < 0 {
            warningLabel.textColor = .red
            warningLabel.text = "you do not have enough money"
            
            canAdd = false
        }else{
            warningLabel.textColor = .green
            warningLabel.text = "Saved successfully"
        }
        
        return canAdd
    }
    
    deinit{
        print("remove")
        NotificationCenter.default.removeObserver(self)
    }
}
