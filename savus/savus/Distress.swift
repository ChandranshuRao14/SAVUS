//
//  Distress.swift
//  savus
//
//  Created by Murtaza Hakimi on 1/28/18.
//  Copyright © 2018 Krishna  Madireddy. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Distress: NSObject, MKAnnotation{
    let title: String?
    let name: String?
    let severity: String
    let coordinate: CLLocationCoordinate2D
    var color: UIColor!
    
    init(name: String, severity: String, coordinate: CLLocationCoordinate2D){
        self.name = name
        self.severity = severity
        self.coordinate = coordinate
        self.title = severity
        self.color = .green
        
        super.init()
    }
    
    var subtitle: String?{
        return name
    }
    
    func mapItem() -> MKMapItem {
        let coord = CLLocationCoordinate2DMake(self.coordinate.latitude, self.coordinate.longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coord, addressDictionary: nil))
        mapItem.name = title
        return mapItem
    }
}
