//
//  WeatherCollectionViewCell.swift
//  topic
//
//  Created by 許維倫 on 2019/10/19.
//  Copyright © 2019 許維倫. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var hourLbl: UILabel!
    @IBOutlet weak var popLbl: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var maxTemLbl: UILabel!
    @IBOutlet weak var minTemLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
