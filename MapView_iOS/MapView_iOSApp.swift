//
//  MapView_iOSApp.swift
//  MapView_iOS
//
//  Created by Koulik Maity on 22/08/23.
//

import SwiftUI

@main
struct MapView_iOSApp: App {
    
    @StateObject private var vm = LocationViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(vm)
        }
    }
}
