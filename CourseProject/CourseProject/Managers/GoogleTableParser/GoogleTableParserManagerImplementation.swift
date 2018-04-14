//
//  GoogleTableParserManagerImplementation.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation
import GoogleAPIClientForREST
import GoogleSignIn

class GoogleTableParserManagerImplementation: GoogleTableParserManager {
   
    private let scopes = [kGTLRAuthScopeSheetsSpreadsheetsReadonly]
    private let service = GTLRSheetsService()
    var dbManager: DbManager!
    var students = [StudentModel]()
    
    func getStudentByCourse(with course: String, and completionBlock: @escaping ([StudentModel]?) -> ()) {
    
        let user = GIDSignIn.sharedInstance().currentUser
        self.service.authorizer = user?.authentication.fetcherAuthorizer()

        guard let settings = dbManager.getDataFromDB() else { return }
        let spreadsheetId = settings.link
        let range = settings.range
        let query = GTLRSheetsQuery_SpreadsheetsValuesGet.query(withSpreadsheetId: spreadsheetId, range: range)
        
        service.executeQuery(query) { [weak self] (ticket, result, error) in
            
            guard let strongSelf = self else { return }
            
            if error != nil {
                print("Error: \(String(describing: error?.localizedDescription))")
            } else {
                let castedResult = result as! GTLRSheets_ValueRange
                let rows = castedResult.values!
                
                for row in rows {
                    let student = StudentModel(name: row[0] as! String, group: row[1] as! String, theme: row[2] as! String, course: row[3] as! String, email: row[4] as! String)
                    if student.course == course {
                        strongSelf.students.append(student)
                    }
                    print(student)
                }
                completionBlock(strongSelf.students)
            }
        }
    }
}
