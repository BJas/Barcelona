//
//  StandingViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 12.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseDatabase

class StandingViewController: IndicatorViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var standingList:Array<Standing> = [];
    @IBOutlet weak var standingTableView: UITableView!
    var teamEng = ""
    var standingTeam = [String: String]()
    var standingTeamImg = [String: String]()
    var rootRef: DatabaseReference! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        standingTableView.tableFooterView = UIView()
        Defs.reveal(self, menuButton: self.menuButton)
        self.activityIndicatorBegin()
        //Firebase
        rootRef = Database.database().reference()
        let itemsRef = rootRef.child("teams")
        
        itemsRef.observe(DataEventType.value, with: { (snapshot) in
            for teamInfo in snapshot.children.allObjects as![DataSnapshot] {
                let teamObject = teamInfo.value as? [String: AnyObject]
                let img = teamObject?["imgUrl"] as? String ?? ""
                let english = teamObject?["nameInEnglish"] as? String ?? ""
                let russian = teamObject?["nameInRussian"] as? String ?? ""
                self.standingTeam[english] = russian
                self.standingTeamImg[english] = img
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //Alamofire
        Alamofire.request("http://api.football-data.org/v1/competitions/455/leagueTable").responseJSON{
            response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let innerDict = dict["standing"] as? [[String: Any]]{
                    for item in innerDict{
                        var team = "";
                        var teamImgUrl = "";
                        for (teamInEnglish, teamInRussian) in self.standingTeam {
                            if(item["teamName"] as? String == teamInEnglish) {
                                team = teamInRussian
                                break;
                            }
                        }
                        
                        for (teamName, teamImg) in self.standingTeamImg{
                            if(item["teamName"] as? String == teamName) {
                                teamImgUrl = teamImg
                                break;
                            }
                        }
                        
                        let position = item["position"] as? Int;
                        let points = item["points"] as? Int;
                        let gd = item["goalDifference"] as? Int;
                        let w = item["wins"] as? Int;
                        let d = item["draws"] as? Int;
                        let l = item["losses"] as? Int;
                        let pg = item["playedGames"] as? Int;
                        let gs = item["goals"] as? Int;
                        let ga = item["goalsAgainst"] as? Int;
                        self.standingList.append(Standing(
                            position: position!, teamName: team, points: points!, goal: gd!,
                            wins: w!, draws: d!, losses: l!, games: pg!, imgUrl:  teamImgUrl, goalAgainst : ga!, goalScore : gs!))
                    }
                }
            }
            self.activityIndicatorEnd()
            self.standingTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standingList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "standingCell", for: indexPath) as? StandingTableViewCell
        if (indexPath.row == 0) {
            cell?.positionLabel.text = " №"
            cell?.positionLabel.textColor = UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1)
            cell?.teamLabel.text = "Команда"
            cell?.imageLabel.text = ""
            cell?.teamLabel.textColor = UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1)
            cell?.infoLabel.text = "М   В    Н    П  "
            cell?.infoLabel.textColor = UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1)
            cell?.goalsLabel.text = " РГ "
            cell?.goalsLabel.textColor = UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1)
            cell?.pointLabel.text = "O  "
            cell?.pointLabel.textColor = UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1)
            cell?.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
            cell?.tintColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
            
        }
        else {
            var img = ""
            for (teamInEnglish, teamInRussian) in standingTeam {
                if(standingList[indexPath.row-1].teamName == teamInRussian) {
                    teamEng = teamInEnglish
                    break;
                }
            }
            
            for (teamName, teamImg) in standingTeamImg{
                if(teamEng == teamName) {
                    img = teamImg
                    break;
                }
            }
          
            
            let url = URL(string: img)
            let data = try? Data(contentsOf: url!)

            let fullString = NSMutableAttributedString(string: "")

            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(data: data!)
            image1Attachment.bounds = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.height / 23 - 11, height: UIScreen.main.bounds.size.height / 23 - 11)
            let image1String = NSAttributedString(attachment: image1Attachment)

            fullString.append(image1String)
            cell?.imageLabel.attributedText = fullString
            cell?.positionLabel.text =
                " "+String(standingList[indexPath.row-1].position)
            cell?.teamLabel.text = standingList[indexPath.row-1].teamName
            cell?.infoLabel.text =
                betweenLine(number: standingList[indexPath.row-1].games) +
                betweenLine(number: standingList[indexPath.row-1].wins) +
                betweenLine(number: standingList[indexPath.row-1].draws) +
                betweenLine(number: standingList[indexPath.row-1].losses)
            cell?.goalsLabel.text =
                betweenLineGoal(number: standingList[indexPath.row-1].goal)
            cell?.pointLabel.text =
                String(standingList[indexPath.row-1].points)
            cell?.pointLabel.font = UIFont(name:"HelveticaNeue", size: 15.0)
            cell?.tintColor = UIColor.lightGray
            
        }
        return cell!
    }
    
    func betweenLine(number: Int) -> String{
        if (number <= 9 && number >= 0) {
            return String(number) + "    ";
        }
        return String(number) + "   ";
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
        return UIScreen.main.bounds.size.height / 23 - 0.2;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row != 0) {
        performSegue(withIdentifier: "showTableDetail", sender: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let rowSelected = (sender as! NSIndexPath).row
        let destinationVC = segue.destination as! TableDetailsViewController
        destinationVC.position = standingList[rowSelected-1].position;
        destinationVC.match = standingList[rowSelected-1].games;
        destinationVC.point = standingList[rowSelected-1].points;
        destinationVC.teamName =  standingList[rowSelected-1].teamName;
        destinationVC.imgUrl = standingList[rowSelected-1].imgUrl;
        destinationVC.goalAgainst = standingList[rowSelected-1].goalAgainst;
        destinationVC.goal = standingList[rowSelected-1].goalScore;
        destinationVC.goalDifference = standingList[rowSelected-1].goal;
        
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
