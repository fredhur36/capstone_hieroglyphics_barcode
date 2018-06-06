//
//  TitleDescriptionViewController.swift
//  CBarcode
//
//  Created by Se Jin Lee on 06/06/2018.
//  Copyright © 2018 Se Jin Lee. All rights reserved.
//

import UIKit
class TitleDescriptionViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var titleTextfield: UITextView!
    @IBOutlet weak var DescriptionTextField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        titleTextfield.delegate = self
        DescriptionTextField.delegate = self
     //   self.view.addGestureRecognizer(UIGestureRecognizer(target: self, action: Selector("dismissKeyboard")))
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"
        {
            titleTextfield.resignFirstResponder()
            DescriptionTextField.resignFirstResponder()
            return false
        }
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
