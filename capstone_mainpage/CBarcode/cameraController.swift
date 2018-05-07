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
    
    var flag = 0
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker = UIImagePickerController()
   override func viewDidLoad() {
        
        super.viewDidLoad()
       photoPerform(self)
    }
    

    @IBAction func create(_ sender: Any) {
        
            uploadImagetoFirebase(data: imageData as NSData, type: 1)
            
        
        
    }
    
    @IBAction func scan(_ sender: Any) {
        
            uploadImagetoFirebase(data: imageData as NSData, type: 2)
            
        
    }
    
    
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func photoPerform(_ sender: Any) {
        // if photo library is available, load it
       if UIImagePickerController.isSourceTypeAvailable(.camera) {
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
        
        
           // uploadImagetoFirebase(data: imageData as NSData, type: 1)
 
 }
        
    }
    // upload the image to firebase
    func uploadImagetoFirebase(data: NSData, type : Int)
    {
        let uid = Auth.auth().currentUser!.uid
        
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference(withPath: "\(uid)/" + "\(imageName).png" )
        print(imageName)
        let ref = Database.database().reference(fromURL: "https://custombarcode-3b747.firebaseio.com/")
        
          // this needs to be edited later. It should make a path according to the user's id
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/png"
        _ = storageRef.putData(data as Data,metadata: uploadMetadata) {(metadata,error) in
            if(error != nil) {
                print("I received an error! \(String(describing: error?.localizedDescription))")
            }else
            {
                print("Upload complete! Here's some metadata ! \(String(describing: metadata))")
            }
            
            
        }
        if type == 1
        {
            
            
            let userReference = ref.child("Sticker").child(uid)
          
            if let imageURL = uploadMetadata.downloadURL()?.absoluteString {
                
                let values = [ "URL" : imageURL, "message" : "temporary message"]
                
            
            userReference.updateChildValues(values, withCompletionBlock: {(err, ref) in
                if err != nil {
                    print(err)
                    return
                }
            }
            )
        }
        }
        else{

            
            let userReference = ref.child("Request").child(uid)
         
                if (uploadMetadata.downloadURL()?.absoluteString) != nil {
                    
                    
            let values = ["from" : uid, "photoURL" : uploadMetadata.downloadURL()!] as [String : Any]
            userReference.updateChildValues(values, withCompletionBlock: {(err, ref) in
                if err != nil {
                    print(err)
                    return
                }
            }
            )
        }
    }
        
}
