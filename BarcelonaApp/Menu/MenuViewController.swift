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
        let sw = storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        let navigationController: UINavigationController?
    
        self.view.window?.rootViewController = sw
        switch segue.identifier {
        case "showMain"?:
            let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            navigationController = UINavigationController(rootViewController: destinationController)
            getStyleNavigation(navigationController: navigationController!)
            sw.pushFrontViewController(navigationController, animated: true)
        case "showMatch"?:
            let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "MatchViewController") as! MatchViewController
            navigationController = UINavigationController(rootViewController: destinationController)
            getStyleNavigation(navigationController: navigationController!)
            sw.pushFrontViewController(navigationController, animated: true)
        case "showTable"?:
            let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "StandingViewController") as! StandingViewController
            navigationController = UINavigationController(rootViewController: destinationController)
            getStyleNavigation(navigationController: navigationController!)
            sw.pushFrontViewController(navigationController, animated: true)
        case "showTeam"?:
            let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "TeamViewController") as! TeamViewController
            navigationController = UINavigationController(rootViewController: destinationController)
            getStyleNavigation(navigationController: navigationController!)
            sw.pushFrontViewController(navigationController, animated: true)
        case "showTest"?:
            
            let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
            navigationController = UINavigationController(rootViewController: destinationController)
            getStyleNavigation(navigationController: navigationController!)
            sw.pushFrontViewController(navigationController, animated: true)
        default:
            break;
        }
    }
    
    func getStyleNavigation(navigationController: UINavigationController) {
        navigationController.navigationBar.barTintColor = UIColor(red: 165/255, green: 0, blue: 68/255, alpha: 1)
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
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
