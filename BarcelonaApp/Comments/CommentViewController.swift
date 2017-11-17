//
//  CommentViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 14.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var newsComment: [[String?]] = []
    var comment = true
    var id: String = ""
    @IBOutlet weak var commentTableVIew: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.compose, target: self, action: #selector(addCommentVC));
        var rootRef: DatabaseReference! = nil
        rootRef = Database.database().reference()
        let itemsRef = rootRef.child("news").child(id).child("comments")
        itemsRef.observe(DataEventType.value, with: { (snapshot) in
            self.newsComment.removeAll()
            for comments in snapshot.children.allObjects as![DataSnapshot] {
                let newsObject = comments.value as? [String: AnyObject]
                let commentName = newsObject?["name"] as? String ?? ""
                let commentDesc = newsObject?["commentDesc"] as? String ?? ""
                let commentDate = newsObject?["date"] as? String ?? ""
                self.newsComment.append([commentName, commentDesc, commentDate])
            }
            self.newsComment.reverse()
            if (self.newsComment.count == 0) {
                self.comment = false
                self.newsComment.append(["Нет комментариев"])
            }
            else {
                self.comment = true
            }
            self.commentTableVIew.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
        
        // Do any additional setup after loading the view.
    }
    
    @objc func addCommentVC(sender: UIBarButtonItem!) {
        let commentVC = storyboard?.instantiateViewController(withIdentifier: "commentAddVC")  as! CommentAddViewController; navigationController!.pushViewController(commentVC, animated: true)
        commentVC.id = id;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsComment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentTableViewCell
        if (!comment) {
            cell?.dateLabel.text = ""
            cell?.titleLabel.text = ""
            cell?.descLabel.text = newsComment[0][0]
            cell?.descLabel.textAlignment = .center
            commentTableVIew.separatorColor = UIColor.clear
        }
        else {
            cell?.descLabel.textAlignment = .left
            commentTableVIew.separatorColor = UIColor.lightGray
            commentTableVIew.tableFooterView = UIView()
            cell?.titleLabel.text = newsComment[indexPath.row][0]
            cell?.descLabel.text = newsComment[indexPath.row][1]
            cell?.dateLabel.text = newsComment[indexPath.row][2]
        }
        return cell!
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
