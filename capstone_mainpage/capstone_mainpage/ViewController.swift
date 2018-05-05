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
        
        
        // View for cameraShot button and storage button
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.red
        
        view.addSubview(bottomView)
        bottomView.bottomAnchor.constraint(equalTo : view.bottomAnchor).isActive = true
        bottomView.widthAnchor.constraint(equalTo:view.widthAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant : 100).isActive = true
        
        // Camera Shot Button and Storage Button
        let cameraShotButton = UIButton(type : .custom)
        cameraShotButton.backgroundColor = UIColor.green
        cameraShotButton.clipsToBounds = true
        bottomView.addSubview(cameraShotButton)
        
        cameraShotButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        cameraShotButton.centerYAnchor.constraint(equalTo : bottomView.centerYAnchor).isActive = true
        cameraShotButton.sizeToFit()
        
        let storageButton = UIButton(type : .custom)
        storageButton.setTitle("Storage", for : .normal)
        storageButton.setTitleColor(UIColor.black, for: .normal)
        storageButton.backgroundColor = UIColor.white
        storageButton.clipsToBounds = false
        bottomView.addSubview(storageButton)
        
        storageButton.rightAnchor.constraint(equalTo : bottomView.rightAnchor, constant : -20).isActive = true
        storageButton.centerYAnchor.constraint(equalTo : bottomView.centerYAnchor).isActive = true
        storageButton.sizeToFit()
        
        
        cameraShotButton.translatesAutoresizingMaskIntoConstraints = false
        storageButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // parchment
        // Create two view controllers and pass them to pagingViewcontroller.
        let viewControllers = (0...1).map { MainViewController(index: $0) }
        let pagingViewController = FixedPagingViewController(viewControllers: viewControllers)
        let parchment = pagingViewController.view!
        
        view.addSubview(parchment)
        parchment.bottomAnchor.constraint(equalTo:bottomView.topAnchor).isActive = true
        parchment.heightAnchor.constraint(equalToConstant : 40).isActive = true
        parchment.translatesAutoresizingMaskIntoConstraints = false
        
        // Add created view controllers
        addChildViewController(pagingViewController)
        pagingViewController.didMove(toParentViewController: self)
        
        
        
        // Put camera here
        let cameraScreen = UIView()
        cameraScreen.backgroundColor = UIColor.gray
        
        let label = UILabel(frame :.zero)
        label.text = "cameraScreen"
        label.textColor = UIColor.white
        label.sizeToFit()
        
        cameraScreen.addSubview(label)
        cameraScreen.constrainCentered(label)
        cameraScreen.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cameraScreen)
        cameraScreen.topAnchor.constraint(equalTo : view.topAnchor).isActive = true
        cameraScreen.widthAnchor.constraint(equalTo : view.widthAnchor).isActive = true
        cameraScreen.bottomAnchor.constraint(equalTo : parchment.topAnchor).isActive = true
        
        
        
        
       
       
 
        
        
        //StackView.addArrangedSubview(cameraScreen)
        
       
        
        
        //StackView.addArrangedSubview(parchment)

        //StackView.addArrangedSubview(bottomView)

        

        //view.addSubview(pagingViewController.view)
        //view.constrainToEdges(pagingViewController.view)
        
    }
    
    
}
