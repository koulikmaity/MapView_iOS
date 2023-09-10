//
//  LocationView.swift
//  MapView_iOS
//
//  Created by Koulik Maity on 23/08/23.
//

import SwiftUI
import MapKit


struct LocationView: View {
    
    @EnvironmentObject private var vm: LocationViewModel
    
    //    @State private var mapRegion : MKCoordinateRegion = MKCoordinateRegion(
    //        center: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922),
    //        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        ZStack{
            maplayer
                .ignoresSafeArea()
            
            VStack(spacing: 0){
                header
                Spacer()
                LocationPreviewStack
                
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
            .environmentObject(LocationViewModel())
    }
}


extension LocationView {
    private var maplayer : some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
            //                MapMarker(coordinate: location.coordinates, tint: .red)
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.5)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        })
    }
}

extension LocationView {
    private var header : some View {
        VStack {
            Button {
                vm.toggleLocationList()
            } label: {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                //                            .background(Color.gray.opacity(0.3))
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: vm.showLocationsList ? "arrow.up" : "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                    }
            }
            
            
            if vm.showLocationsList{
                LocationListView()
            }
            
        }
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
        .padding()
    }
}

extension LocationView {
    private var LocationPreviewStack : some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 30)
                        .padding()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}
