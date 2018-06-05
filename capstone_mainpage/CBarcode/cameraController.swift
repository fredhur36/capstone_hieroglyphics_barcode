//
//  cameraController.swift
//  CBarcode
//
//  Created by Se Jin Lee on 20/03/2018.
//  Copyright © 2018 Se Jin Lee. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class cameraController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    var originalImage : UIImage!
    var imageData : NSData!
    
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker = UIImagePickerController()
   override func viewDidLoad() {
        
        super.viewDidLoad()
       photoPerform(self)
    }
    

    @IBAction func create(_ sender: Any) {
        
        uploadImagetoFirebase_Create(data: imageData as NSData)
        
        
    }
    
    @IBAction func scan(_ sender: Any) {
        
            uploadImagetoFirebase_Scan(data: imageData as NSData)
            
        
    }
    
    
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func photoPerform(_ sender: Any) {
        // if photo library is available, load it
       if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    // display the selected image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
        
       originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        imageData = UIImageJPEGRepresentation(originalImage, 0.8)! as NSData
        
        
        //uploadImagetoFirebase_Scan(data: imageData as NSData)
 
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



