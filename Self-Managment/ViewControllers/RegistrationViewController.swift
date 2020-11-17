//
//  RegistrationViewController.swift
//  Self-Managment
//
//  Created by Nini mekhashishvili on 9/13/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var salaryField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    var isValid = false
    var user = User() 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.layer.cornerRadius = 15
    }

    @IBAction func registerOn(_ sender: UIButton) {
        
        if checkText() {
            saveUserInCoreData()
            cleanTextFields()
            savedUser()
        }else{
            print("something is incorrect")
        }
    }
}

extension RegistrationViewController{
    
    func cleanTextFields(){
        nameField.text = ""
        surnameField.text = ""
        usernameField.text = ""
        passwordField.text = ""
        salaryField.text = ""
    }
    
    
    func savedUser(){
        NotificationCenter.default.post(
            name: .savedUserChannelID,
            object: nil)
    }
    
    func saveUserInCoreData(){
        
        guard let salary = user.salary else {return}
        
        CoreDataFunc.save(
        name: user.name,
        surname: user.surname,
        username: user.password,
        password: user.username,
        salary: salary)
    }
    
    func checkText() -> Bool{
        user.name = nameField.text
        user.surname = surnameField.text
        user.username = usernameField.text
        user.password = passwordField.text
        user.salary = Int(salaryField.text ?? "0")
        
        
        if user.name != "" && user.surname != "" && user.password != "" && user.username != "" {
            isValid = true
        }else{
            isValid = false
        }
        return isValid
    }
}
