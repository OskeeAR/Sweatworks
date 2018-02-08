//
//  SWTestTests.swift
//  SWTestTests
//
//  Created by Nacho on 17/01/2018.
//

import XCTest

class CDUser {
    var name : String? = nil
    var lastName : String? = nil
    var birthday : Date? = nil
    
    convenience init(name: String, lastName : String, birthday : Date){
        self.init()
        self.name = name
        self.lastName = lastName
        self.birthday = birthday
    }
}

class MasterService {
    
    fileprivate let users: [CDUser]
    init(users: [CDUser]) {
        self.users = users
    }
    
    func getUsers() throws -> [CDUser] {
        return self.users
    }
    
}

class MasterView : NSObject{
    var setUsersCalled = false
    var setEmptyUsersCalled = false
    
    func getUsers() throws -> [CDUser] {
        setUsersCalled = true
        return []
    }
    
    func deleteUser(_ user : CDUser) throws {
        setUsersCalled = true
    }
    
}

class SWTestTests: XCTestCase {
    
    let listMasterServiceMock = MasterService(users:[CDUser.init(name: "firstname1", lastName: "lastname2", birthday: Date()), CDUser.init(name: "firstname2", lastName: "lastname2", birthday: Date())])
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMasterPresenter() {
        //given
        let userViewMock = MasterView()
        let userPresenterUnderTest = MasterPresenter(masterService: listMasterServiceMock)
        userPresenterUnderTest.attachView(userViewMock as! UserView)
        
        //when
        try? userPresenterUnderTest.getUsers()
        
        //verify
        XCTAssertTrue(userViewMock.setUsersCalled)
        
    }
    
}
