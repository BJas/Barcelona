//
//  TestViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 13.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TestViewController: IndicatorViewController {
    
    var newList : Array<Test> = []
    var answers: [Answer] = []
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var dictKey = 0;
    var btnTag = 0;
    var t = 0;
    var rightAnswers = 0;
    @IBOutlet weak var questionLabrl: UILabel!
    
    @IBOutlet weak var TestView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Defs.reveal(self, menuButton: self.menuButton)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 165/255, green: 0, blue: 62/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.activityIndicatorBegin()
        //Firebase
        
        var rootRef: DatabaseReference! = nil
        rootRef = Database.database().reference()
        
        let itemsRef = rootRef.child("tests")
        itemsRef.observe(DataEventType.value, with: { (snapshot) in

            for test in snapshot.children.allObjects as![DataSnapshot] {
                let testObject = test.value as? [String: AnyObject]
                let quest = testObject?["question"] as? String ?? ""
                let answer = testObject?["rightAnswer"] as? String ?? ""
                let testId = testObject?["id"] as! Int
                let first = testObject?["firstVariant"] as? String ?? ""
                let second = testObject?["secondVariant"] as? String ?? ""
                let third = testObject?["thirdVariant"] as? String ?? ""
                let fourth = testObject?["fourthVariant"] as? String ?? ""
                let newArr = [first, second, third, fourth]
                self.newList.append( Test(question: quest, answer: answer, variantArr: newArr, id: testId))
            }
            self.activityIndicatorEnd()
            self.getTest()
        }) { (error) in
            print(error.localizedDescription)
        }
        
        TestView.layer.cornerRadius = 8
        
        // Do any additional setup after loading the view.
    }
    
    @objc func getTest () {
        questionLabrl.text = String(describing: newList[dictKey].question)
        
        btnTag = 0;
        var btnY = CGFloat(0.0);
        t = newList[dictKey].variantArr.count;
        for variant in newList[dictKey].variantArr {
            let button = UIButton(frame: CGRect(x: 0.05*self.view.frame.size.width, y: 0.45*self.view.frame.size.height + btnY, width: 0.9*self.view.frame.size.width, height: 0.1*self.view.frame.size.height));
            button.tag = btnTag;
            button.layer.cornerRadius = 8
            button.backgroundColor = UIColor(red: 0/255,green: 77/255,blue: 152/255,alpha:1);
            button.tintColor = UIColor.white
            button.titleLabel!.font =  UIFont(name: "Futura-Bold", size: 16);
            button.setTitle(String(describing: variant), for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            btnTag += 1;
            btnY += 0.1*self.view.frame.size.height + 15.0;
            self.view.addSubview(button);
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
       let answer = Answer.form(randomQuestion: newList[dictKey].question, chosenAnswer: newList[dictKey].variantArr[sender.tag], rightAnswer: newList[dictKey].answer)
        answers.append(answer)
            if(String(describing: newList[dictKey].variantArr[sender.tag]) == String(describing: newList[dictKey].answer)){
             sender.backgroundColor = UIColor.green
            rightAnswers += 1;
        }
        else {
            sender.backgroundColor = UIColor.red
        }
        
        if(dictKey == newList.count-1)
        {
            var timerEnd = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(getEnd), userInfo: nil, repeats: false)
        }
        else
        {
            var timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(getTest), userInfo: nil, repeats: false)
                self.dictKey += 1;
            
        }
    }
    
    @objc func getEnd() {
    let secondV = storyboard?.instantiateViewController(withIdentifier: "answerVC")  as! AnswerViewController; navigationController!.pushViewController(secondV, animated: true)
    secondV.rightAnswer = rightAnswers
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
