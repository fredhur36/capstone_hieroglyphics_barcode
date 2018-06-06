//
//  TitleDescriptionViewController.swift
//  CBarcode
//
//  Created by Se Jin Lee on 06/06/2018.
//  Copyright © 2018 Se Jin Lee. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class TitleDescriptionViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var titleTextfield: UITextView!
    @IBOutlet weak var DescriptionTextField: UITextView!
    var data = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        titleTextfield.delegate = self
        DescriptionTextField.delegate = self
     //   self.view.addGestureRecognizer(UIGestureRecognizer(target: self, action: Selector("dismissKeyboard")))
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
            
            
            let values = ["photoURL" : "\(downloadURL)", "info" : self.DescriptionTextField.text] as [String : Any]
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
