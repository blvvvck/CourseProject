//
//  CourseCollectionViewCell.swift
//  CourseProject
//
//  Created by BLVCK on 29/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class CourseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImageVew: UIImageView!
    @IBOutlet weak var courseLable: UILabel!
    @IBOutlet weak var backgroundColorView: UIView!
    
    var course: Course? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        
        if let course = course {
            featuredImageVew.image = course.featuredImage
            courseLable.text = course.title
            backgroundColorView.backgroundColor = course.color
        } else {
            featuredImageVew.image = nil
            courseLable.text = nil
            backgroundColorView = nil
        }
    }
    
    override func layoutSubviews() {
        
        self.layer.cornerRadius = 3.0
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 10)
        
        self.clipsToBounds = false
    }
}
