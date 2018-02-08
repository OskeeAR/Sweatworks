//
//  MasterPresenter.swift
//  SWTest
//
//  Created by Nacho on 14/01/2018.
//

import UIKit
import CoreData

class MasterPresenter {
    
    fileprivate let masterService:MasterService
    weak fileprivate var userView : UserView?
    
    init(masterService:MasterService){
        self.masterService = masterService
    }
    
    func attachView(_ view:UserView){
        userView = view
    }
    
    func detachView() {
        userView = nil
    }
    
    func getUsers() throws {
        do{
            let users = try masterService.getUsers()
            self.userView?.setUsers(users)
        }catch{
            throw error
        }
    }
    
    func deleteUser(_ user : CDUser) throws {
        do{
            try masterService.deleteUser(user)
            try getUsers()
        }catch{
            throw error
        }
    }

    
}
