//
//  UDManager.swift
//  Self-Managment
//
//  Created by Nini mekhashishvili on 9/14/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//

import Foundation

class UDManager {
    internal static let USERNAME = "username"
    internal static let PASSWORD = "password"
    internal static let LOGIN = "log_in"
    
    
    
    static func getUD() -> UserDefaults{
        return UserDefaults.standard
    }
    
    //save username
    static func saveUsername(name: String){
        getUD().set(name, forKey: USERNAME)
    }
    //get username
    static func getUserame() -> String{
        return getUD().string(forKey: USERNAME) ?? ""
    }
    
    //same password
    static func savePassword(pas: String){
        getUD().set(pas, forKey: PASSWORD)
    }
    //get password
    static func getPassword() -> String{
        getUD().string(forKey: PASSWORD) ?? ""
    }
    
    //chek log in
    static func saveLogIn(logIn: Bool){
        getUD().set(logIn, forKey: LOGIN)
    }
    
    //get log in
    static func getLogIn() -> Bool{
        getUD().bool(forKey: LOGIN)
    }
}
