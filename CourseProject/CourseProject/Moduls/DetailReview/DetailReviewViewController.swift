//
//  DetailReviewViewController.swift
//  CourseProject
//
//  Created by BLVCK on 16/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit
import DLRadioButton

class DetailReviewViewController: UIViewController {

    @IBOutlet weak var radioBtn: DLRadioButton!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var constraintTextViewToMerk: NSLayoutConstraint!
    @IBOutlet weak var constraintTextViewToOther: NSLayoutConstraint!
    @IBOutlet weak var constraintOtherToMark: NSLayoutConstraint!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        radioBtn.isMultipleSelectionEnabled = false
        radioBtn.isMultipleTouchEnabled = false
        constraintTextViewToMerk.priority = .defaultLow
        constraintTextViewToOther.priority = .defaultLow
        constraintOtherToMark.priority = .defaultHigh
        textView.isHidden = true
        radioBtn.isSelected = true

        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
