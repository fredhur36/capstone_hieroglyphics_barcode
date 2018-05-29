//
//  CameraViewController.swift
//  CBarcode
//
//  Created by 이혜리 on 2018. 5. 25..
//  Copyright © 2018년 Se Jin Lee. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController : UIViewController {
    
    
    var captureSession = AVCaptureSession()
    var camera : AVCaptureDevice?
    var currentCamera : AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
       
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        startRunningCaptureSession()
        /*
         let label = UILabel()
         label.text = "ScanMode"
         label.sizeToFit()
         */
    }
    
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 */
    
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

    
    func startRunningCaptureSession(){
        captureSession.startRunning()
    }
    
    func getCaptureSession() -> AVCaptureSession {
        return captureSession
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }



 
 /*
    override func viewDidDisappear(_ animated : Bool){
        super.viewDidDisappear(animated)
        //cameraScreenLayer!.frame =
    }
 */

}
