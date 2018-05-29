//
//  ScreenViewController.swift
//  CBarcode
//
//  Created by Release on 2018. 5. 29..
//  Copyright © 2018년 Se Jin Lee. All rights reserved.
//


import UIKit
import AVFoundation

class ScreenViewController: UIViewController {
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var captureSession : AVCaptureSession
    
    
    init(index: Int, name : String, session : AVCaptureSession) {
        self.captureSession = session
        super.init(nibName: nil, bundle: nil)
        self.title = name
        setupPreviewLayer()
    }
    
    
    
    func setupPreviewLayer(){
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session : captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    override func viewWillAppear(_ animated : Bool) {
        super.viewWillAppear(true)
    // Setup your camera here...
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }

    
}
