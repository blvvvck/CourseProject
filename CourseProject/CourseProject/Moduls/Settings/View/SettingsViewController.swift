//
//  SettingsViewController.swift
//  CourseProject
//
//  Created by BLVCK on 12/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewInput, UITextFieldDelegate {
    
    @IBOutlet weak var mentorTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var sheetNameTextField: UITextField!
    @IBOutlet weak var rangeTextField: UITextField!
    var presenter: SettingsViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
        mentorTextField.delegate = self
        linkTextField.delegate = self
        
        // set return key styles
        mentorTextField.returnKeyType = UIReturnKeyType.done
        linkTextField.returnKeyType = UIReturnKeyType.done
        
        // only enable textField2 if textField1 is non-empty
        
        // only enable 'go' key of textField2 if the field itself is non-empty
        linkTextField.enablesReturnKeyAutomatically = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setMentor(with mentor: String) {
        mentorTextField.text = mentor
    }
    
    func setLink(with link: String) {
        linkTextField.text = link
    }
    
    func setSheetName(with sheetName: String) {
        sheetNameTextField.text = sheetName
    }
    
    func setRange(with range: String) {
        rangeTextField.text = range
    }
   
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        presenter.saveSettings(with: mentorTextField.text!, and: linkTextField.text!, and: sheetNameTextField.text!, and: rangeTextField.text!)
    }
    
}
