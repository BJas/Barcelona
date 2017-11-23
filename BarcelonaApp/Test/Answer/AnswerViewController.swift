//
//  AnswerViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 14.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
   
    var rightAnswer = 0
    
    @IBOutlet weak var titleTableLabel: UILabel!
    @IBOutlet weak var answerTableView: UIView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);
        var title = ""
        if (rightAnswer < 5) {
            title = "Пробуй еще!"
        } else if (rightAnswer < 9) {
            title = "Ты хорош"
        }
        else {
            title = "Ты великолепен"
        }
        titleTableLabel.text = title + "\n" + "Твой результат: " + String(rightAnswer)
        answerTableView.layer.cornerRadius = 8
        // Do any additional setup after loading the view.
    }
    
    @IBAction func testAgain(_ sender: UIButton) {
        let vc : TestViewController = storyboard?.instantiateViewController(withIdentifier: "TestViewController")  as! TestViewController
        vc.newList = []
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated: true, completion: nil)
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
