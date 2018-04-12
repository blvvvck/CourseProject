//
//  SettingsViewController.swift
//  CourseProject
//
//  Created by BLVCK on 12/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewInput {
    
    @IBOutlet weak var mentorTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var sheetNameTextField: UITextField!
    @IBOutlet weak var rangeTextField: UITextField!
    var presenter: SettingsViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
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
