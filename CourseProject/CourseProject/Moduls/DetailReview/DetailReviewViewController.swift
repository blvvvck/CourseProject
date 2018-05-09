//
//  DetailReviewViewController.swift
//  CourseProject
//
//  Created by BLVCK on 16/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit
import DLRadioButton
import ILPDFKit

class DetailReviewViewController: UIViewController, ModuleInput, ModuleInputHolder {
    var moduleInput: ModuleInput?
    
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var radioBtn: DLRadioButton!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var directionRadioButton: DLRadioButton!
    @IBOutlet weak var workRatingRadioButton: DLRadioButton!
    @IBOutlet weak var textWorkRadioButton: DLRadioButton!
    @IBOutlet weak var completeWorkRadioButton: DLRadioButton!
    @IBOutlet weak var constraintTextViewToMerk: NSLayoutConstraint!
    @IBOutlet weak var constraintTextViewToOther: NSLayoutConstraint!
    @IBOutlet weak var constraintOtherToMark: NSLayoutConstraint!
    let studentDbManager = StudentDbManager()
    var id = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        themeLabel.text = "dsadsadsadsadhsadasbduasbduasbdhasbdjhasbdasbdjsahbdja"
        constraintTextViewToMerk.priority = .defaultLow
        constraintTextViewToOther.priority = .defaultLow
        constraintOtherToMark.priority = .defaultHigh
        textView.isHidden = true
        radioBtn.isSelected = true
        moduleInput = self
        var student = studentDbManager.getStudentById(with: id)
        themeLabel.text = student.theme
        workRatingRadioButton.isSelected = true
        // Do any additional setup after loading the view.
    }
    
    func prepareRadioButtons() {
        radioBtn.isMultipleSelectionEnabled = false
        radioBtn.isMultipleTouchEnabled = false
        completeWorkRadioButton.isMultipleSelectionEnabled = false
        completeWorkRadioButton.isMultipleTouchEnabled = false
        workRatingRadioButton.isMultipleSelectionEnabled = false
        workRatingRadioButton.isMultipleTouchEnabled = false
        textWorkRadioButton.isMultipleSelectionEnabled = false
        textWorkRadioButton.isMultipleTouchEnabled = false
        directionRadioButton.isMultipleSelectionEnabled = false
        directionRadioButton.isMultipleTouchEnabled = false
    }
    
    
    @IBAction func radioButtonTapped(_ sender: DLRadioButton) {
        if sender.tag == 1 {
            print("не выявлено")
            textView.isHidden = true
            constraintTextViewToMerk.priority = .defaultLow
            constraintTextViewToOther.priority = .defaultLow
            constraintOtherToMark.priority = .defaultHigh
        }
        if sender.tag == 2 {
            print(sender.titleLabel?.text)
            print("Другео")
            textView.isHidden = false
            
            constraintTextViewToMerk.priority = .defaultHigh
            constraintTextViewToOther.priority = .defaultHigh
            constraintOtherToMark.priority = .defaultLow
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData(_ data: Any?) {
        guard let index = data as? Int else {return}
        let student = studentDbManager.getStudentById(with: index)
        themeLabel.text = student.theme
        
    }
    

    @IBAction func generate(_ sender: Any) {
        let pdfReview = CompleteReviewViewController()
        pdfReview.name = "Аня"
        navigationController?.pushViewController(pdfReview as! UIViewController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
