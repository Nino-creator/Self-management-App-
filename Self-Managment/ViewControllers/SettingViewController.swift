//
//  SettingViewController.swift
//  Self-Managment
//
//  Created by Nini mekhashishvili on 9/13/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    
    @IBOutlet weak var settingTableView: UITableView!
    
    var user = Person()
    var infoNames = ["name","surname","username","password","salary","log out"]
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        //print(infoNames.count)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == Segue.goChangeInfo {
            if let changeVC = segue.destination as? ChangeInfoViewController {
                var info = user.name
                
                switch selectedIndex {
                case 0:
                    info = user.name
                case 1:
                    info = user.surname
                case 2:
                    info = user.username
                case 3:
                    info = user.password
                case 4:
                    info = String(user.salary)
                default:
                    print("none")
                }
                
                changeVC.selectedTitle = infoNames[selectedIndex]
                changeVC.oldInfo = info
                changeVC.user = self.user
                changeVC.selectedIndex = self.selectedIndex
            }
        }
    }
    

}
extension SettingViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTableView.dequeueReusableCell(withIdentifier: "setting_info_cell_id", for: indexPath) as! SettingInfoCell
            cell.infoLabel.text = infoNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        
        if infoNames[selectedIndex] != "log out"{
            performSegue(withIdentifier: Segue.goChangeInfo, sender: self)
        }else{
            UDManager.saveLogIn(logIn: false)
            print(UDManager.getLogIn())
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
}
