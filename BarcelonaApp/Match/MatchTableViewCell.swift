//
//  MatchTableViewCell.swift
//  BarcelonaApp
//
//  Created by Apple on 17.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
