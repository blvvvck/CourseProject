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
//        output.frame = view.bounds
//        output.isEditable = false
//        output.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
//        output.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        output.isHidden = true
//        view.addSubview(output);
//        addCircleView()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            showAlert(title: "Authentication Error", message: error.localizedDescription)
            self.service.authorizer = nil
        } else {
            let flag = UserDefaults.standard.bool(forKey: "firstAppStart")
            if flag == false || flag == nil {
                performSegue(withIdentifier: "toSettings", sender: nil)

            } else {
                performSegue(withIdentifier: "mainScreenSegue", sender: nil)

            }
            //self.signInButton.isHidden = true
            self.output.isHidden = false
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            //UserDefaults.standard.setValue(user, forKey: "user")
            //listMajors()
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
//        service.executeQuery(query) { (ticket, result, error) in
//
//            var newResult = result as! GTLRSheets_ValueRange
//            var rows = newResult.values!
//
//            for row in rows {
//                let enity = ResultStruct(name: row[0] as! String, group: row[1] as! String, theme: row[2] as! String, course: row[3] as! String, email: row[4] as! String)
//                self.enitys.append(enity)
//            }
//
//            var courseFirst = [ResultStruct]()
//
//            for entity in self.enitys {
//                if entity.course == "2" {
//                    courseFirst.append(entity)
//                }
//            }
//
//            for student in courseFirst {
//                print(student.name)
//                print(student.course)
//                print(student.theme)
//            }
//        }
        
        
    }
    
    var circleView :  CircleClosing!
    
    func addCircleView() {
        let diceRoll = CGFloat(510)    //CGFloat(Int(arc4random_uniform(7))*50)
        let diceRolly = CGFloat(70)
        let circleWidth = CGFloat(40)
        let circleHeight = circleWidth
        
        //Add this line here to remove from superview
        //circleView.removeFromSuperview()
        
        circleView = CircleClosing(frame:CGRect(x:diceRoll,y: diceRolly,width: circleWidth,height: circleHeight) )
        
        view.addSubview(circleView)
        
        // Animate the drawing of the circle over the course of 1 second
        circleView.animateCircle(duration: 2.0)
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

class CircleClosing: UIView {
    
    var circleLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        let circlePath : UIBezierPath!
        circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 5)/2, startAngle: 0.0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.blue.cgColor
        circleLayer.lineWidth = 20.0;
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.0
        
        // Add the circleLayer to the view's layer's sublayers
        
        
    }
    override func layoutSubviews()
    {
        let frame = self.layer.bounds
        circleLayer.frame = frame
        layer.addSublayer(circleLayer)
        
    }
    required init?(coder aDecoder: NSCoder)
    { super.init(coder: aDecoder) }
    
    func animateCircle(duration: TimeInterval) {
        
        
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = duration
        
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = 1
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        circleLayer.strokeEnd = 1.0
        
        // Do the actual animation
        circleLayer.add(animation, forKey: "animateCircle")
    }
    
}

