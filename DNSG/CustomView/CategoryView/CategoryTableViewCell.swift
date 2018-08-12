//
//  CategoryTableViewCell.swift
//  DNSG
//
//  Created by The Dung on 8/4/18.
//  Copyright © 2018 The Dung. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInformation(title: String) {
        titleLbl.text = title
    }
}
