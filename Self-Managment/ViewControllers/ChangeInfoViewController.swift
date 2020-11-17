//
//  ChangeInfoViewController.swift
//  Self-Managment
//
///  Created by Nini mekhashishvili on 9/13/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//

import UIKit

class ChangeInfoViewController: UIViewController {

    @IBOutlet weak var oldTitleLabel: UILabel!
    @IBOutlet weak var oldInfoLabel: UILabel!
    @IBOutlet weak var newTitleLabel: UILabel!
    @IBOutlet weak var newInfoField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var selectedTitle: String!
    var oldInfo: String?
    var user = Person()
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.layer.cornerRadius = 15
        
        oldTitleLabel.text = "Old:  \(String(describing: selectedTitle!)): "
        newTitleLabel.text = "New:   \(String(describing: selectedTitle!)): "
        oldInfoLabel.text = oldInfo
    }
    
    @IBAction func saveInfo(_ sender: UIButton) {
        guard let newInfo = newInfoField.text else {return }
        CoreDataFunc.updateInfo(person: user, info: newInfo, index: selectedIndex)
        
        UDManager.saveUsername(name: user.username!)
        UDManager.savePassword(pas: user.password!)
        
        if selectedTitle == "salary" {
            NotificationCenter.default.post(
            name: .ChangeInfoChannelID,
            object: nil,
            userInfo: ["salary": Int16(newInfo) ?? 0])
        }
        
        self.dismiss(animated: true)
        
    }
    
    deinit{
        print("remove")
        NotificationCenter.default.removeObserver(self)
    }
}
