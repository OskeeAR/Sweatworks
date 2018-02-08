//
//  UserCell.swift
//
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var lblName:     UILabel!    
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblBirthday: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ usr : CDUser) {
        lblName.text = usr.name
        lblLastName.text = usr.lastname
        lblBirthday.text = Utils.convertDateToString(usr.birthday!)
    }
    
}
