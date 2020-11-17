//
//  Notifications.swift
//  Self-Managment
//
//  Created by Nini mekhashishvili on 9/13/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//

import Foundation

extension Notification.Name{
    
    static let savedUserChannelID       = NSNotification.Name("saved_user_id")
    static let deleteCategoryChannelID  = NSNotification.Name("delete_category_id")
    static let addCategoryChannelID     = NSNotification.Name("add_category_id")
    static let addSpendChannelID        = NSNotification.Name("add_spend_id")
    static let ChangeInfoChannelID      = NSNotification.Name("change_salary_id")
}
