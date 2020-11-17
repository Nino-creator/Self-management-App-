//
//  GraphViewController.swift
//  Self-Managment
//
//  Created by Nini mekhashishvili on 9/13/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    
    @IBOutlet weak var graph1View: UIView!
    @IBOutlet weak var graph2View: UIView!
    @IBOutlet weak var graph3View: UIView!
    @IBOutlet weak var graph4View: UIView!
    @IBOutlet weak var graph5View: UIView!
    @IBOutlet weak var graph7View: UIView!
    @IBOutlet weak var graph8View: UIView!
    
    
    var user = Person()
    var categories = [Dictionary<String,String>]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        graph1View.isHidden = true
        graph2View.isHidden = true
        graph3View.isHidden = true
        graph4View.isHidden = true
        graph5View.isHidden = true
        graph7View.isHidden = true
        graph8View.isHidden = true
        
        self.view.layoutSubviews()
        
        print(categories.count)
        
        checknumber()
        
        animate()
        

        // Do any additional setup after loading the view.
    }
    
    func calculate(){
        for category in categories{
            let spend = Float(category["money"] ?? "0")
            let x = spend! / Float(self.user.salary)
            let y = Float(round(1000*x))/10
        }
    }
    
    func checknumber(){
        switch categories.count {
        case 0:
            print("none")
        case 1:
            graph1View.isHidden = false
        case 2:
            graph1View.isHidden = false
            graph2View.isHidden = false
        case 3:
            graph1View.isHidden = false
            graph2View.isHidden = false
            graph3View.isHidden = false
        case 4:
            graph1View.isHidden = false
            graph2View.isHidden = false
            graph3View.isHidden = false
            graph4View.isHidden = false
        case 5:
            graph1View.isHidden = false
            graph2View.isHidden = false
            graph3View.isHidden = false
            graph4View.isHidden = false
            graph5View.isHidden = false
        case 6:
            graph1View.isHidden = false
            graph2View.isHidden = false
            graph3View.isHidden = false
            graph4View.isHidden = false
            graph5View.isHidden = false
            graph7View.isHidden = false
        case 7:
            graph1View.isHidden = false
            graph2View.isHidden = false
            graph3View.isHidden = false
            graph4View.isHidden = false
            graph5View.isHidden = false
            graph7View.isHidden = false
            graph8View.isHidden = false
            
        default:
            print("other")
        }
    }
    
    func sizeZero(){
        self.graph1View.frame.size.height = 0
        self.graph2View.frame.size.height = 0
        self.graph3View.frame.size.height = 0
        self.graph4View.frame.size.height = 0
        self.graph5View.frame.size.height = 0
        self.graph7View.frame.size.height = 0
        self.graph8View.frame.size.height = 0
    }
    
    func sizeIncrease(){
        var height = 100;
        
        //self.graph1View.frame = CGRect(self.View.Frame.Left, graph1View.Frame.Y + height, graph1View.Superview.Frame.Right, 0)
        self.graph2View.frame.size.height = 200
        self.graph3View.frame.size.height = 200
        self.graph4View.frame.size.height = 200
        self.graph5View.frame.size.height = 200
        self.graph7View.frame.size.height = 200
        self.graph8View.frame.size.height = 200
    }
    
    
    func animate(){
        UIView.animate(withDuration: 0.5, animations:  {
            self.sizeIncrease()
            
        })
    }
    

}
