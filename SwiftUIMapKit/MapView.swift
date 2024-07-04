//
//  MapView.swift
//  SwiftUIMapKit
//
//  Created by wonyoul heo on 7/4/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State var viewModel = MapViewModel()
    @State var style = 0
    @State var isSheetPresented: Bool = false
    @State var searchTitle = "검색어를 입력하세요"
    
    @State private var searchResults = [SearchResult]()
    
    
    var body: some View {
        ZStack{
            VStack{
                Map(position: $cameraPosition) {
                    ForEach(searchResults) { place in
                        Marker(coordinate: place.location) {
                            Image(systemName: "mappin.circle.fill")
                        }
                        .tag(place)
                    }
                }
                .mapStyle(viewModel.mapStyle)
                .mapControls {
                    MapScaleView()
                    MapUserLocationButton()
                }
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
            
            VStack{
                Text("\(searchTitle)")
                    .background(Color.white)
                    .padding()
                    .onTapGesture {
                        isSheetPresented = true
                    }
                    .sheet(isPresented: $isSheetPresented) {
                        SheetView(searchTitle: $searchTitle,isSheetPresented: $isSheetPresented, searchResults: $searchResults, cameraPosition: $cameraPosition)
                    }
                Spacer()
            }
        }
    }
}

#Preview {
    MapView()
}
