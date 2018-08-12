//
//  NewsTableViewCell.swift
//  DNSG
//
//  Created by The Dung on 8/4/18.
//  Copyright © 2018 The Dung. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var pubdateLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInformation(info: NewsItem) {
        titleLbl.text = info.title
        pubdateLbl.text = info.pubDate
        contentLbl.text = info.describe
        authorLbl.text = info.author
    }
}
