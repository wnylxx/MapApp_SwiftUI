//
//  MapViewModel.swift
//  SwiftUIMapKit
//
//  Created by wonyoul heo on 7/4/24.
//

import SwiftUI
import MapKit


struct SearchCompletions: Identifiable {
    let id = UUID()
    let title: String
    let subTitle: String
    
    var url: URL?
}


@Observable
class MapViewModel: NSObject, MKLocalSearchCompleterDelegate {
    private let completer = MKLocalSearchCompleter()
    
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var searchText = ""
    var mapStyle: MapStyle = .standard
    
    // MKLocalSearchCompletion 결과
    var completions = [SearchCompletions]()
    
    
    override init() {
        super.init()
        
        self.completer.delegate = self
    }
    
    
    func update(queryFragment: String) {
        completer.resultTypes = .pointOfInterest
        completer.queryFragment = queryFragment
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // completion result 중 title과 subtitle을 사용, url 가져오기
        completions = completer.results.map { completion in
            let mapItem = completion.value(forKey: "_mapItem") as? MKMapItem
            
            return .init(title: completion.title, subTitle: completion.subtitle, url: mapItem?.url)
        }
    }
    
    
}
