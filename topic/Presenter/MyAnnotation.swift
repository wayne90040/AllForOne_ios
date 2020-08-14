//
//  MyAnnotation.swift
//  topic
//
//  Created by 許維倫 on 2019/10/31.
//  Copyright © 2019 許維倫. All rights reserved.
//

import Foundation
import MapKit

class MyAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D){
        self.coordinate = coordinate
    }
}
