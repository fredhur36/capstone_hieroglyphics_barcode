//
//  TitleDescriptionViewController.swift
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

class RegisterInfo: UIViewController, UITextViewDelegate, AVCapturePhotoCaptureDelegate
{
     weak var titleTextfield: UITextView!
    weak var DescriptionTextField: UITextView!
    var imageData = Data()
    var Str : String = " "
    
    var count = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
       print("The result + \(Str)")
        titleTextfield.delegate = self
        DescriptionTextField.delegate = self
     //   self.view.addGestureRecognizer(UIGestureRecognizer(target: self, action: Selector("dismissKeyboard")))
    }
    @IBAction func cancelButtonClicked(_ sender: Any) {
        let mainPageViewController = MainPageViewController()
        self.present(mainPageViewController, animated: true, completion: nil)
        
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"
        {
            titleTextfield.resignFirstResponder()
            DescriptionTextField.resignFirstResponder()
            return false
        }
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func registerButtonClicked(_ sender: Any) {
       self.uploadImagetoFirebase_Create(data: imageData as NSData)
       

    }
    
    func uploadImagetoFirebase_Create(data: NSData)
    {
        let uid = Auth.auth().currentUser!.uid
        let imageName = NSUUID().uuidString
        let ref = Database.database().reference(fromURL: "https://custombarcode-3b747.firebaseio.com/")
        let storageRef = Storage.storage().reference(withPath: "/\(uid)" + "/" +  "\(imageName)")
        let searchRef = ref.child("Users").child(uid).child("count")
        var downloadURL : String = " "
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/png"
        storageRef.putData(data as Data, metadata: uploadMetadata).observe(.success) { (snapshot) in
            // When the image has successfully uploaded, we get it's download URL
            downloadURL = (snapshot.metadata?.downloadURL()?.absoluteString)!
            // Write the download URL to the Realtime Database
            
            
            let values = ["photoURL" : "\(downloadURL)", "message" : self.DescriptionTextField.text] as [String : Any]
            let userReference = ref.child("Stickers").child(uid).child("\(self.count)")
            
            userReference.updateChildValues(values, withCompletionBlock: {(err, ref) in
                if err != nil {
                    return
                }
                print()
                
            })
        }
        
        searchRef.observeSingleEvent(of: .value) { (snapshot) in
            if !snapshot.exists() {
                return
            }
            if let con = snapshot.value as? Int {
                self.count = con + 1
                
                let userReference2 = ref.child("Users").child(uid).child("count").setValue(self.count)
                
                print(con)
            }
        }
        
    
        let myalert=SCLAlertView()
        
        myalert.showTitle(
            "Congratulations", // Title of view
            subTitle: "Operation successfully completed.", // String of view
            style: .success, closeButtonTitle: nil, // Styles - see below.
            colorStyle: 0xA429FF,
            colorTextButton: 0xFFFFFF
            
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.goBackToCamera()
        }
        
        
    }
    
    func goBackToCamera()
    {
        
        let mainPageViewController = MainPageViewController()
        self.present(mainPageViewController, animated: true, completion: nil)
        
    }
}
