//
//  ParkNTPCTableViewCell.swift
//  topic
//
//  Created by 許維倫 on 2019/11/10.
//  Copyright © 2019 許維倫. All rights reserved.
//

import UIKit

class ParkNTPCTableViewCell: UITableViewCell {

    @IBOutlet weak var parkView: UIView!
    @IBOutlet weak var haversine: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var payCash: UILabel!
    @IBOutlet weak var memo: UILabel!    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var parkinView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
