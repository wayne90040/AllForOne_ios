//
//  GasPriceCell.swift
//  topic
//
//  Created by 許維倫 on 2019/5/20.
//  Copyright © 2019 許維倫. All rights reserved.
//

import UIKit

// 自製標準Cell 
class BasicTableViewCell: UITableViewCell {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
