//
//  MenuTableViewCell.swift
//  BarcelonaApp
//
//  Created by Apple on 11.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if (selected) {
            menuLabel.textColor = UIColor.white
        } else {
            menuLabel.textColor = UIColor.white
        }
    }

}
