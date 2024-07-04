//
//  ContentView.swift
//  SwiftUIMapKit
//
//  Created by wonyoul heo on 7/4/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var searchText: String = ""
    @State var isSheetPresented: Bool = false
    
    var body: some View {
        
        NavigationStack {
            ZStack{
                MapView()
                VStack{
                    TextField("검색어를 입력하세요", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                        .background(Color.white)
                        .padding()
                    Spacer()
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
