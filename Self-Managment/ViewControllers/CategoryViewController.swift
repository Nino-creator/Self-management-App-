//
//  CategoryViewController.swift
//  Self-Managment
//
//  Created by Nini mekhashishvili on 9/13/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    var user = Person()
    var categories = [Dictionary<String,String>]()
    var newCategory =  Dictionary<String,String>()
    var selectedIndex = 0
    //var newCategory = Category()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self 
        collectionView.dataSource = self

        //print(user.username!)
        //print(user.password!)
        notifications()
}
   
    @IBAction func addCategoryButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Segue.goChooseCategory , sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == Segue.goCellSettings{
            if let AddDeleteVC = segue.destination as? AddDeleteCellViewController {
                AddDeleteVC.selectedIndex = self.selectedIndex
                AddDeleteVC.user = self.user
                AddDeleteVC.categories = self.categories
            }
        }
    }
    

}

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category_cell", for: indexPath) as! CategoryCell

        let category = self.categories[indexPath.row]
        cell.categoryImage.image = UIImage(named: category["image"] ?? "food")
        cell.categoryLabel.text = category["title"]!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: Segue.goCellSettings, sender: self)
    }
    
    
}


extension CategoryViewController{
    func notifications(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(saveCategory),
            name: .addCategoryChannelID,
            object: nil)
        
        
        NotificationCenter.default.addObserver(
        self,
        selector: #selector(deleteCategory),
        name: .deleteCategoryChannelID,
        object: nil)
        
        NotificationCenter.default.addObserver(
        self,
        selector: #selector(addMoney),
        name: .addSpendChannelID,
        object: nil)
    }
}

extension CategoryViewController{
    @objc func saveCategory(with notification: Notification){
        if let info = notification.userInfo{
            
            let title = info["name"] as? String
            let image = info["image"] as? String
            
            self.newCategory["title"] = title
            self.newCategory["image"] = image
            categories.append(self.newCategory)

            CoreDataFunc.addCategory(person: user, title: title!, image: image!)
            collectionView.reloadData()
        }
    }
    
    @objc func deleteCategory(wiht notification: Notification){
        if let info = notification.userInfo{
            
            let index = info["index"] as! Int
            
            categories.remove(at: index) 
            self.collectionView.reloadData()
        }
    }
    
    @objc func addMoney(with notification: Notification){
        if let info = notification.userInfo{
            
            let index = info["index"] as! Int
            let money = info["money"] as! Int
            
            let category = categories[index]
            let spend = String(Int(category["money"] ?? "0")! + money)
            print(spend)
            categories[index]["money"] = String(spend)
        }
    }
}
 
