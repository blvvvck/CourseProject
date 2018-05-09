//
//  CompleteReviewViewController.swift
//  CourseProject
//
//  Created by BLVCK on 09/05/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit
import ILPDFKit
import MessageUI

class CompleteReviewViewController: ILPDFViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var pdf: ILPDFView!
    var name = "Ринат"
    var data: Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let sendButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(showMailComposer))
        let sendButton = UIButton(type: .custom)
        sendButton.titleLabel?.text = "Отправить"
        sendButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        sendButton.addTarget(self, action: #selector(showMailComposer), for: .touchUpInside)
        let sendBarButtonItem = UIBarButtonItem(customView: sendButton)
        self.navigationController?.navigationItem.setRightBarButton(sendBarButtonItem, animated: true)
        self.navigationController?.navigationItem.rightBarButtonItem?.title = "Send"
        self.navigationController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        self.navigationController?.navigationItem.rightBarButtonItem?.isEnabled = true
        self.navigationItem.setRightBarButton(sendBarButtonItem, animated: true)
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        print(self.navigationController?.navigationBar.items)
        
        let homeBtn: UIButton = UIButton(type: UIButtonType.custom)
        
        homeBtn.setImage(UIImage(named: "send-button"), for: [])
        
        homeBtn.addTarget(self, action: #selector(showMailComposer), for: UIControlEvents.touchUpInside)
        
        homeBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let homeButton = UIBarButtonItem(customView: homeBtn)
        self.navigationItem.setRightBarButton(homeButton, animated: true)

        
        let document = ILPDFDocument(resource:"courseProject1.pdf")
        self.document = document
        let test = document.forms.forms(withName: "theme")
        let studentNameForm = document.forms.forms(withName: "studentName")
        studentNameForm.first?.value = name
        
        let realization = document.forms.forms(withName: "realization_4")
        let text = document.forms.forms(withName: "text_3")
        for test in realization {
            test.value = "+"
        }
        for test in text {
            test.value = "+"
        }
        
        let data = self.document?.savedStaticPDFData()
        self.data = data
        
        let savedVCDocument = ILPDFDocument(data: data!)
        
        self.document = savedVCDocument
        
        print(self.pdfView?.pdfView.frame)
        self.pdfView?.pdfView.scrollView.backgroundColor = UIColor.white
        self.pdfView?.pdfView.scrollView.tintColor = UIColor.white
        print(self.pdfView?.pdfView.subviews)


        //self.pdfView?.pdfView.frame.size.height = 568
        //self.pdfView?.pdfView.frame.size.width = 320


        
    }
    
    @objc func showMailComposer() {
        if MFMailComposeViewController.canSendMail() {
            let subject = "Отзыв руководителя курсовой"
            let messageBody = "Отзыв руководителя курсовой"
            let toRecipients = ["wrooneyn10@gmail.com"]
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.delegate = self as! UIViewController as! UINavigationControllerDelegate
            mailComposer.setSubject(subject)
            mailComposer.setMessageBody(messageBody, isHTML: false)
            mailComposer.setToRecipients(toRecipients)
            mailComposer.addAttachmentData(data, mimeType: "application/pdf", fileName: "Отзыв")
            present(mailComposer, animated: true, completion: nil)
        }
    }
    
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        
//        switch result.rawValue {
//        case MFMailComposeResult.cancelled.rawValue:
//            
//        default:
//            <#code#>
//        }
//    }

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

