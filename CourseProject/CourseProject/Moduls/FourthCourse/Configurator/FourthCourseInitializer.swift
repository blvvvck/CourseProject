//
//  FourthCourseInitializer.swift
//  CourseProject
//
//  Created by BLVCK on 14/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class FourthCourseInitializer: NSObject {
    
    @IBOutlet weak var viewController: FirstCourseViewController!
    
    override func awakeFromNib() {
        
        let _ = FourthCourseConfigurator.setupModule(with: viewController)
    }
}
