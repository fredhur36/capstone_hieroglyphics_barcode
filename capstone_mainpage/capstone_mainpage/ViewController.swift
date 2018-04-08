//
//  ViewController.swift
//  capstone_mainpage
//
//  Created by Hyelee Lee on 2018. 4. 8..
//  Copyright © 2018 Hyelee Lee. All rights reserved.
//

import UIKit
import Parchment

// Create two  view controllers, one is for 'registration of sticker' and the other for 'recognizing sticker',
// and pass them into our paging view controller.
// FixedPagingViewController is a subclass of PagingViewController for fixed number of views.
// It creates a data source that manages setting up paging items and displaying view controller titles.

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create two view controllers and pass them to pagingViewcontroller.
        let viewControllers = (0...2).map { MainViewController(index: $0) }
        let pagingViewController = FixedPagingViewController(viewControllers: viewControllers)
        
        // Add created view controllers
        addChildViewController(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParentViewController: self)
    }
    
}
