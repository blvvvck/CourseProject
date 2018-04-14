//
//  SettingsInteractor.swift
//  CourseProject
//
//  Created by BLVCK on 12/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation

class SettingsInteractor: SettingsInteractorInput {
   
    var presenter: SettingsInteractorOutput!
    var dbManager: DbManager!
    
    func loadSettings() {
        if let settingsModel = dbManager.getDataFromDB() {
            presenter.didFinishLoadSettings(with: settingsModel)
            
        } else {
            presenter.didFinishLoadSettings(with: dbManager.getDefaultDataFromDB())
        }
    }
    
    func saveSettings(with mentor: String, and link: String, and sheetName: String, and range: String) {
        let settingsModel = SettingsModel(value: ["mentor": mentor, "link": link, "sheetName": sheetName, "range": range ])
        dbManager.addData(object: settingsModel)
    }
}
