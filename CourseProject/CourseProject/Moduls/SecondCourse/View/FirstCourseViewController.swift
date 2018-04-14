//
//  FirstCourseViewController.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class FirstCourseViewController: UIViewController, CourseViewInput {    
    

    var dataSource: StudentsDataSource!
    var presenter: CourseViewOutput!
    let studentCellNibIdentifier = "StudentTableViewCell"
    let studentCellIdentifier = "studentCell"
    let estimatedRowHeight: CGFloat = 100
    var studentCourse: String = "2"
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewIsReady(with: studentCourse)
        
    }
    
    func prepareTableView() {
        tableView.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
        self.view.addSubview(tableView)
        registerCell()
        tableView.estimatedRowHeight = estimatedRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func set(cellModels: [CellModel]?) {
        guard let checkedCellModels = cellModels else { return }
        dataSource.setCellModels(with: checkedCellModels)
    }
    
    private func registerCell() {
        let mediaCellNib = UINib(nibName: studentCellNibIdentifier, bundle: nil)
        self.tableView.register(mediaCellNib, forCellReuseIdentifier: studentCellIdentifier)
    }

}
