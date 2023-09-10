//
//  LocationPreviewView.swift
//  MapView_iOS
//
//  Created by Koulik Maity on 07/09/23.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var vm : LocationViewModel
    
    let location : Location
    
    var body: some View {
        HStack (alignment: .bottom){
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            
            VStack(spacing: 8) {
                learnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            LocationPreviewView(location: LocationsDataService.locations.first!)
                .padding()
        }
        .environmentObject(LocationViewModel())
    }
}

extension LocationPreviewView {
    private var imageSection : some View {
        ZStack{
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
}


extension LocationPreviewView {
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 14){
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension LocationPreviewView {
    private var learnMoreButton: some View {
        Button {
            vm.sheetLocation = location
        } label: {
            Text("Learn more")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
    
}
