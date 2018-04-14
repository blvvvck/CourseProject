//
//  ViewController.swift
//  CourseProject
//
//  Created by BLVCK on 12/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

import GoogleAPIClientForREST
import GoogleSignIn
import UIKit

struct ResultStruct {
    let name: String
    let group: String
    let theme: String
    let course: String
    let email: String
}

class ViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var signIn: GIDSignInButton!
    
    // If modifying these scopes, delete your previously saved credentials by
    // resetting the iOS simulator or uninstall the app.
    private let scopes = [kGTLRAuthScopeSheetsSpreadsheetsReadonly]
    
    private let service = GTLRSheetsService()
    //let signInButton = GIDSignInButton()
    let output = UITextView()
    var enitys = [ResultStruct]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // signInButton.style = .wide
        //signInButton.colorScheme = .dark
        signIn.colorScheme = .dark
        
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        GIDSignIn.sharedInstance().signInSilently()
        
        // Add the sign-in button.
        //view.addSubview(signInButton)
        
        // Add a UITextView to display output.
        output.frame = view.bounds
        output.isEditable = false
        output.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        output.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        output.isHidden = true
        view.addSubview(output);
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            showAlert(title: "Authentication Error", message: error.localizedDescription)
            self.service.authorizer = nil
        } else {
            performSegue(withIdentifier: "mainScreenSegue", sender: nil)
            //self.signInButton.isHidden = true
            self.output.isHidden = false
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            //UserDefaults.standard.setValue(user, forKey: "user")
            listMajors()
//            var courseFirst = [ResultStruct]()
//
//            for entity in enitys {
//                if entity.course == "1" {
//                    courseFirst.append(entity)
//                }
//            }
//
//            for student in courseFirst {
//                print(student.name)
//                print(student.course)
//            }
        }
    }
    
    // Display (in the UITextView) the names and majors of students in a sample
    // spreadsheet:
    // https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit
    func listMajors() {
        output.text = "Getting sheet data..."
        let spreadsheetId = "14HuB6kWO13Qg0__1FBorOGE-AopYPMeTzh6bnlf5wBw"
        let range = "A2:F15"
        let query = GTLRSheetsQuery_SpreadsheetsValuesGet
            .query(withSpreadsheetId: spreadsheetId, range:range)
//        service.executeQuery(query,
//                             delegate: self,
//                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:))
//        )
        service.executeQuery(query) { (ticket, result, error) in

            var newResult = result as! GTLRSheets_ValueRange
            var rows = newResult.values!
            
            for row in rows {
                let enity = ResultStruct(name: row[0] as! String, group: row[1] as! String, theme: row[2] as! String, course: row[3] as! String, email: row[4] as! String)
                self.enitys.append(enity)
            }
            
            var courseFirst = [ResultStruct]()
            
            for entity in self.enitys {
                if entity.course == "2" {
                    courseFirst.append(entity)
                }
            }
            
            for student in courseFirst {
                print(student.name)
                print(student.course)
                print(student.theme)
            }
        }
        
        
    }
    
    // Process the response and display output
    @objc func displayResultWithTicket(ticket: GTLRServiceTicket,
                                       finishedWithObject result : GTLRSheets_ValueRange,
                                       error : NSError?) {
        
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }
        
        var majorsString = ""
        var rows = result.values!
        
        if rows.isEmpty {
            output.text = "No data found."
            return
        }
        rows[0].removeFirst()
        majorsString += "Name, Group:\n"
        for row in rows {
            
            let name = row[0]
            let major = row[1]
            let theme = row[2]
            let course = row[3]
            
            majorsString += "\(name), \(major), \(theme), \(course) \n"
        }
        
        output.text = majorsString
    }
    
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}


