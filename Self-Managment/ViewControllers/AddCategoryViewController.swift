//
//  AddCategoryViewController.swift
//  Self-Managment
//
//  Created by Nini mekhashishvili on 9/13/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {

    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var savingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryButton.layer.cornerRadius = 20
        self.savingButton.layer.cornerRadius = 20
        
        savingButton.isHidden = true

    }
    
    @IBAction func Oncategory(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.goAddCategory, sender: self)
    }
    
    @IBAction func OnSaving(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.goAddSaving, sender: self)
    }
    
}
