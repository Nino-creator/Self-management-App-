//
//  ViewController.swift
//  Self-Managment
//
//  Created by Nini mekhashishvili on 9/13/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//

import UIKit
import CoreData

class LogInViewController: UIViewController {
    

    @IBOutlet weak var registrationLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var warningLabell: UILabel!
    
    var username: String?
    var password: String?
    static var users = [Person]()
    var logIn = false
    var onUser: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoreDataFunc.fetch()
        checkLogIn()
     
        logInButton.layer.cornerRadius = 15
        registrationButton.layer.cornerRadius = 15
        
        //when someone register it saves info and does fetch again
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(savedUser),
            name: .savedUserChannelID,
            object: nil)
        print(LogInViewController.users.count)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //tab bar
        if let id = segue.identifier, id == "go_user_info_id"{
            
            if let tabBarVC = segue.destination as? MainTabBarViewController {
                tabBarVC.user = onUser
            }
        }
        
    }
    
    //log in button
    @IBAction func LogInButton(_ sender: UIButton) {
        
        username = usernameField.text ?? ""
        password = passwordField.text ?? ""
        
        //checks if the given user exists than long in and go next page
        if checkUser(username: self.username!, password: self.password!) {
            warningLabell.text = ""
            performSegue(withIdentifier: Segue.goTabBar, sender: self)
        }else{
            warningLabell.text = "password or username is incorrect"
        }
        cleanTextFields()
    }
    
    //go registration viewController
    @IBAction func registrationButton(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.goRegistration, sender: self)
    }
    
}



extension LogInViewController {
    
    //checks if the user with the given username and password exist
    func checkUser(username: String, password: String) -> Bool {
        for user in LogInViewController.users{
            if user.username == username && user.password == password {
                self.onUser = user
                self.logIn = true
                break
            }else{
                logIn = false
            }
        }
        return logIn
    }
    
    @objc func savedUser(with notification: Notification){
        CoreDataFunc.fetch()
    }
    
    func cleanTextFields(){
        self.usernameField.text = ""
        self.passwordField.text = ""
    }
    
    func checkLogIn(){
        
        if UDManager.getLogIn() == true {
            let knownUser = UDManager.getUserame()
            let knownPassword = UDManager.getPassword()
            print(knownUser)
            print(knownPassword)
            if checkUser(username: knownUser, password: knownPassword) {
                warningLabell.text = ""
                performSegue(withIdentifier: Segue.goTabBar, sender: self)
            }else{
                warningLabell.text = "password or username is incorrect"
            }
        }
    }
}

