//
//  Defs.swift
//  BarcelonaApp
//
//  Created by Apple on 22.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import UIKit

final class Defs {
    
    static func reveal(_ viewController: UIViewController, menuButton: UIBarButtonItem) {
        let revealViewController = viewController.revealViewController()
        if ( revealViewController != nil ) {
            menuButton.target = viewController.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            viewController.view.addGestureRecognizer(viewController.revealViewController().panGestureRecognizer())
             viewController.view.addGestureRecognizer(viewController.revealViewController().tapGestureRecognizer())
        }
    }
}

