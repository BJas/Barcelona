//
//  StandingViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 12.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class StandingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var standingList:Array<Standing> = [];
    @IBOutlet weak var standingTableView: UITableView!
    var menuVC : MenuViewController!
    
    var standingTeam = ["FC Barcelona": "Барселона", "Valencia CF": "Валенсия", "Real Madrid CF": "Реал Мадрид", "Club Atlético de Madrid": "Атлетико",
                        "Villarreal CF": "Вильярреал", "Sevilla FC":"Севилья", "Real Sociedad de Fútbol":"Реал Сосьедад", "Real Betis":"Бетис", "CD Leganes":"Леганес", "Girona FC":"Жирона","RC Celta de Vigo":"Сельта","Getafe CF":"Хетафе","RCD Espanyol":"Эспаньол","Levante UD":"Леванте","Athletic Club":"Атлетик","RC Deportivo La Coruna":"Депортиво","SD Eibar":"Эйбар","Deportivo Alavés":"Алавес","UD Las Palmas":"Лас-Пальмас","Málaga CF":"Малага"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuVC = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGosture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGosture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        
        let myActivityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width/2-25, y: self.view.frame.height/2-25, width: 50, height: 50))
        myActivityIndicator.color =  UIColor.init(red: 0/255, green: 77/255, blue: 152/255, alpha: 1)
        myActivityIndicator.type = .ballSpinFadeLoader
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        Alamofire.request("http://api.football-data.org/v1/competitions/455/leagueTable").responseJSON{
            response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let innerDict = dict["standing"] as? [[String: Any]]{
                    for item in innerDict{
                        var team = "";
                        for (teamInEnglish, teamInRussian) in self.standingTeam {
                            if(item["teamName"] as! String == teamInEnglish) {
                                team = teamInRussian
                                break;
                            }
                        }
                        self.standingList.append(Standing(
                            position: item["position"] as! Int,
                            teamName: team,
                            points: item["points"] as! Int,
                            goal: item["goalDifference"] as! Int,
                            wins: item["wins"] as! Int, draws: item["draws"] as! Int, losses: item["losses"] as! Int, games: item["playedGames"] as! Int))
                    }
                }
            }
            myActivityIndicator.stopAnimating()
            self.standingTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showMenu() {
        UIView.animate(withDuration: 0.3) { ()->  Void in
            self.menuVC.view.backgroundColor = UIColor.white.withAlphaComponent(0)
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
    
    @IBAction func changeMenu(_ sender: Any) {
        if(AppDelegate.menuBool) {
            showMenu()
        } else {
            closeMenu()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standingList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "standingCell", for: indexPath) as? StandingTableViewCell
        
        if (indexPath.row == 0) {
            cell?.positionLabel.text = " №"
            cell?.positionLabel.textColor = UIColor.white
            cell?.teamLabel.text = "Команда"
            cell?.teamLabel.textColor = UIColor.white
            cell?.infoLabel.text = "М  В  Н  П  "
            cell?.infoLabel.textColor = UIColor.white
            cell?.goalsLabel.text = " РГ "
            cell?.goalsLabel.textColor = UIColor.white
            cell?.pointLabel.text = "O  "
            cell?.pointLabel.textColor = UIColor.white
            cell?.backgroundColor = UIColor.init(red: 0, green: 77/255, blue: 152/255, alpha: 1)
            cell?.tintColor = UIColor.white
            cell?.preservesSuperviewLayoutMargins = false
            cell?.separatorInset = UIEdgeInsets.zero
            cell?.layoutMargins = UIEdgeInsets.zero
            
        }
        else {
            if (indexPath.row % 2 == 0) {
                cell?.backgroundColor = UIColor.init(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
            }
            cell?.positionLabel.text =
                " "+String(standingList[indexPath.row-1].position)
            cell?.teamLabel.text = standingList[indexPath.row-1].teamName
            cell?.teamLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
            cell?.infoLabel.text =
                betweenLine(number: standingList[indexPath.row-1].games) +
                betweenLine(number: standingList[indexPath.row-1].wins) +
                betweenLine(number: standingList[indexPath.row-1].draws) +
                betweenLine(number: standingList[indexPath.row-1].losses)
            cell?.goalsLabel.text =
                betweenLineGoal(number: standingList[indexPath.row-1].goal)
            cell?.pointLabel.text =
                String(standingList[indexPath.row-1].points)
            cell?.pointLabel.textColor = UIColor.init(red: 0, green: 77/255, blue: 152/255, alpha: 1)
            cell?.pointLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
            
        }
        return cell!
    }
    
    func betweenLine(number: Int) -> String{
        if (number <= 9 && number >= 0) {
            return String(number) + "  ";
        }
        return String(number) + " ";
    }
    
    func betweenLineGoal(number: Int) -> String{
        if (number <= 9 && number >= 0) {
            return " " + String(number) + "  ";
        }
        else if (number >= 10) {
            return " " + String(number) + " ";
        }
        return String(number) + " ";
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UIScreen.main.bounds.size.height / 23;//Choose your custom row height
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
