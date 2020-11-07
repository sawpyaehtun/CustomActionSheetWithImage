//
//  InternetProviderPhoneItemTableViewCell.swift
//  AKoneYa
//
//  Created by saw pyaehtun on 25/09/2020.
//  Copyright © 2020 iMac. All rights reserved.
//

import UIKit

class InternetProviderPhoneItemTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPhone: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(phoneNumber : String){
        lblPhone.text = phoneNumber
    }
    
}
