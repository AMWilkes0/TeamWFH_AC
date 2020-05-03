//
//  SpecificItemTableViewCell.swift
//  TeamWFH_finalproject
//
//  Created by Alison Wilkes on 5/3/20.
//  Copyright © 2020 Alison Wilkes. All rights reserved.
//

import UIKit

class SpecificItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
