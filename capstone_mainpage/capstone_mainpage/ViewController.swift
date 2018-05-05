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

        view.backgroundColor = UIColor.blue
        
        //add Horizontal StackView
        //let StackView = UIStackView()
        //StackView.axis = .vertical
        //StackView.distribution = .fill
        //StackView.backgroundColor = UIColor.red
        //view.addSubview(StackView)
        //StackView.translatesAutoresizingMaskIntoConstraints =
        //StackView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        //StackView.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
        //StackView.heightAnchor.constraint(equalTo:view.heightAnchor).isActive = true
        //StackView.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
        
        // Put camera here
        let cameraScreen = UIView()
        cameraScreen.backgroundColor = UIColor.gray
        
        let label = UILabel(frame :.zero)
        label.text = "cameraScreen"
        label.textColor = UIColor.white
        label.sizeToFit()
        
        cameraScreen.addSubview(label)
        cameraScreen.constrainCentered(label)
        //cameraScreen.constrainCentered(label)
        //cameraScreen.constrainToEdges(view)
        //View for cameraShotButton and storageButton
        cameraScreen.translatesAutoresizingMaskIntoConstraints = false
        
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.red
        
        let label2 = UILabel()
        label2.text = "bottomView"
        bottomView.addSubview(label2)
        bottomView.constrainCentered(label2)
        
        let cameraShotButton = UIButton()
        cameraShotButton.backgroundColor = UIColor.white
        cameraShotButton.clipsToBounds = true

        let storageButton = UIButton()
        storageButton.setTitle("Storage", for : .normal)
        storageButton.backgroundColor = UIColor.white
        storageButton.clipsToBounds = false

        // parchment
        // Create two view controllers and pass them to pagingViewcontroller.
        let viewControllers = (0...1).map { MainViewController(index: $0) }
        let pagingViewController = FixedPagingViewController(viewControllers: viewControllers)
        //let parchment = pagingViewController.view!
        
        
        view.addSubview(cameraScreen)
        
        /*
        view.addSubview(parchment)
        view.addSubview(bottomView)
        view.addSubview(cameraShotButton)
        view.addSubview(storageButton)
         */
        // Add created view controllers
        addChildViewController(pagingViewController)
        
        //StackView.addArrangedSubview(cameraScreen)
        cameraScreen.topAnchor.constraint(equalTo : view.topAnchor).isActive = true
        cameraScreen.widthAnchor.constraint(equalTo : view.widthAnchor).isActive = true
        cameraScreen.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        /*
        //StackView.addArrangedSubview(parchment)
        parchment.topAnchor.constraint(equalTo:cameraScreen.bottomAnchor).isActive = true
        //StackView.addArrangedSubview(bottomView)
        bottomView.topAnchor.constraint(equalTo:parchment.bottomAnchor).isActive = true
        
        */

        

        //view.addSubview(pagingViewController.view)
        //view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParentViewController: self)
    }
    
    
}
