//
//  StatisticsViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 15.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class StatisticsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, IndicatorInfoProvider {
    var standingDetailsList:Array<StandingDetails> = [];
    var newList = [[]]
    let headers = ["Общая", "Дома", "В гостях"]
    @IBOutlet weak var statisticsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...2 {
        newList[i].append(standingDetailsList[i].wins)
        newList[i].append(standingDetailsList[i].draws)
        newList[i].append(standingDetailsList[i].losses)
        newList[i].append(standingDetailsList[i].goal)
        newList[i].append(standingDetailsList[i].goalAgain)
        newList[i].append(standingDetailsList[i].goalDifference)
        }
        statisticsTableView.reloadData()
        statisticsTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
//    
//    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
//        return IndicatorInfo(title: "Статистика")
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return newList.count
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return newList[section].count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "statisticsCell", for: indexPath) as? StatisticsTableViewCell
//        if (indexPath.row % 6 == 0) {
//            cell?.titleLabel.text = "Победа";
//        } else if (indexPath.row % 6 == 1) {
//            cell?.titleLabel.text = "Ничья";
//        } else if (indexPath.row % 6 == 2) {
//            cell?.titleLabel.text = "Поражения";
//        } else if (indexPath.row % 6 == 3) {
//            cell?.titleLabel.text = "Забитые голы";
//        } else if (indexPath.row % 6 == 4) {
//            cell?.titleLabel.text = "Пропущенные голы";
//        } else if (indexPath.row % 6 == 5) {
//            cell?.titleLabel.text = "Разница мячей";
//        }
//        cell?.resultLabel.text = newList[indexPath.section][indexPath.row] as? String
//            return cell!
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section < headers.count {
//            return headers[section]
//        }
//        return nil
//    }
        
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
