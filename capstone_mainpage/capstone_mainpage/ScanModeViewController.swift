//  mainViewController.swift
//  capstone_mainpage
//
//  Created by 이혜리 on 2018. 4. 8..
//  Copyright © 2018년 이혜리. All rights reserved.
//

import UIKit
import AVFoundation

class ScanModeViewController: UIViewController {
    
    
    var captureSession = AVCaptureSession()
    var camera : AVCaptureDevice?
    var currentCamera : AVCaptureDevice?
    public var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    //var stillImageOutput: AVCaptureStillImageOutput?
    //var cameraScreenLayer: AVCaptureVideoPreviewLayer?
    
    
    init(index: Int) {
        super.init(nibName: nil, bundle: nil)
        title = "Scan"
        
        /*
         
         let label = UILabel()
         label.text = "ScanMode"
         label.sizeToFit()
         
         */
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
        
    }
    
    func setupCaptureSession(){
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDevice(){
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes : [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType : AVMediaType.video, position : AVCaptureDevice.Position.back)
        for device in deviceDiscoverySession.devices{
            camera = device
        }
    }
    
    func setupInputOutput(){
        do{
            let captureDeviceInput = try AVCaptureDeviceInput(device : camera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format : [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        }catch {
            print(error)
        }
    }
    
    func setupPreviewLayer(){
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session : captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
        
    }
    
    func startRunningCaptureSession(){
        captureSession.startRunning()
    }
    
    func getPhotoPutput() -> AVCapturePhotoOutput?{
        return photoOutput
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
     override func viewWillAppear(animated: Bool) {
     super.viewWillAppear(animated)
     // Setup your camera here...
     }
     
     overrid func viewDidAppear(animated : Bool){
     super.viewDidAppear(animated)
     cameraScreenLayer!.frame =
     }
     */
    
}

