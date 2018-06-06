//
//  InfoViewController.swift
//  CBarcode
//
//  Created by Se Jin Lee on 06/06/2018.
//  Copyright © 2018 Se Jin Lee. All rights reserved.
//

import UIKit

import Parchment
import AVFoundation
class InfoViewController: UIViewController, AVCapturePhotoCaptureDelegate  {
    @IBOutlet weak var ImageView: UIImageView!
    var image = UIImage()
    var imageData = Data()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         ImageView.image = UIImage(data : imageData)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}