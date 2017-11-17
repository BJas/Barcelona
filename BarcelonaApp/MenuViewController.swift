//
//  MenuViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 11.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuTableView: UITableView!
    
    let titleArr = ["home.png", "ball.png", "table.png", "match.png", "game.png"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as! MenuTableViewCell
        let fullString = NSMutableAttributedString(string: "")
        
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = UIImage(named: titleArr[indexPath.row])
        image1Attachment.bounds = CGRect(x: 0.0, y: 0.0, width: 24, height: 24)
        let image1String = NSAttributedString(attachment: image1Attachment)
        
        fullString.append(image1String)
        cell.menuLabel.attributedText = fullString
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 165/255, green: 0, blue: 68/255, alpha: 0.8)
        cell.selectedBackgroundView = bgColorView
        cell.menuLabel.tintColor = UIColor(red: 165/255, green: 0, blue: 68/255, alpha: 1)
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "showMainPage", sender: indexPath)
        case 2:
            performSegue(withIdentifier: "showStandingPage", sender: indexPath)
        case 3:
            performSegue(withIdentifier: "showTeamPage", sender: indexPath)
        case 4:
            performSegue(withIdentifier: "showTestPage", sender: indexPath)
        default:
            break;
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.bounces = false
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
