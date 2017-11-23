//
//  MenuViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 22.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let menuItems = ["titleCell","mainCell", "matchCell", "tableCell", "teamCell", "testCell"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = menuItems[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectionStyle = .none
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
                    case 0:
                        break;
                    case 1:
                        performSegue(withIdentifier: "showMain", sender: indexPath)
                    case 2:
                        performSegue(withIdentifier: "showMatch", sender: indexPath)
                    case 3:
                        performSegue(withIdentifier: "showTable", sender: indexPath)
                    case 4:
                        performSegue(withIdentifier: "showTeam", sender: indexPath)
                    case 5:
                        performSegue(withIdentifier: "showTest", sender: indexPath)
                    default:
                        break;
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let _ : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        switch segue.identifier {
        case "showMain"?:
            _ = segue.destination as?
            ViewController
        
//            nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//            self.present(nextViewController!, animated:true, completion:nil)
        case "showMatch"?:
            _ = segue.destination as? MatchViewController
        case "showTable"?:
            _ = segue.destination as? StandingViewController
        case "showTeam"?:
            _ = segue.destination as? TeamViewController
        case "showTest"?:
            _ = segue.destination as? TestViewController
        default:
            break;
        }
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
