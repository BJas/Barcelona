//
//  ProfileViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 14.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ProfileViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var teamLabel: UILabel!
    var teamName: String?
    @IBOutlet weak var positionTitleLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    var position = 0
    @IBOutlet weak var matchTitleLabel: UILabel!
    @IBOutlet weak var matchLabel: UILabel!
    var match = 0
    @IBOutlet weak var pointsTitleLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    var point = 0
    
    @IBOutlet weak var teamImageView: UIImageView!
    
    var imgUrl : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamLabel.text = teamName;
        positionTitleLabel.text = "Позиция"
        positionLabel.text = String(position)
        matchTitleLabel.text = "Матчи"
        matchLabel.text = String(match)
        pointsTitleLabel.text = "Очки"
        pointsLabel.text = String(point)
        let url = URL(string: imgUrl!)
        let data = try? Data(contentsOf: url!)
        teamImageView.image = UIImage(data: data!)
        // Do any additional setup after loading the view.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Профиль")
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
