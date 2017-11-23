//
//  MatchViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 17.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseDatabase

class MatchViewController: IndicatorViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var matchTableView: UITableView!
    var rootRef: DatabaseReference! = nil
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var teamEng = ""
    var matchListFinished: Array<Match> = []
    var matchListTimed: Array<Match> = []
    var standingTeam = [String: String]()
    var standingTeamImg = [String: String]()

    @IBOutlet weak var changeMenu: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Defs.reveal(self, menuButton: self.menuButton)
        
        //Activity Indicator
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
        Alamofire.request("http://api.football-data.org/v1/teams/81/fixtures").responseJSON{
            response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let innerDict = dict["fixtures"] as? [[String: Any]]{
                    for item in innerDict{
                        var homeTeam = "";
                        var awayTeam = "";
                        var homeImg = "";
                        var awayImg = "";
                        var homeGoal = 0;
                        var awayGoal = 0;
                        var competation = "";
                        for (teamInEnglish, teamInRussian) in self.standingTeam {
                            if(item["homeTeamName"] as? String == teamInEnglish) {
                                homeTeam = teamInRussian
                                break;
                            }
                        }
                        
                        for (teamInEnglish, teamInRussian) in self.standingTeam {
                            if(item["awayTeamName"] as? String == teamInEnglish){
                                awayTeam = teamInRussian
                                break;
                            }
                        }
                        
                        for (teamName, teamImg) in self.standingTeamImg{
                            if(item["homeTeamName"] as? String == teamName) {
                                homeImg = teamImg
                                break;
                            }
                        }
                        
                        for (teamName, teamImg) in self.standingTeamImg{
                            if(item["awayTeamName"] as? String == teamName){
                                awayImg = teamImg
                                break;
                            }
                        }
                        
                        if(homeTeam == "Ювентус" || awayTeam == "Ювентус" ||
                            homeTeam == "Спортинг" || awayTeam == "Спортинг" ||
                            homeTeam == "Олимпиакос" || awayTeam == "Олимпиакос"){
                            competation = "Лига Чемпионов"
                        }
                        else {
                            competation = "Ла Лига"
                        }
                        
                        let matchday = item["matchday"] as? Int;
                        let status = item["status"] as? String;
                        let date = item["date"] as? String;
                        
                        
                        if(status == "FINISHED"){
                            if let goals = item["result"] as? Dictionary<String, AnyObject> {
                                homeGoal = (goals["goalsHomeTeam"] as? Int)!;
                                awayGoal = (goals["goalsAwayTeam"] as? Int)!;
                            }; self.matchListFinished.append(Match(matchday: matchday!, competation: competation, date: date!, status: status!, homeTeam: homeTeam, awayTeam: awayTeam, homeGoal: homeGoal, awayGoal: awayGoal, homeImg: homeImg, awayImg: awayImg))
                        }
                        else {
                            self.matchListTimed.append(Match(matchday: matchday!, competation: competation, date: date!, status: status!, homeTeam: homeTeam, awayTeam: awayTeam, homeGoal: homeGoal, awayGoal: awayGoal, homeImg: homeImg, awayImg: awayImg))
                        }
                    }
                }
            }
            self.matchListFinished.reverse()
            self.activityIndicatorEnd()
            self.matchTableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        
        switch changeMenu.selectedSegmentIndex{
        case 0:
            returnValue = matchListFinished.count
            break
        case 1:
            returnValue = matchListTimed.count
            break
        default:
            break
        }
        return returnValue
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell") as! MatchTableViewCell
        
        switch changeMenu.selectedSegmentIndex {
        case 0:
            let finishedDate = String(matchListFinished[indexPath.row].date).dropLast(4)
            let date = finishedDate.components(separatedBy: "T")
            let finishedMonth = date[0]
            let finishedHour = date[1]
            
            cell.resultLabel.attributedText = getFinishedResult(img: matchListFinished[indexPath.row].homeImg, img2: matchListFinished[indexPath.row].awayImg, homeGoal: matchListFinished[indexPath.row].homeGoal, awayGoal: matchListFinished[indexPath.row].awayGoal, date: finishedMonth)
            
            cell.teamLabel.text =  matchListFinished[indexPath.row].homeTeam + "  -"
            cell.awayLabel.text =  "  " +  matchListFinished[indexPath.row].awayTeam
            cell.dateLabel.text = finishedMonth + " " + finishedHour + " | Тур " + String(matchListFinished[indexPath.row].matchday) + " | " + matchListFinished[indexPath.row].competation
            break
        case 1:
            let timedDate = String(matchListTimed[indexPath.row].date).dropLast(4)
            let futureDate = timedDate.components(separatedBy: "T")
            let timedMonth = futureDate[0]
            let timedHour = futureDate[1]
            
            cell.resultLabel.attributedText = getFinishedResult(img: matchListTimed[indexPath.row].homeImg, img2: matchListTimed[indexPath.row].awayImg, homeGoal: matchListTimed[indexPath.row].homeGoal, awayGoal: matchListTimed[indexPath.row].awayGoal, date: timedMonth)
            cell.teamLabel.text = matchListTimed[indexPath.row].homeTeam + "  -"
            cell.awayLabel.text = "  " + matchListTimed[indexPath.row].awayTeam
            cell.dateLabel.text = timedMonth + " " + timedHour + " | Тур " + String(matchListTimed[indexPath.row].matchday) + " | " + matchListTimed[indexPath.row].competation
            break
        default:
            break
        }
        return cell
    }
    
    func getFinishedResult(img: String, img2: String, homeGoal: Int, awayGoal: Int, date: String)-> NSMutableAttributedString {
        let url = URL(string: img)
        let data = try? Data(contentsOf: url!)
        let fullString = NSMutableAttributedString(string: "")
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = UIImage(data: data!)
        image1Attachment.bounds = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
        let image1String = NSAttributedString(attachment: image1Attachment)
        
        let url2 = URL(string: img2)
        let data2 = try? Data(contentsOf: url2!)
        let image2Attachment = NSTextAttachment()
        image2Attachment.image = UIImage(data: data2!)
        image2Attachment.bounds = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
        let image2String = NSAttributedString(attachment: image2Attachment)
        
        let result = "  " + String(homeGoal) + ":"+String(awayGoal) + "  "
        let resultLabelText = NSMutableAttributedString(string: result)
        let month = date.dropFirst(5).components(separatedBy: "-")
        let dateText = NSMutableAttributedString(string: " " + month[1] + "." + month[0] + " ")
        fullString.append(image1String)
        switch changeMenu.selectedSegmentIndex {
        case 0:
            fullString.append(resultLabelText)
            break
        case 1:
            fullString.append(dateText)
            break
        default:
            break
        }
        fullString.append(image2String)
        return fullString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refreshData(_ sender: Any) {
        matchTableView.reloadData()
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
