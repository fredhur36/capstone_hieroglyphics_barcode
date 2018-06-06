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
import Firebase
import FirebaseStorage
// Create two  view controllers, one is for 'registration of sticker' and the other for 'recognizing sticker',
// and pass them into our paging view controller.
// FixedPagingViewController is a subclƒass of PagingViewController for fixed number of views.
// It creates a data source that manages setting up paging items and displaying view controller titles.

class MainPageViewController: UIViewController {
    
    let pagingViewController : FixedPagingViewController
    var currentIndex : Int?
    var currentViewController : UIViewController?
    var photoOutput : AVCapturePhotoOutput?
    var image : UIImage?
    var imageToSend: NSData!
    var nextView : cameraController!  
    init(){
        pagingViewController = FixedPagingViewController(viewControllers: [CameraViewController(index: 0, name : "scan"), CameraViewController(index: 1, name : "register")])
        nextView = cameraController()

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
            if(currentIndex == 0 ){
                
                imageToSend = UIImageJPEGRepresentation(image!, 0.8)! as NSData
                uploadImagetoFirebase_Scan(data: imageToSend as NSData)
                
                print("ScanMode")
            }
            else if(currentIndex  == 1){
                imageToSend = UIImageJPEGRepresentation(image!, 0.8)! as NSData
                uploadImagetoFirebase_Create(data: imageToSend as NSData)
                
                let storyboard = UIStoryboard(name:"Main", bundle: nil)
                let secondVC = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
                
                self.navigationController?.pushViewController(secondVC, animated: true)
                secondVC.imageData = imageData
               self.present(secondVC, animated: true, completion: nil)
                
            }
            //show the image
        }
    }
    // upload the image to firebase
    func uploadImagetoFirebase_Scan(data: NSData)
    {
        let uid = Auth.auth().currentUser!.uid
        let imageName = NSUUID().uuidString
        let ref = Database.database().reference(fromURL: "https://custombarcode-3b747.firebaseio.com/")
        let storageRef = Storage.storage().reference(withPath: "/\(uid)" + "/" +  "\(imageName)")
        var downloadURL : String = " "
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/png"
        storageRef.putData(data as Data, metadata: uploadMetadata).observe(.success) { (snapshot) in
            // When the image has successfully uploaded, we get it's download URL
            downloadURL = (snapshot.metadata?.downloadURL()?.absoluteString)!
            // Write the download URL to the Realtime Database
            
            
            let values = ["from" : "\(uid)", "photoURL" : "\(downloadURL)"] as [String : Any]
            let userReference = ref.child("Request").child(uid)
            
            userReference.updateChildValues(values, withCompletionBlock: {(err, ref) in
                if err != nil {
                    return
                }
                print()
                
            })
        }
        
        
        
    }
    
    func uploadImagetoFirebase_Create(data: NSData)
    {
        
        let uid = Auth.auth().currentUser!.uid
        let imageName = NSUUID().uuidString
        let ref = Database.database().reference(fromURL: "https://custombarcode-3b747.firebaseio.com/")
        let storageRef = Storage.storage().reference(withPath: "/\(uid)" + "/" +  "\(imageName)")
        var downloadURL : String = " "
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/png"
        storageRef.putData(data as Data, metadata: uploadMetadata).observe(.success) { (snapshot) in
            // When the image has successfully uploaded, we get it's download URL
            downloadURL = (snapshot.metadata?.downloadURL()?.absoluteString)!
            // Write the download URL to the Realtime Database
            
            
            let values = ["photoURL" : "\(downloadURL)", "info" : "temporary info" ] as [String : Any]
            let userReference = ref.child("Stickers").child(uid)
            
            userReference.updateChildValues(values, withCompletionBlock: {(err, ref) in
                if err != nil {
                    return
                }
                print()
                
            })
        }

}
}
