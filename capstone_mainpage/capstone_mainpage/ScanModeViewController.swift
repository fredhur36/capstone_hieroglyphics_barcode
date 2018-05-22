//  mainViewController.swift
//  capstone_mainpage
//
//  Created by 이혜리 on 2018. 4. 8..
//  Copyright © 2018년 이혜리. All rights reserved.
//

import UIKit
import AVFoundation

class ScanModeViewController: UIViewController {
    
    let preview = UIView(frame : .zero)
    
    var captureSession = AVCaptureSession()
    var camera : AVCaptureDevice?
    var currentCamera : AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    
    //var stillImageOutput: AVCaptureStillImageOutput?
    //var cameraScreenLayer: AVCaptureVideoPreviewLayer?
    
    
    init(index: Int) {
        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(preview)
        view.constrainCentered(preview)
        
        //view.backgroundColor = .white
    /*
         title = "ScanMode"
        
        
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
        camera = deviceDiscoverySession.devices[0]
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
        cameraPreviewLayer?.frame = self.preview.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
        
    }
    
    func startRunningCaptureSession(){
        captureSession.startRunning()
    }
    /*
    let cameraScreen : UIView
    cameraScreen.translatesAutoresizingMaskIntoConstraints = false
    cameraScreen.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
    
    
    session = AVCaptureSession()
    session!.sessionPreset = AVCaptureSession.Preset.photo
    
    let camera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    
    var error : NSError?
    var input: AVCaptureDeviceInput()
    
    do{
        input = try AVCaptureDeviceInput(device : camera)
    } catch let error1 as NSError {
        error = error1
        input= nil
        print(error!.localizedDescription)
    }
    
    if error == nil && sesssion!.canAddInput(input){
        session!.addInput(input)
    }
    
    stillImageOutput = AVCaptureStillImageOutput()
    stillImageOutput?.outputSettings = AVVideoCodecKey: AVVideoCodecJPEG]
    
    if session!.canAddOutput(stillImageOutput) {
    session!.addOutput(stillImageOutput)
    // ...
    // Configure the Live Preview here...
    }
    
    cameraScreenLayer = AVCaptureVideoPreviewLayer(session : session)
    cameraScreen!.videoGravity = AVLayerVideoGravityResizeAsepcet
    videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.Portrait
    preview.layer.addSublayer(cameraScreenLayer!)
        session!.startRunning()

        
     */
    
    

    
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
