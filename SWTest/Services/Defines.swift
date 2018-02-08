//
//  Defines.swift
//

import UIKit


struct Constants {
    static let userCell =        "UserCell"
    static let segueShowDetail = "showDetail"
    static let CDUser =          "CDUser"
    static let dateFormat =      "dd MMM yyyy"
    static let done =            NSLocalizedString("Done", comment: "")
    static let ok =              NSLocalizedString("Ok", comment: "")
    static let save =            NSLocalizedString("Save", comment: "")
    static let adding =          NSLocalizedString("Adding", comment: "")
    static let edit =            NSLocalizedString("Edit", comment: "")
    static let nameFieldError =  NSLocalizedString("Name field can't be empty", comment: "")
    static let lastnameFieldError = NSLocalizedString("Lastname field can't be empty", comment: "")
    static let errorTitle =       NSLocalizedString("Oops! Somethig is wrong..", comment: "")
    static let errorDeletion =    NSLocalizedString("Sorry, something went wrong.. could not delete user...", comment: "")
    static let errorLoadUsers =   NSLocalizedString("Something went wrong, could not load users!", comment: "")
    static let errorUserAdd =     NSLocalizedString("Sorry, something went wrong.. could not add user. Maybe the disk is full?", comment: "")
    static let errorUserUpdate =  NSLocalizedString("Sorry, something went wrong.. could not update user...", comment: "")
    
}

public enum EditionMode : Int {
    case add
    case edit
}

protocol UserView: NSObjectProtocol {
    func setUsers(_ users: [CDUser])
}
