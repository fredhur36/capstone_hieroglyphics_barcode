//
//  ViewController.swift
//  capstone_mainpage
//
//  Created by Hyelee Lee on 2018. 4. 8..
//  Copyright © 2018 Hyelee Lee. All rights reserved.
//

import UIKit
import Parchment
import AVFoundation

// Create two  view controllers, one is for 'registration of sticker' and the other for 'recognizing sticker',
// and pass them into our paging view controller.
// FixedPagingViewController is a subclƒass of PagingViewController for fixed number of views.
// It creates a data source that manages setting up paging items and displaying view controller titles.

class MainPageViewController: UIViewController {
    
   // let scanModeViewController :UIViewController?
    //let registerModeViewController : UIViewController?
    let pagingViewController : FixedPagingViewController
    var currentIndex : Int?
    var currentViewController : UIViewController?
    var photoOutput : AVCapturePhotoOutput?
    var image : UIImage?
    
    init(){
        pagingViewController = FixedPagingViewController(viewControllers: [CameraViewController(index: 0, name : "scan"), CameraViewController(index: 1, name : "reigster")])
        
        //scanModeViewController = ScanModeViewController(index: 0)
        //registerModeViewController = RegisterModeViewController(index : 1)
        //pagingViewController = FixedPagingViewController(viewControllers: viewControllers)
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View for cameraShot button and storage button
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.yellow
        
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.bottomAnchor.constraint(equalTo : view.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant : 130).isActive = true
        
        
        // Camera Shot Button and Storage Button
        //Need to change the camera button image
        let cameraShotButton = UIButton(type : .custom)
        cameraShotButton.backgroundColor = UIColor.black
        cameraShotButton.clipsToBounds = true
        
        bottomView.addSubview(cameraShotButton)
        cameraShotButton.translatesAutoresizingMaskIntoConstraints = false
        cameraShotButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        cameraShotButton.centerYAnchor.constraint(equalTo : bottomView.centerYAnchor).isActive = true
        cameraShotButton.sizeToFit()
        
        /*
        let storageButton = UIButton(type : .custom)
        storageButton.setTitle("Storage", for : .normal)
        storageButton.setTitleColor(UIColor.black, for: .normal)
        storageButton.backgroundColor = UIColor.white
        storageButton.clipsToBounds = false
        
        bottomView.addSubview(storageButton)
        storageButton.translatesAutoresizingMaskIntoConstraints = false
        storageButton.rightAnchor.constraint(equalTo : bottomView.rightAnchor, constant : -20).isActive = true
        storageButton.centerYAnchor.constraint(equalTo : bottomView.centerYAnchor).isActive = true
        storageButton.sizeToFit()
        */
        
        
        // parchment
        // Create two view controllers and pass them to pagingViewcontroller.
        
        
        let parchment = pagingViewController.view!
        view.addSubview(parchment)
        view.constrainToEdges(parchment)
        
        // Add created view controllers
        addChildViewController(pagingViewController)
        pagingViewController.didMove(toParentViewController: self)
        
        //move parchment to the bottom
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pagingViewController.view.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = false
        pagingViewController.view.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = false
        pagingViewController.view.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = false
        pagingViewController.view.bottomAnchor.constraint(equalTo:bottomView.bottomAnchor, constant: -130).isActive = true
        
        //pagingViewController.state.currentPagingItem
        
        cameraShotButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        }
    
    @objc func buttonAction(_ sender : UIButton!){
        print("Button tapped")
        currentIndex = pagingViewController.state.currentPagingItem!.index
        
        if let p = pagingViewController.viewControllers[currentIndex!] as? CameraViewController {
            photoOutput = p.photoOutput
        }
        /*
        else {
            // Need to change into register later
            currentViewController = pagingViewController.viewControllers[currentIndex!] as! ScanModeViewController
            //photoOutput = currentViewController.photoOuput
        }*/

        //photoOutput = pagingViewController.viewControllers[currentIndex!].photoOutput
        let setting = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: setting, delegate: self)
 }

}

extension MainPageViewController : AVCapturePhotoCaptureDelegate{
    func photoOutput(_ ouput: AVCapturePhotoOutput, didFinishProcessingPhoto photo : AVCapturePhoto, error: Error?){
        if let imageData = photo.fileDataRepresentation(){
            image = UIImage(data : imageData)
            print(image)
            //show the image
        }
    }
    
}
