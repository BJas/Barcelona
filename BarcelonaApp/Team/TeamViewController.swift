//
//  TeamViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 16.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var rootRef: DatabaseReference! = nil
    var menuVC : MenuViewController!
    var goalkeepers: Array<Team> = []
    var defenders: Array<Team> = []
    var midfield: Array<Team> = []
    var strikers: Array<Team> = []
    var team = [[Team]]()
    let sections = ["ВРАТАРИ", "ЗАЩИТНИКИ", "ПОЛУЗАЩИТНИКИ", "НАПАДАЮЩИЕ"]
    
    @IBOutlet weak var teamTableView: UITableView!
    
    @IBAction func showMenu(_ sender: Any) {
        if(AppDelegate.menuBool) {
            showMenu()
        } else {
            closeMenu()
        }
    }
    
    func showMenu() {
        self.menuVC.view.backgroundColor = UIColor.white.withAlphaComponent(0)
        UIView.animate(withDuration: 0.3) { ()->  Void in
            self.menuVC.view.frame = CGRect(x: 0, y: 63, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.addChildViewController(self.menuVC)
            self.view.addSubview(self.menuVC.view)
            AppDelegate.menuBool = false
        }
    }
    
    func closeMenu() {
        UIView.animate(withDuration: 0.3, animations: { ()-> Void in
            self.menuVC.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 63, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }){ (finished) in
            self.menuVC.view.removeFromSuperview()
        }
        AppDelegate.menuBool = true
    }
    
    @objc func respondToGosture(gesture: UISwipeGestureRecognizer){
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.right: showMenu()
        case UISwipeGestureRecognizerDirection.left: closeMenu()
        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuVC = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGosture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGosture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        
        //Firebase
        rootRef = Database.database().reference()
        let teamRef = rootRef.child("members")
        teamRef.observe(DataEventType.value, with: { (snapshot) in
            for teamMember in snapshot.children.allObjects as![DataSnapshot] {
                let memberObject = teamMember.value as? [String: AnyObject]
                let position = memberObject?["position"] as? String ?? ""
                let id = memberObject?["id"] as? Int
                let name = memberObject?["name"] as? String ?? ""
                let number = memberObject?["number"] as? Int
                let imgUrl = memberObject?["imgUrl"] as? String ?? ""
                let age = memberObject?["age"] as? Int
                let height = memberObject?["height"] as? Int
                let weight = memberObject?["weight"] as? Int
                let nationality = memberObject?["nationality"] as? String ?? ""
                let birth = memberObject?["birth"] as? String ?? ""
                let contract = memberObject?["contract"] as? String ?? ""
                if(position == "Вратарь") {
                    self.goalkeepers.append(Team(id: id!, name: name, position: position, number: number!, imgUrl: imgUrl, age: age!, height: height!, weight: weight!, nationality: nationality, birth: birth, contract: contract))
                } else if(position == "Защитник") {
                    self.defenders.append(Team(id: id!, name: name, position: position, number: number!, imgUrl: imgUrl, age: age!, height: height!, weight: weight!, nationality: nationality, birth: birth, contract: contract))
                } else if(position == "Полузащитник") {
                    self.midfield.append(Team(id: id!, name: name, position: position, number: number!, imgUrl: imgUrl, age: age!, height: height!, weight: weight!, nationality: nationality, birth: birth, contract: contract))
                } else if(position == "Нападающий") {
                    self.strikers.append(Team(id: id!, name: name, position: position, number: number!, imgUrl: imgUrl, age: age!, height: height!, weight: weight!, nationality: nationality, birth: birth, contract: contract))
                }
            }
            self.team.append(self.goalkeepers)
            self.team.append(self.defenders)
            self.team.append(self.midfield)
            self.team.append(self.strikers)
            self.teamTableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 45))
        headerView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        let label = UILabel(frame: CGRect(x: 0, y: 15, width: tableView.bounds.width, height: 16))
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        label.textAlignment = .center
            switch section {
            case 0:
                label.text = sections[0]
            case 1:
                label.text = sections[1]
            case 2:
                label.text = sections[2]
            case 3:
                label.text = sections[3]
            default:
                label.text = ""
        }
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return goalkeepers.count
        case 1:
            return defenders.count
        case 2:
            return midfield.count
        case 3:
            return strikers.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as? TeamTableViewCell
        cell?.positionLabel.text = String(team[indexPath.section][indexPath.row].number)
        let url = URL(string: team[indexPath.section][indexPath.row].imgUrl)
        let data = try? Data(contentsOf: url!)
        cell?.teamImageView.layer.cornerRadius = 22.0
        cell?.teamImageView.clipsToBounds = true
        let borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        cell?.teamImageView.layer.borderColor = borderColor.cgColor
        cell?.teamImageView.layer.borderWidth = 2.0
        cell?.teamImageView.image = UIImage(data: data!)
        cell?.nameLabel.text = team[indexPath.section][indexPath.row].name
        return cell!
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "showTeamDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sectionSelected = (sender as! NSIndexPath).section
        let rowSelected = (sender as! NSIndexPath).row
        let destinationVC = segue.destination as! TeamDetailsViewController
        destinationVC.imgUrl = team[sectionSelected][rowSelected].imgUrl
        destinationVC.name = team[sectionSelected][rowSelected].name
        destinationVC.position = team[sectionSelected][rowSelected].position
        
        destinationVC.age = team[sectionSelected][rowSelected].age
        destinationVC.height = team[sectionSelected][rowSelected].height
        destinationVC.weight = team[sectionSelected][rowSelected].weight
        
        destinationVC.number = team[sectionSelected][rowSelected].number
        destinationVC.nationality = team[sectionSelected][rowSelected].nationality
        destinationVC.birth = team[sectionSelected][rowSelected].birth
        destinationVC.contract = team[sectionSelected][rowSelected].contract
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
