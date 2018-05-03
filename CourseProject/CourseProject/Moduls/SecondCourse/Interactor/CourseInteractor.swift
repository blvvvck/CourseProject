//
//  CourseInteractor.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation

class CourseInteractor: CourseInteractorInput {
    

    var presenter: CourseInteractorOutput!
    var tableParser: GoogleTableParserManager!
   
    func getStudentsByCourse(with course: String) {
        var cellModels = [CellModelImplementation]()
        //let students = tableParser.getStudentByCourse(with: course)
        tableParser.getStudentByCourse(with: course) { (students) in
            if let studentsCheked = students {
                for student in studentsCheked {
                    let cellModel = CellModelImplementation(name: student.name, group: student.group, theme: student.theme, course: student.course, email: student.email)
                    cellModels.append(cellModel)
                }
                self.presenter.didFinishGetStudents(with: cellModels)
            }
        }
    }
}
