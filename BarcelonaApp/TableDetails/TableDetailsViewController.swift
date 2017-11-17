//
//  TableDetailsViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 13.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Alamofire

class TableDetailsViewController:UIViewController {
    
    
    var teamName: String?
    var position = 0
    var match = 0
    var point = 0
    var imgUrl : String?
    var goal = 0
    var goalAgainst = 0
    var goalDifference = 0
    
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var posTitleLabel: UILabel!
    @IBOutlet weak var posLabel: UILabel!
    @IBOutlet weak var matchTitleLabel: UILabel!
    @IBOutlet weak var matchLabel: UILabel!
    @IBOutlet weak var pointTitleLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var goalTitleLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var goalAgainstTitleLabel: UILabel!
    @IBOutlet weak var goalAgainstLabel: UILabel!
    @IBOutlet weak var goalDiffTitleLabel: UILabel!
    @IBOutlet weak var goalDifferenceLabel: UILabel!
    
    
    @IBOutlet weak var LabelView: UIView!
    @IBOutlet weak var TableView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        teamNameLabel.text = teamName;
        posTitleLabel.text = "Позиция";
        posLabel.text = String(position);
        matchTitleLabel.text = "Матчи";
        matchLabel.text = String(match);
        pointTitleLabel.text = "Очки";
        pointLabel.text = String(point);
        goalTitleLabel.text = "Забитые голы";
        goalLabel.text = String(goal);
        goalAgainstTitleLabel.text = "Пропущенные";
        goalAgainstLabel.text = String(goalAgainst);
        goalDiffTitleLabel.text = "Разница мячей";
        goalDifferenceLabel.text = String(goalDifference);
        let url = URL(string: imgUrl!);
        let data = try? Data(contentsOf: url!)
        teamImageView.image = UIImage(data: data!);
        
        TableView.layer.masksToBounds = false
        TableView.layer.shadowColor = UIColor.black.cgColor
        TableView.layer.shadowOpacity = 0.5
        TableView.layer.shadowOffset = .zero
        TableView.layer.shadowRadius = 5
        
        TableView.layer.cornerRadius = 8
        TableView.layer.borderColor = UIColor.gray.cgColor
        TableView.layer.borderWidth = 0.5
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
