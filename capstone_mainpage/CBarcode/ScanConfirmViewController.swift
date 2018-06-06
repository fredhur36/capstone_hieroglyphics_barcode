//
//  ScanConfirmViewController.swift
//  CBarcode
//
//  Created by Se Jin Lee on 06/06/2018.
//  Copyright © 2018 Se Jin Lee. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit
import SCLAlertView
import Parchment
import AVFoundation
class ScanConfirmViewController: UIViewController, AVCapturePhotoCaptureDelegate  {
    @IBOutlet weak var ImageView: UIImageView!
    var image = UIImage()
    var imageData = Data()
    var flag : Int = 0
    var name : String = " "
    var downloadURL : String = " "
    @IBAction func confirmButton(_ sender: Any) {
        uploadImagetoFirebase_Scan(data: imageData as NSData)
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
          self.checkResult()
           
        }
    }
    func checkResult()
    {
        let ref = Database.database().reference(fromURL: "https://custombarcode-3b747.firebaseio.com/")
        print("self name in checkResult: " + self.name)
        
        let searchRef = ref.child("Request").child(self.name).child("result")
        searchRef.observeSingleEvent(of: .value) { (snapshot) in
            if !snapshot.exists() {
            
            }
            if let con = snapshot.value as? String {
               
                if con == "empty"
                {
                     SCLAlertView().showError("Sticker is not registered", subTitle: "cannot find the same sticker")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.goBackToCamera()
                        
                    }
                }else
                {
                    let storyboard = UIStoryboard(name:"Main", bundle: nil)
                    print("this is called")
                    let nextVC = storyboard.instantiateViewController(withIdentifier: "LoadMessageViewController") as! LoadMessageViewController
                   nextVC.message = con
                   self.present(nextVC, animated: true, completion: nil)
                }
            }
            
        }
    }
    
    func uploadImagetoFirebase_Scan(data: NSData)
    {
        let uid = Auth.auth().currentUser!.uid
        let imageName = NSUUID().uuidString
        self.name = imageName
        let ref = Database.database().reference(fromURL: "https://custombarcode-3b747.firebaseio.com/")
        let storageRef = Storage.storage().reference(withPath: "/\(uid)" + "/" +  "\(imageName)")
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/png"
        storageRef.putData(data as Data, metadata: uploadMetadata).observe(.success) { (snapshot) in
            // When the image has successfully uploaded, we get it's download URL
            let downloadURL = (snapshot.metadata?.downloadURL()?.absoluteString)!
            // Write the download URL to the Realtime Database
            
            
            let values = ["from" : "\(uid)", "photoURL" : "\(downloadURL)", "result": "empty"] as [String : Any]
            
            let userReference = ref.child("Request").child(self.name)
            print("self name in uploadImage: " + self.name)
            userReference.updateChildValues(values, withCompletionBlock: {(err, ref) in
                if err != nil {
                    return
                }
                print()
                
            })
        }
        
        
        
    }
    @IBAction func cancelButton(_ sender: Any) {
        let mainPageViewController = MainPageViewController()
        self.present(mainPageViewController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageView.image = UIImage(data : imageData)
        
    }
    
    func goBackToCamera()
    {
        
        let mainPageViewController = MainPageViewController()
        self.present(mainPageViewController, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
