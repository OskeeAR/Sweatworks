//
//  DetailService.swift
//  SWTest
//
//  Created by Nacho on 14/01/2018.
//

import UIKit
import CoreData

class DetailService {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveUser(userName : String, userLastName : String, userBirthday : Date) throws {
        let entity = NSEntityDescription.entity(forEntityName: Constants.CDUser, in: context)
        let newUser = CDUser.init(entity: entity!, insertInto: context)
        
        newUser.name = userName
        newUser.lastname = userLastName
        newUser.birthday = userBirthday
        
        do {
            try context.save()
        } catch {
            print("Failed saving user")
            throw error
        }
    }
    
    
    func updateUser(_ user : CDUser) throws {
        do {
            try context.save()
        } catch {
            print("Updating object failed..!")
            throw error
        }
    }
    
}
