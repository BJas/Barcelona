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

    @IBOutlet weak var showCommentButton: UIButton!
    @IBOutlet weak var newsDetailTableView: UITableView!
    
    
    @IBAction func showComment(_ sender: Any) {
        let commentVC = storyboard?.instantiateViewController(withIdentifier: "commentVC")  as! CommentViewController; navigationController!.pushViewController(commentVC, animated: true)
        commentVC.id = id!;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : NewsDetailTableViewCell?
        cell = tableView.dequeueReusableCell(withIdentifier: "firstNewsCell", for: indexPath) as? NewsDetailTableViewCell
        cell?.titleLabel.text = newsTitle;
        cell?.dateLabel.text = newsDate;
        cell?.newsImage.image = newsImg;
        cell?.descriptionLabel.text = newsDescription;
        cell?.preservesSuperviewLayoutMargins = false
        cell?.separatorInset = UIEdgeInsets.zero
        cell?.layoutMargins = UIEdgeInsets.zero
        
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Новость"
        getComment()
    }
    
    func getComment(){
        var rootRef: DatabaseReference! = nil
        rootRef = Database.database().reference()
        let itemsRef = rootRef.child("news").child(id!).child("comments")
        itemsRef.observe(DataEventType.value, with: { (snapshot) in
            self.showCommentButton.setTitle("Комментарий ("+String(snapshot.childrenCount)+")", for: .normal)
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
