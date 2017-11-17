//
//  TeamMenu.swift
//  BarcelonaApp
//
//  Created by Apple on 15.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TeamMenu: ButtonBarPagerTabStripViewController  {
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [ProfileViewController(), StatisticsViewController()]
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
