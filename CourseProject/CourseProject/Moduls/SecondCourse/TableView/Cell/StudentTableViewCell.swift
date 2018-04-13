//
//  StudentTableViewCell.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    
    func prepare(with model: CellModel) {
        nameLabel.text = model.name
        groupLabel.text = model.group
        themeLabel.text = model.theme
    }
    
}
