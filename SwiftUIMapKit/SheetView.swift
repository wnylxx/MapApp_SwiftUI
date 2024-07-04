//
//  SheetView.swift
//  SwiftUIMapKit
//
//  Created by wonyoul heo on 7/4/24.
//

import SwiftUI
import MapKit

struct SheetView: View {
    @State private var viewModel = MapViewModel()
    @State var searchText: String = ""
    
    @Binding var searchTitle: String
    @Binding var isSheetPresented: Bool
    @Binding var searchResults: [SearchResult]
    @Binding var cameraPosition: MapCameraPosition
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("Search for a restaurant", text: $searchText)
                    .autocorrectionDisabled()
                    .onSubmit{
                        Task{
                            searchResults = (try? await viewModel.searchLocation(query: searchText)) ?? []
                        }
                        searchTitle = searchText
                        isSheetPresented = false
                    }
            }
            
            Spacer()
            
            List {
                ForEach(viewModel.completions) { completion in
                    Button(action: { didTapOnCompletion(completion)}) {
                        VStack(alignment: .leading) {
                            Text(completion.title)
                                .font(.headline)
                            Text(completion.subTitle)
                            
                            if let url = completion.url {
                                Link(url.absoluteString, destination: url)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .onChange(of: searchText) {
            viewModel.updateLocation(queryFragment: searchText)
        }
        .padding()
    }
    
    private func didTapOnCompletion(_ completion: SearchCompletions) {
        Task {
            if let singleLocation = try? await viewModel.searchLocation(query: "\(completion.title) \(completion.subTitle)").first {
                cameraPosition = .region(MKCoordinateRegion(center: singleLocation.location, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
                searchResults = [singleLocation]
            }
        }
        searchTitle = searchText
        isSheetPresented = false
    }
}








//
//#Preview {
//    SheetView()
//}
