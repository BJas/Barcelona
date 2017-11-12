//
//  NewsDetailViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 18.10.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NewsDetailViewController: UIViewController, UITableViewDelegate,UITableViewDataSource  {
    
    var newsTitle: String?
    var newsDate: String?
    var newsImg: UIImage?
    var newsDescription: String?
    var id: String?
    var newsComment: [[String?]] = []

    @IBOutlet weak var newsDetailTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsComment.count+2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : NewsDetailTableViewCell?
        if(indexPath.row == 0) {
        cell = tableView.dequeueReusableCell(withIdentifier: "firstNewsCell", for: indexPath) as? NewsDetailTableViewCell
        cell?.titleLabel.text = newsTitle;
        cell?.dateLabel.text = newsDate;
        cell?.newsImage.image = newsImg;
        cell?.descriptionLabel.text = newsDescription;
        cell?.preservesSuperviewLayoutMargins = false
        cell?.separatorInset = UIEdgeInsets.zero
        cell?.layoutMargins = UIEdgeInsets.zero
        }
        else if (indexPath.row == 1){
            var cellComment : NewsDetailCommentTableViewCell?
            cellComment = tableView.dequeueReusableCell(withIdentifier: "secondNewsCell", for: indexPath) as? NewsDetailCommentTableViewCell
            cellComment?.commentTitle.text = "Oставить комментарий";
            cellComment?.nameField.placeholder = "Имя";
            let myColor : UIColor = UIColor.init(red: 0/255, green: 77/255, blue: 152/255, alpha: 1)
            cellComment?.nameField.layer.borderWidth = 1.0
            cellComment?.nameField.layer.borderColor = myColor.cgColor
            cellComment?.nameField.layer.cornerRadius = 2.0;
            
            cellComment?.descriptionField.backgroundColor = UIColor.init(red: 69/255, green: 150/255, blue: 228/255, alpha: 1)
            cellComment?.descriptionField.textColor = UIColor.white;
            cellComment?.descriptionField.layer.cornerRadius = 4.0;
            cellComment?.preservesSuperviewLayoutMargins = false
            cellComment?.separatorInset = UIEdgeInsets.zero
            cellComment?.layoutMargins = UIEdgeInsets.zero
            cellComment?.id = id!;
            
            return cellComment!;
        }
        else {
            var cellCommentView : NewsDetailCommentViewTableViewCell?
            cellCommentView = tableView.dequeueReusableCell(withIdentifier: "commentViewCell", for: indexPath) as? NewsDetailCommentViewTableViewCell
            if(indexPath.row%2 == 1) {
                cellCommentView?.backgroundColor = UIColor.init(red: 0/255, green: 77/255, blue: 152/255, alpha: 1)
            }
            else {
                cellCommentView?.backgroundColor = UIColor.init(red: 165/255, green: 0, blue: 68/255, alpha: 1)
            }
            cellCommentView?.preservesSuperviewLayoutMargins = false
            cellCommentView?.separatorInset = UIEdgeInsets.zero
            cellCommentView?.layoutMargins = UIEdgeInsets.zero
            cellCommentView?.nameLabel.text = newsComment[indexPath.row-2][0]
            cellCommentView?.commentDescLabel.text = newsComment[indexPath.row-2][1]
            return cellCommentView!;
        }
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("+++")
        newsComment.removeAll()
        var rootRef: DatabaseReference! = nil
        rootRef = Database.database().reference()
        let itemsRef = rootRef.child("news").child(id!).child("comments")
        itemsRef.observe(DataEventType.value, with: { (snapshot) in
            for comments in snapshot.children.allObjects as![DataSnapshot] {
                let newsObject = comments.value as? [String: AnyObject]
                let commentName = newsObject?["name"] as? String ?? ""
                let commentDesc = newsObject?["commentDesc"] as? String ?? ""
                self.newsComment.append([commentName, commentDesc])
            }
            self.newsComment.reverse()
            self.newsDetailTableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
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
