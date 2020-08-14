//
//  WeatherPicTableViewCell.swift
//  topic
//
//  Created by 許維倫 on 2019/10/18.
//  Copyright © 2019 許維倫. All rights reserved.
//

import UIKit

class WeatherPicTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherPicView: UIView!
    @IBOutlet weak var weatherPicImg: UIImageView!
    @IBOutlet weak var temLbl: UILabel!
    @IBOutlet weak var rainfallLbl: UILabel!
    @IBOutlet weak var clothesImg: UIImageView!
    @IBOutlet weak var activityImg: UIImageView!
    @IBOutlet weak var activity_Img: UIImageView!
    @IBOutlet weak var wxLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
