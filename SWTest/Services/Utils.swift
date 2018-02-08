//
//  Utils.swift
//

import UIKit

class Utils {
    static func convertDateToString(_ date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        return  dateFormatter.string(from:date)
    }
    
    static func showErrorWithMsg(_ text : String, viewController : UIViewController) {
        let alert = UIAlertController(title: Constants.errorTitle, message: text, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: Constants.ok, style: UIAlertActionStyle.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
