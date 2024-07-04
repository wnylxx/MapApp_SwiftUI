//
//  MapView.swift
//  SwiftUIMapKit
//
//  Created by wonyoul heo on 7/4/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var viewModel = MapViewModel()
    @State var style = 0
    
    var body: some View {
        VStack{
            Map(position: $viewModel.cameraPosition)
                .mapStyle(viewModel.mapStyle)
                .onChange(of: style) {
                    switch style {
                    case 0:
                        viewModel.mapStyle = .standard
                    case 1:
                        viewModel.mapStyle = .imagery
                    case 2:
                        viewModel.mapStyle = .hybrid
                    default:
                        viewModel.mapStyle = .standard
                    }
                }
            
            Picker("Map Style", selection:  $style) {
                Text("Standard").tag(0)
                Text("Imagery").tag(1)
                Text("Hybrid").tag(2)
            }
            .pickerStyle(.segmented)
        }
    }
}

#Preview {
    MapView()
}
