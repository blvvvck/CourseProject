//
//  ThirdCourseInitializer.swift
//  CourseProject
//
//  Created by BLVCK on 14/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class ThirdCourseInitializer: NSObject {

    
    @IBOutlet weak var viewControlelr: FirstCourseViewController!
    
    override func awakeFromNib() {
        
        let _ = ThirdCourseConfigurator.setupModule(with: viewControlelr)
    }
}
