//
//  CommentAddViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 14.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase
import UITextView_Placeholder

class CommentAddViewController: UIViewController {
    
    var id : String = ""
    var name = ""
    var commentDesc = ""
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var commentText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        commentText.placeholder = "Ваш комментарий"
        commentText.placeholderColor = UIColor.lightGray
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(title: "Отправить", style: .plain, target: self, action: #selector(addComment))
        
        // Do any additional setup after loading the view.
    }
    
    @objc func addComment(sender: UIBarButtonItem!) {
        if (nameLabel.text != "" && commentText.text != ""){
            let d = Date()
            let df = DateFormatter()
            df.dateFormat = "y-MM-dd H:m"
            let date = df.string(from: d)
            var rootRef: DatabaseReference! = nil
            name = nameLabel.text!;
            commentDesc = commentText.text;
            rootRef = Database.database().reference()
            let itemsRef = rootRef.child("news")
            let key = itemsRef.child("comments").childByAutoId().key;
            itemsRef.child(id).child("comments").child(key).setValue(["id": key, "name" : name,"commentDesc" : commentDesc, "date": date])
        
         self.navigationController?.popViewController(animated: true)
            
            nameLabel.text = "";
            commentText.text = "";
        }
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
