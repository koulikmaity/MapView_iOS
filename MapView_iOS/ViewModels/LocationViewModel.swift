//
//  LocationViewModel.swift
//  MapView_iOS
//
//  Created by Koulik Maity on 23/08/23.
//

import Foundation
import MapKit

class LocationViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    // Current location on map
    @Published var mapLocation: Location {
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    
    // This is current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    
    // Show list of locations
    @Published var showLocationsList: Bool = false
    
    
    // Show location detail via sheet
    @Published var sheetLocation : Location? = nil
    
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        mapRegion = MKCoordinateRegion(
            center: location.coordinates, span: mapSpan
        )
    }
    
    func toggleLocationList(){
            showLocationsList.toggle()
    }
    
    func showNextLocation(location: Location){
        mapLocation = location
        showLocationsList = false
    }
    
    func nextButtonPressed(){
        
        // Get the current index
//        let currentIndex = locations.firstIndex { location in
//            location == mapLocation
//        }
        
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            print("Could not find current index in locatios array!")
            return
        }
        
        // Check for nextIndex is valid or not
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // nextIndex is not valid
            // Restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        // nextIndex is valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
        
    }
    
}
