//
//  CountryCell.swift
//  SujitIOSTest
//
//  Created by Admin on 12/17/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {
    @IBOutlet weak var countryImg: UIImageView!
    @IBOutlet weak var countryTitleLbl: UILabel!
    @IBOutlet weak var countryDescriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
