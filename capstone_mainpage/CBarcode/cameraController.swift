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
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker = UIImagePickerController()
   override func viewDidLoad() {
        
        super.viewDidLoad()
       photoPerform(self)
    }
    
    @IBAction func reTake(_ sender: Any) {
       
        photoPerform(self)
    }
    @IBAction func sendImage(_ sender: Any) {
        
    }
    
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cameraClicked(_ sender: Any) {
        // if camera is available, load camera
   /* if UIImagePickerController.isSourceTypeAvailable(.camera) {
    
    imagePicker.delegate = self
    imagePicker.sourceType = .camera
    imagePicker.allowsEditing = false
    self.present(imagePicker, animated: true, completion: nil)
    
        }*/
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
        
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage, let imageData = UIImageJPEGRepresentation(originalImage, 0.8)
        
        {
            uploadImagetoFirebase(data: imageData as NSData)
       
        }
        
    }
    // upload the image to firebase
    func uploadImagetoFirebase(data: NSData)
    {
        let storageRef = Storage.storage().reference(withPath: "myPics/demoPic.jpg")  // this needs to be edited later. It should make a path according to the user's id
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        let uploadTask = storageRef.putData(data as Data,metadata: uploadMetadata) {(metadata,error) in
            if(error != nil) {
                print("I received an error! \(String(describing: error?.localizedDescription))")
            }else
            {
                print("Upload complete! Here's some metadata ! \(String(describing: metadata))")
            }
        }
        /*
        uploadTask.observe(StorageTaskStatus){
            [weak self] (snapshot) in
            guard let strongSelf = self else { return }
            guard let progress = snapshot.progress else { return }
            strongSelf.progressView.progress = Float(progress.fractionCompleted)
        }*/
    }
}

