//
//  MianTabBarViewController.swift
//  Self-Managment
//
//  Created by Nini mekhashishvili on 9/13/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    var user = Person()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveUserInUDManager()
        
        guard let viewControllers = viewControllers else {return}
        
        for viewController in viewControllers{
            
            if let categoryNC = viewController as? CategoryNavigationController{
                if let categoryVC = categoryNC.viewControllers.first as? CategoryViewController{
                    categoryVC.user = self.user
                    categoryVC.categories = self.user.categories ?? [Dictionary<String,String>]()
                }
            }
            
            if let budgetVC = viewController as? BudgetInfoViewController{
                budgetVC.user = self.user
                budgetVC.categories = self.user.categories ?? []
            }
            
            if let settingVC = viewController as? SettingViewController{
                settingVC.user = self.user
            }
        }
    }
    
    func saveUserInUDManager() {
        
        UDManager.saveLogIn(logIn: true)
        UDManager.saveUsername(name: user.username!)
        UDManager.savePassword(pas: user.password!)
    }
}
