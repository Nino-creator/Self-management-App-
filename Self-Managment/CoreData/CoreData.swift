//
//  CoreData.swift
//  Self-Managment
//
//  Created by Nini mekhashishvili on 9/14/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//

import Foundation
import CoreData

class CoreDataFunc {
    
    static func save(name: String, surname: String, username: String, password: String, salary: Int){
        let context = AppDelegate.coreDataContainer.viewContext
        
        let person = Person(context: context)
       
        
        person.name = name
        person.surname = surname
        person.username = username
        person.password = password
        person.salary = Int16(salary)
        //person.surname = self.sur
        var dic = Dictionary<String,String>()
        dic["title"] = "new"
        dic["image"] = "1"
        person.categories = [Dictionary<String,String>]()
        person.categories?.append(dic)
        
        do{
            try context.save()
            print("save")
        }catch {}
    }
    
    
    static func fetch() {
        
        let context = AppDelegate.coreDataContainer.viewContext
        
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        do{
            let person = try context.fetch(request)
            LogInViewController.users = person
        }catch {}
    }
    
    
    static func addCategory(person: Person, title: String, image: String){
        let context = AppDelegate.coreDataContainer.viewContext
        
        var info = Dictionary<String,String>()
        info["title"] = title
        info["money"] = "0"
        info["image"] = image
        
        person.categories?.append(info)
        
        do{
            try context.save()
            print("save in core")
            
        }catch{}
    }
    
    static func updateInfo(person: Person, info: String, index: Int){
        let context = AppDelegate.coreDataContainer.viewContext
        
        switch index {
        case 0:
            person.name = info
        case 1:
             person.surname = info
        case 2:
             person.username = info
        case 3:
            person.password = info
        case 4:
            person.salary = Int16(info) ?? 0
        default:
            print("none")
        }
        
        do{
            try context.save()
            print("save update")
            
        }catch{}
    }
    
    static func deleteCategory(person: Person, index: Int){
        let context = AppDelegate.coreDataContainer.viewContext
        
        person.categories?.remove(at: index)
        
        do{
                   try context.save()
                   print("save update")
                   
               }catch{}
    }
    
    static func addCategory(person: Person, money: Int, index: Int){
        let context = AppDelegate.coreDataContainer.viewContext
        
        guard let category = person.categories?[index] else {return}
        guard let oldmoney = category["money"] else {return}
        
        let spend = Int(oldmoney)! + money
        
        print(spend)
        person.categories?[index]["money"] = String(spend)
        
        do{
            try context.save()
            print("save in core")
            
        }catch{}
    }
    
    static func deleteObject(_ person: Person){
        
        let context = AppDelegate.coreDataContainer.viewContext
        
        context.delete(person)
        
        do{
            try context.save()
            print("save in core")
            
        }catch{}

       
    }
    
    
}
