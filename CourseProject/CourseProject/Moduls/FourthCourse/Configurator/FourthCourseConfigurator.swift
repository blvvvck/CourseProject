//
//  FourthCourseConfigurator.swift
//  CourseProject
//
//  Created by BLVCK on 14/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation
import UIKit

class FourthCourseConfigurator {
    
    static let studentCourse = "4"
    
    static func setupModule(with viewController: FirstCourseViewController) {
        
        viewController.studentCourse = studentCourse
        let tableView = UITableView()
        viewController.tableView = tableView
        
        let presenter = CoursePresenter()
        let interactor = CourseInteractor()
        let dbManager = DbManagerImplementation()
        let parserManager = GoogleTableParserManagerImplementation()
        let dataSource = StudentsDataSource()
        
        viewController.presenter = presenter
        viewController.dataSource = dataSource
        presenter.view = viewController
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.tableParser = parserManager
        parserManager.dbManager = dbManager
    }
}
