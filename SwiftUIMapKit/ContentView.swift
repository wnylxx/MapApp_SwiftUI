//
//  ContentView.swift
//  SwiftUIMapKit
//
//  Created by wonyoul heo on 7/4/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State var isSheetPresented: Bool = false
    
    var body: some View {
        
        NavigationStack {
            ZStack{
                MapView()
                VStack{
                    Text("검색어를 입력하세요")
                        .background(Color.white)
                        .padding()
                        .onTapGesture {
                            isSheetPresented = true
                        }
                        .sheet(isPresented: $isSheetPresented) {
                            SheetView()
                        }
                    Spacer()
                }
                
            }
        }
    }
}


struct SheetView: View {
    @Environment(\.dismiss) var isSheetPresented
    
    @State private var viewModel = MapViewModel()
    @State var searchText: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("Search for a restaurant", text: $searchText)
                    .autocorrectionDisabled()
            }
            
            Spacer()
            
            List {
                ForEach(viewModel.completions) { completion in
                    Button(action: {}) {
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
            viewModel.update(queryFragment: searchText)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
