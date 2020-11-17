//
//  NewSavingViewController.swift
//  Self-Managment
//
//  Created by Nini mekhashishvili on 9/13/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//

import UIKit

class NewSavingViewController: UIViewController {

    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var showMontlySavingLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.priceField.layer.cornerRadius = 10
        self.addButton.layer.cornerRadius = 20
        self.segmentedController.layer.cornerRadius = 10
    }
    

    
    @IBAction func priceSlider(_ sender: UISlider) {
        print(Int(sender.value))
    }
    
    @IBAction func addSaving(_ sender: UIButton) {
        print("add saving")
    }
    
}
