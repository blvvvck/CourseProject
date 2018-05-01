//
//  Course.swift
//  CourseProject
//
//  Created by BLVCK on 29/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class Course {
    
    // MARK: - Public API
    var title = ""
    var featuredImage: UIImage
    var color: UIColor
    
    init(title: String, featuredImage: UIImage, color: UIColor)
    {
        self.title = title
        self.featuredImage = featuredImage
        self.color = color
    }
    
    // MARK: - Private
    // dummy data
    static func fetchCourse() -> [Course]
    {
        return [
            Course(title: "2 курс", featuredImage: UIImage(named: "1course")!, color: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: 0.8)),
//            Course(title: "Cafe with Best Friends", featuredImage: UIImage(named: "f2")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.8)),
//            Course(title: "Study Personal Development Books and Courses", featuredImage: UIImage(named: "f3")!, color: UIColor(red: 105/255.0, green: 80/255.0, blue: 227/255.0, alpha: 0.8)),
            Course(title: "3 курс", featuredImage: UIImage(named: "2course")!, color: UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 0.8)),
            
//            Course(title: "Learn. Create. Contribute.", featuredImage: UIImage(named: "f5")!, color: UIColor(red: 245/255.0, green: 62/255.0, blue: 40/255.0, alpha: 0.8)),
//            Course(title: "Inspire, Instruct, and Empower People", featuredImage: UIImage(named: "f6")!, color: UIColor(red: 103/255.0, green: 217/255.0, blue: 87/255.0, alpha: 0.8)),
            Course(title: "4 курс", featuredImage: UIImage(named: "3course")!, color: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: 0.8)),
//            Course(title: "3D Printing, Virtual Reality and AI", featuredImage: UIImage(named: "f8")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.8)),
        ]
    }
}
