//
//  User.swift
//  Self-Managment
//
//  Created by Nini mekhashishvili on 9/13/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//

import Foundation

struct User {
    var name: String!
    var surname: String!
    var username: String!
    var password: String!
    var salary: Int!
    var categories = [Category]()
}


public struct Category {
    var name: String!
    var image: String!
}
