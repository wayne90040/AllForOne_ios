//
//  PriceTableViewCell.swift
//  topic
//
//  Created by 許維倫 on 2019/7/10.
//  Copyright © 2019 許維倫. All rights reserved.
//

import UIKit

// 自製油價Cell
class PriceTableViewCell: UITableViewCell {

    @IBOutlet weak var oilView: UIView!
    @IBOutlet weak var unleadpriceLabel: UILabel!
    @IBOutlet weak var superpriceLabel: UILabel!
    @IBOutlet weak var supremepriceLabel: UILabel!
    @IBOutlet weak var diesepriceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
