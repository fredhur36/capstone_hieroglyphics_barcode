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

        view.backgroundColor = UIColor.yellow
        
        // View for cameraShot button and storage button
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.red
        
        view.addSubview(bottomView)
        bottomView.bottomAnchor.constraint(equalTo : view.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant : 130).isActive = true
        
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
        let recognizeViewController = RecognizeViewController(index: 0)
        let registerViewController = RegisterViewController(index : 1)
        let pagingViewController = FixedPagingViewController(viewControllers: [recognizeViewController, registerViewController])
        let parchment = pagingViewController.view!
        
        
        view.addSubview(parchment)
        view.constrainToEdges(parchment)
        // Add created view controllers
        addChildViewController(pagingViewController)
        pagingViewController.didMove(toParentViewController: self)
        
        /*
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pagingViewController.view.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        
        pagingViewController.view.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
        pagingViewController.view.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
        */
        
        
        //move parchment to the bottom
        pagingViewController.collectionView.topAnchor.constraint(equalTo:pagingViewController.view.topAnchor).isActive = false
        pagingViewController.collectionView.bottomAnchor.constraint(equalTo:bottomView.topAnchor).isActive = true
        
        pagingViewController.view.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = false
        pagingViewController.view.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = false
        
        pagingViewController.pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pagingViewController.pageViewController.view.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = false
        pagingViewController.view.backgroundColor = .green
        
        pagingViewController.pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pagingViewController.pageViewController.view.topAnchor.constraint(equalTo : view.topAnchor).isActive = true
        pagingViewController.pageViewController.view.bottomAnchor.constraint(equalTo : pagingViewController.collectionView.topAnchor).isActive = true
        pagingViewController.pageViewController.view.leadingAnchor.constraint(equalTo : view.leadingAnchor).isActive = true
        pagingViewController.pageViewController.view.trailingAnchor.constraint(equalTo : view.trailingAnchor).isActive = true
        //pagingViewController.pageViewcontroller.auto
        
        
        /*
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false

        pagingViewController.view.bottomAnchor.constraint(equalTo : view.bottomAnchor).isActive = false
        pagingViewController.view.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        pagingViewController.view.leadingAnchor.constraint(equalTo : view.leadingAnchor).isActive = true
        pagingViewController.view.trailingAnchor.constraint(equalTo : view.trailingAnchor).isActive = true
        pagingViewController.view.topAnchor.constraint(equalTo : view.topAnchor).isActive = true
*/
        /*
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
        */
    }
    
    
}
