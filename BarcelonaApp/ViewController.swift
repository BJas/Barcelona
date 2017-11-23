//
//  ViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 18.10.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: IndicatorViewController,  UITableViewDelegate,UITableViewDataSource {
    var rootRef: DatabaseReference! = nil
    @IBOutlet weak var tableView: UITableView!
    var newsList:Array<News> = [];
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor.clear;
        Defs.reveal(self, menuButton: self.menuButton)
        
        //Activity Indicator
        self.activityIndicatorBegin()
        //Firebase
        rootRef = Database.database().reference()
        let itemsRef = rootRef.child("news")
        
        itemsRef.observe(DataEventType.value, with: { (snapshot) in
        self.newsList.removeAll()
        for news in snapshot.children.allObjects as![DataSnapshot] {
            let newsObject = news.value as? [String: AnyObject]
            let newsTitle = newsObject?["title"] as? String ?? ""
            let newsImgUrl = newsObject?["imgUrl"] as? String ?? ""
            let newsDesc = newsObject?["description"] as? String ?? ""
            let newsDate = newsObject?["date"] as? String ?? ""
            let newsId = newsObject?["id"] as? String ?? ""
            self.newsList.append(News(id: newsId, title: newsTitle, imgUrl: newsImgUrl, description: newsDesc, date: newsDate))
        }
        self.newsList.reverse()
        self.tableView.reloadData()
        self.activityIndicatorEnd()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell
        cell?.newsDate.text = newsList[indexPath.row].date
        cell?.newsTitle.text = newsList[indexPath.row].title
        let url = URL(string: newsList[indexPath.row].imgUrl)
        let data = try? Data(contentsOf: url!)
        cell?.newsImageView.image = UIImage(data: data!)
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showNewsDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let rowSelected = (sender as! NSIndexPath).row
        let url = URL(string: newsList[rowSelected].imgUrl)
        let data = try? Data(contentsOf: url!)
        let destinationVC = segue.destination as! NewsDetailViewController
        destinationVC.newsImg = UIImage(data: data!)
        destinationVC.newsDescription = newsList[rowSelected].description
        destinationVC.newsTitle = newsList[rowSelected].title
        destinationVC.newsDate = newsList[rowSelected].date
        destinationVC.id = newsList[rowSelected].id
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

