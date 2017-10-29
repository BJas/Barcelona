//
//  NewsDetailViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 18.10.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    var newsTitle: String?
    var newsDate: String?
    var newsImg: UIImage?
    var newsDescription: String?
    
    
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsImageVIew: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDateTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTitleLabel.text = newsTitle
        newsDateTitle.text = newsDate
        newsDescriptionLabel.text = newsDescription
        newsImageVIew.image = newsImg
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
