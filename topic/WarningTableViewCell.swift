//
//  WarningTableViewCell.swift
//  topic
//
//  Created by 許維倫 on 2019/11/11.
//  Copyright © 2019 許維倫. All rights reserved.
//

import UIKit

class WarningTableViewCell: UITableViewCell {

    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var warning: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
