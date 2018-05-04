//  mainViewController.swift
//  capstone_mainpage
//
//  Created by 이혜리 on 2018. 4. 8..
//  Copyright © 2018년 이혜리. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    init(index: Int) {
        super.init(nibName: nil, bundle: nil)
        title = "Recognize"
        
        let label = UILabel(frame : .zero)
        label.text="\(title)"
        label.sizeToFit()
        
        // Camera and the sign where to put the sticker in.
        // Camera button and Button to the storage
        
        //let cameraButton = UIButton()
        //let storageButton = UIButton()
        
        // Change label into the view
        view.addSubview(label)
        view.constrainCentered(label)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
