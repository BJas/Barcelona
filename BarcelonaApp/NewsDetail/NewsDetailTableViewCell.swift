//
//  NewsDetailTableViewCell.swift
//  BarcelonaApp
//
//  Created by Apple on 31.10.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class NewsDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
