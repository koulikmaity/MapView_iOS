//
//  LocationListView.swift
//  MapView_iOS
//
//  Created by Koulik Maity on 07/09/23.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject private var vm : LocationViewModel
    
    var body: some View {
        List{
            ForEach(vm.locations) { location in
                Button {
                    vm.showNextLocation(location: location)
                } label: {
                    HStack{
                        if let imageName = location.imageNames.first {
                            Image(imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                        }
                    
                        VStack(alignment: .leading){
                            Text(location.name)
                                .font(.headline)
                            Text(location.cityName)
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 5)
    //                    .background(Color.red)
                    }
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
            .environmentObject(LocationViewModel())
    }
}
