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

class DetailReviewViewController: UIViewController, ModuleInput, ModuleInputHolder, UITextViewDelegate {
    var moduleInput: ModuleInput?
    
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var radioBtn: DLRadioButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var dignityTextView: UITextView!
    @IBOutlet weak var directionRadioButton: DLRadioButton!
    @IBOutlet weak var workRatingRadioButton: DLRadioButton!
    @IBOutlet weak var textWorkRadioButton: DLRadioButton!
    @IBOutlet weak var completeWorkRadioButton: DLRadioButton!
    @IBOutlet weak var constraintTextViewToMerk: NSLayoutConstraint!
    @IBOutlet weak var constraintTextViewToOther: NSLayoutConstraint!
    @IBOutlet weak var constraintOtherToMark: NSLayoutConstraint!
    let studentDbManager = StudentDbManager()
    var id = 0
    var student: Student!
    let settingsDbManager = DbManagerImplementation()
    var settings: SettingsModel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        themeLabel.text = "dsadsadsadsadhsadasbduasbduasbdhasbdjhasbdasbdjsahbdja"
        constraintTextViewToMerk.priority = .defaultLow
        constraintTextViewToOther.priority = .defaultLow
        constraintOtherToMark.priority = .defaultHigh
        textView.isHidden = true
        radioBtn.isSelected = true
        moduleInput = self
        student = studentDbManager.getStudentById(with: id)
        workRatingRadioButton.isSelected = true
        settings = settingsDbManager.getDataFromDB()
        // Do any additional setup after loading the view.
        prepareStudentInfo()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(actionTap))
        self.view.addGestureRecognizer(gesture)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: Notification.Name.UIKeyboardWillShow, object: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillAppear(_ notification: NSNotification) {
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 40
        scrollView.contentInset = contentInset
        
    }
    
    @objc func keyboardWillDisappear(_ notification: NSNotification) {
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    @objc func actionTap() {
        if (textView.isFirstResponder || dignityTextView.isFirstResponder ) {
            textView.resignFirstResponder()
            dignityTextView.resignFirstResponder()
        }
    }
    
    func prepareStudentInfo() {
        nameLabel.text = student.name
        groupLabel.text = student.group
        themeLabel.text = student.theme
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
        var limitationsText = ""
        var conclusionText = ""
        //pdfReview.name = "Аня"
        if radioBtn.titleLabel?.text == "Не выявлено" {
            limitationsText = "Существенных недостатков в работе выявлено не было"
        } else {
            limitationsText = textView.text
        }
        if completeWorkRadioButton.titleLabel?.text == "5" {
            conclusionText = "Данная работа соответствует требования и заслуживает оценки отлично"
        } else if completeWorkRadioButton.titleLabel?.text == "4" {
            conclusionText = "Данная работа соответствует требования и заслуживает оценки хорошо"
        } else if completeWorkRadioButton.titleLabel?.text == "3" {
            conclusionText = "Данная работа соответствует требования и заслуживает оценки удовлетворительно"
        }
        let reviewModel = ReviewModel(theme: student.theme, studentName: student.name, institute: "Высшая школа информационных технологий и информационных систем", direction: (directionRadioButton.titleLabel?.text)!, mentor: settings.mentor, workRating: (workRatingRadioButton.titleLabel?.text)!, textRating: (textWorkRadioButton.titleLabel?.text)!, dignity: dignityTextView.text, limitations: limitationsText, conclusion: conclusionText, studentEmail: student.email)
        
        pdfReview.reviewModel = reviewModel
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
