//
//  AqiDetailViewController.swift
//  topic
//
//  Created by 許維倫 on 2019/10/19.
//  Copyright © 2019 許維倫. All rights reserved.
//

import UIKit

class AqiDetailViewController: UIViewController {

    @IBOutlet weak var aqiViewA: UIView!
    @IBOutlet weak var aqiViewB: UIView!
    @IBOutlet weak var aqiViewC: UIView!
    
    @IBOutlet weak var aqiValueLbl: UILabel!
    @IBOutlet weak var aqiSLbl: UILabel!
    @IBOutlet weak var aqiPicImg: UIImageView!
    
    @IBOutlet weak var pmTValueLbl: UILabel!
    @IBOutlet weak var pmTwoSLbl: UILabel!
    @IBOutlet weak var pmTwoPicImg: UIImageView!
    
    @IBOutlet weak var pmTenValLbl: UILabel!
    @IBOutlet weak var coValueLbl: UILabel!
    @IBOutlet weak var soValueLbl: UILabel!
    @IBOutlet weak var othreValueLbl: UILabel!
    
    @IBOutlet weak var pmTenAvgLbl: UILabel!
    @IBOutlet weak var pmTwoAvgLbl: UILabel!
    
    @IBOutlet weak var countyLbl: UILabel!
    @IBOutlet weak var siteLbl: UILabel!
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    var aqi = AQI()
    
    
    // MARK: - view cyclelife
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setView()
    }

    
    func setView(){
        aqiViewA.layer.cornerRadius = 10
        aqiViewB.layer.cornerRadius = 10
        aqiViewC.layer.cornerRadius = 10
        
        aqiValueLbl.text? = aqi.AQI
        aqiSLbl.text? = aqi.AQIStatus
        pmTValueLbl.text? = aqi.PM25
        pmTwoSLbl.text? = aqi.PM25Status
        pmTenValLbl.text? = aqi.PM10
        coValueLbl.text? = aqi.Co
        soValueLbl.text? = aqi.So2
        othreValueLbl.text? = aqi.O3
        pmTenAvgLbl.text? = aqi.PM10Avg
        pmTwoAvgLbl.text? = aqi.PM25Avg
        countyLbl.text? = aqi.County
        siteLbl.text? = aqi.SiteName
        aqiPicImg.image = UIImage(named: aqi.getAQIImg())
        pmTwoPicImg.image = UIImage(named: aqi.getPM25Img())
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
