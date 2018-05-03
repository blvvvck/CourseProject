//
//  HomeViewController.swift
//  CourseProject
//
//  Created by BLVCK on 29/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var courses = Course.fetchCourse()
    let cellScaling: CGFloat = 0.6
    let courseSegueIdentifier = "toCourseSugue"
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let screenSize = UIScreen.main.bounds.size
//        let cellWidth = floor(screenSize.width * cellScaling)
//        let cellHeight = floor(screenSize.height * cellScaling)
//        
//        let insetX = (view.bounds.width - cellWidth) / 2.0
//        let insetY = (view.bounds.height - cellHeight) / 2.0
//        
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
//        collectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
        
        //navigationController?.navigationBar.prefersLargeTitles = true
        //navigationItem.largeTitleDisplayMode = .always
         
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == courseSegueIdentifier {
            let courseVc = segue.destination as! FirstCourseViewController
            let courseIdentifier = sender as! Int
            switch courseIdentifier {
            case 2:
                courseVc.studentCourse = String(courseIdentifier)
            case 3:
                courseVc.studentCourse = String(courseIdentifier)
            case 4:
                courseVc.studentCourse = String(courseIdentifier)
            default:
                return
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCourseCell", for: indexPath) as! CourseCollectionViewCell
        cell.course = courses[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: courseSegueIdentifier, sender: 2)
        case 1:
            performSegue(withIdentifier: courseSegueIdentifier, sender: 3)
        case 2:
            performSegue(withIdentifier: courseSegueIdentifier, sender: 4)
        default:
            return
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: view.frame.height)
//    }
}
