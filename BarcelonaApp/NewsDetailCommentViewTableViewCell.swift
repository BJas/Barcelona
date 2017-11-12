//
//  NewsDetailCommentViewTableViewCell.swift
//  BarcelonaApp
//
//  Created by Apple on 10.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class NewsDetailCommentViewTableViewCell: UITableViewCell {

    @IBOutlet weak var commentDescLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
