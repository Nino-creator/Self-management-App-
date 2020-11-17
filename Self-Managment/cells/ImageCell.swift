//
//  ImageCell.swift
//  Self-Managment
//
//  Created by Nini mekhashishvili on 9/15/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    
    @IBOutlet weak var categoryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
