//
//  DetailPresenter.swift
//  SWTest
//
//  Created by Nacho on 14/01/2018.
//

import UIKit

protocol DetailView: NSObjectProtocol {
}

class DetailPresenter {
    fileprivate let detailService : DetailService
    weak fileprivate var detailView : DetailView?
    
    init(detailService:DetailService){
        self.detailService = detailService
    }
    
    func attachView(_ view:DetailView){
        detailView = view
    }
    
    func detachView() {
        detailView = nil
    }
    
    func saveUser(userName : String, userLastName : String, userBirthday : Date) throws {
        do{
            try detailService.saveUser(userName: userName, userLastName: userLastName, userBirthday: userBirthday)
        }catch{
            throw error
        }
    }
    
    func updateUser(_ user : CDUser) throws {
        do{
            try detailService.updateUser(user)
        }catch{
            throw error
        }
    }    
    
}
