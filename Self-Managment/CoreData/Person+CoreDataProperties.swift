//
//  Person+CoreDataProperties.swift
//  Self-Managment
//
//  Created by Nini mekhashishvili on 9/14/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    //@NSManaged public var categories: Dictionary<String,Dictionary<String,String>>?
    @NSManaged public var categories: [Dictionary<String,String>]?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var salary: Int16
    @NSManaged public var surname: String?
    @NSManaged public var username: String?
    

}
