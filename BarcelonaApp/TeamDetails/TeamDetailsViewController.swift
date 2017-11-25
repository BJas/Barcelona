//
//  TeamDetailsViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 17.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    
    @IBOutlet weak var topImageView: UIView!
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    var imgUrl: String?
    var name: String?
    var position: String?
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    var age = 0
    var height = 0
    var weight = 0
    
    @IBOutlet weak var numberTitleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nationalityTitleLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var birthTitleLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var contractTitleLabel: UILabel!
    @IBOutlet weak var contractLabel: UILabel!
    var number = 0
    var nationality: String?
    var birth: String?
    var contract: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name
        getTopView()
        getMiddleView()
        getBottomView()
        // Do any additional setup after loading the view.
    }
    
    func getTopView() {
        let url = URL(string: imgUrl!)
        let data = try? Data(contentsOf: url!)
        topImageView.backgroundColor = UIColor(patternImage: UIImage(named: "camp")!)
        let borderColor = UIColor(red: 0, green: 38/255, blue: 77/255, alpha: 1)
        teamImageView.layer.borderColor = borderColor.cgColor
        teamImageView.layer.borderWidth = 5.0
        teamImageView.layer.cornerRadius = 8.0
        teamImageView.clipsToBounds = true
        teamImageView.image = UIImage(data: data!)
        nameLabel.text = name
        positionLabel.text = position
    }
    
    func getMiddleView() {
        
        ageLabel.text = "Возраст:" + "\n" + String(age)
        heightLabel.text = "Рост:" + "\n" + String(height)
        weightLabel.text = "Вес:" + "\n" + String(weight)
    }
    
    func getBottomView() {
        numberTitleLabel.text = "Номер:"
        nationalityTitleLabel.text = "Страна:"
        birthTitleLabel.text = "Родился:"
        contractTitleLabel.text = "Контракт до:"
        
        numberLabel.text = String(number)
        nationalityLabel.text = nationality
        birthLabel.text = birth
        contractLabel.text = contract
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
