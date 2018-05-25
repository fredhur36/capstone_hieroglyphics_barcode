//  mainViewController.swift
//  capstone_mainpage
//
//  Created by 이혜리 on 2018. 4. 8..
//  Copyright © 2018년 이혜리. All rights reserved.
//

import UIKit


class ScanModeViewController: UIViewController {
    
    var image: UIImage!
    var photoView: UIImageView
    
    
    init(image: UIImage) {
        photoView = UIImageView(image: image)
        photoView.backgroundColor = .green
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        self.view.addSubview(photoView)
        super.viewDidLoad()
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
}

