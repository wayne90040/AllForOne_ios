//
//  TemperatureTableViewCell.swift
//  topic
//
//  Created by 許維倫 on 2019/7/17.
//  Copyright © 2019 許維倫. All rights reserved.
//

import UIKit

protocol TableViewCell {
    func toDetail(title: String)
}

class TemperatureTableViewCell: UITableViewCell {
    
    @IBOutlet weak var aqiView: UIView!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var temperatureValue: UILabel!
    @IBOutlet weak var uviValue: UILabel!
    @IBOutlet weak var uviStatusLabel: UILabel!
    @IBOutlet weak var uviImage: UIImageView!
    @IBOutlet weak var temImage: UIImageView!
    
    @IBOutlet weak var aqiValue: UILabel!
    @IBOutlet weak var aqiStatus: UILabel!
    @IBOutlet weak var aqiImg: UIImageView!
    @IBOutlet weak var pmTwoValue: UILabel!
    @IBOutlet weak var pmTwoStatus: UILabel!
    @IBOutlet weak var pmTwoImg: UIImageView!
    
    // var tableviewcell: TableViewCell?
    var cellbuttonDelegate: CellButtonDelegate?
    
    @IBAction func weatherDeBtn(_ sender: Any) {
        cellbuttonDelegate?.toDetail(title: "toWeather")
    
    }
    
    @IBAction func aqiDeBtn(_ sender: Any) {
        cellbuttonDelegate?.toDetail(title: "toAqi")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
