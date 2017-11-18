//
//  ViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 18.10.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase
import NVActivityIndicatorView

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var rootRef: DatabaseReference! = nil
    @IBOutlet weak var tableView: UITableView!
    var newsList:Array<News> = [];
    
    var menuVC : MenuViewController!
    
    @IBAction func menuAction(_ sender: UIBarButtonItem) {
        
        if(AppDelegate.menuBool) {
            showMenu()
        } else {
            closeMenu()
        }
    }
    
    func showMenu() {
        self.menuVC.view.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        UIView.animate(withDuration: 0.3) { ()->  Void in
            self.menuVC.view.frame = CGRect(x: 0, y: 63, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.addChildViewController(self.menuVC)
            self.view.addSubview(self.menuVC.view)
        AppDelegate.menuBool = false
        }
    }
    
    func closeMenu() {
        UIView.animate(withDuration: 0.3, animations: { ()-> Void in
            self.menuVC.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 63, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }){ (finished) in
            self.menuVC.view.removeFromSuperview()
        }
        AppDelegate.menuBool = true
    }
    
    @objc func respondToGosture(gesture: UISwipeGestureRecognizer){
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.right: showMenu()
        case UISwipeGestureRecognizerDirection.left: closeMenu()
        default:
            break;
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor.clear;
        menuVC = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGosture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGosture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        
        //Activity Indicator
        let myActivityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width/2-15, y: self.view.frame.height/2-15, width: 30, height: 30))
        myActivityIndicator.color =  UIColor.init(red: 165/255, green: 0/255, blue: 68/255, alpha: 1)
        myActivityIndicator.type = .lineSpinFadeLoader
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
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
        myActivityIndicator.stopAnimating()
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

