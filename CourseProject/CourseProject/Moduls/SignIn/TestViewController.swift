//
//  TestViewController.swift
//  CourseProject
//
//  Created by BLVCK on 10/05/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    
    var circleView :  CircleClosing!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCircleView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
