//
//  IndicatorViewController.swift
//  BarcelonaApp
//
//  Created by Apple on 23.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class IndicatorViewController: UIViewController {
    
    var myActivityIndicator: NVActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func activityIndicatorBegin() {
        myActivityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width/2-15, y: self.view.frame.height/2-15, width: 30, height: 30))
        myActivityIndicator?.color =  UIColor.init(red: 165/255, green: 0/255, blue: 68/255, alpha: 1)
        myActivityIndicator?.type = .lineSpinFadeLoader
        myActivityIndicator?.startAnimating()
        view.addSubview(myActivityIndicator!)
        
    }
    
    func activityIndicatorEnd() {
        myActivityIndicator?.stopAnimating()
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
