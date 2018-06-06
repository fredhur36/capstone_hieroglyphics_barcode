//
//  LoadMessageViewController.swift
//  CBarcode
//
//  Created by Se Jin Lee on 06/06/2018.
//  Copyright © 2018 Se Jin Lee. All rights reserved.
//

import Foundation
import UIKit

class LoadMessageViewController: UIViewController {
    var message : String = " "
    
    @IBOutlet weak var textField: UITextView!
    
    @IBAction func goBack(_ sender: Any) {
        let mainPageViewController = MainPageViewController()
        self.present(mainPageViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       textField.text = message
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
