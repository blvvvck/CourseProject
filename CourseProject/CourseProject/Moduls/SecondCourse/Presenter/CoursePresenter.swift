//
//  CoursePresenter.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation

class CoursePresenter: CourseViewOutput, CourseInteractorOutput {
  
    weak var view: CourseViewInput!
    var interactor: CourseInteractorInput!
    
    func viewIsReady(with course: String) {
        view.prepareTableView()
        interactor.getStudentsByCourse(with: course)
    }
    
    func didFinishGetStudents(with models: [CellModelImplementation]) {
        view.set(cellModels: models)
        view.reloadTableView()
    }
    
}
