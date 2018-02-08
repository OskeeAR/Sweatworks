//
//  MasterService.swift
//  SWTest
//
//  Created by Nacho on 14/01/2018.
//

import UIKit
import CoreData

class MasterService {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func getUsers() throws -> [CDUser] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CDUser)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            return (result as? [CDUser])!
        }catch{
            print("Error retrieving users")
            throw error
        }
    }
    
    func deleteUser(_ user : CDUser) throws {
        context.delete(user)
        
        do {
            try context.save()
        } catch {
            print("Deletion failed!")
            throw error
        }
    }
    
}
