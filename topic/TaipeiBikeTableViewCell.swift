//
//  TaipeiBikeTableViewCell.swift
//  topic
//
//  Created by 許維倫 on 2019/10/30.
//  Copyright © 2019 許維倫. All rights reserved.
//

import UIKit

class TaipeiBikeTableViewCell: UITableViewCell {
    var cellbuttonDelegate: CellButtonDelegate?
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var bikeView: UIView!
    @IBOutlet weak var closeView: UIView!
    
    @IBOutlet weak var closeTitleLbl: UILabel!
    @IBOutlet weak var closeStationLbl: UILabel!
    @IBOutlet weak var closeRentCnt: UILabel!
    @IBOutlet weak var closeReturnCnt: UILabel!
    
    @IBAction func bikeBtn(_ sender: Any) {
        cellbuttonDelegate?.toDetail(title: "toBikeMap")
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
