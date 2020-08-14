//
//  AirQualityTableViewCell.swift
//  topic
//
//  Created by 許維倫 on 2019/7/20.
//  Copyright © 2019 許維倫. All rights reserved.
//

import UIKit

class AirQualityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var aqiImage: UIImageView!
    @IBOutlet weak var pmtwoImage: UIImageView!
    @IBOutlet weak var pmtwoLabel: UILabel!
    @IBOutlet weak var pmtwoStatueLb: UILabel!
    @IBOutlet weak var aqiStatusLb: UILabel!
    @IBOutlet weak var aqivalueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
