//  mainViewController.swift
//  capstone_mainpage
//
//  Created by 이혜리 on 2018. 4. 8..
//  Copyright © 2018년 이혜리. All rights reserved.
//

import UIKit

class RegisterModeViewController: UIViewController {
    
    init(index: Int) {
        super.init(nibName: nil, bundle: nil)
        title = "Register"
        
        
        let label = UILabel(frame :.zero)
        label.text = "Register"
        label.sizeToFit()
        
        view.addSubview(label)
        view.constrainCentered(label)
        view.backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

