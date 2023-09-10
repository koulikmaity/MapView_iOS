//
//  Location.swift
//  MapView_iOS
//
//  Created by Koulik Maity on 22/08/23.
//

import Foundation
import MapKit

struct Location : Identifiable, Equatable{

    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    // Idetifiable
    var id: String {
        name + cityName
    }
    
    // Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id           // two locations has same id then that locations are same
    }
    
}
