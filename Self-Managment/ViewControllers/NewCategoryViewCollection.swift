//
//  NewCategoryViewCollection.swift
//  Self-Managment
//
//  Created by Nini mekhashishvili on 9/13/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//

import UIKit

class NewCategoryViewCollection: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryNameField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    var category = Category()
    let images = ["1","2","3","4","5","6"]
    var selectedImage = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryNameField.layer.cornerRadius = 10
        self.addButton.layer.cornerRadius = 20
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addCategory(_ sender: UIButton) {
        print("add category")
        
        category.name = categoryNameField.text
        category.image = selectedImage
        
        sendCategory(category)
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    func sendCategory(_ category: Category){
        NotificationCenter.default.post(
            name: .addCategoryChannelID,
            object: nil,
            userInfo: ["name": self.category.name!,
                       "image":self.category.image!])
    }
    
    deinit{
        print("remove")
        NotificationCenter.default.removeObserver(self)
    }
    
}


extension NewCategoryViewCollection: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "image_cell_id", for: indexPath) as! ImageCell
        
        let imageName = images[indexPath.row]
        
        cell.categoryImage.image = UIImage(named: imageName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedImage = images[indexPath.row]
    }
    
    
}

