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

// marker에 tag 달려면 hashable 해야함
struct SearchResult: Identifiable, Hashable {
    let id = UUID()
    let location: CLLocationCoordinate2D
    
    static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}



@Observable
class MapViewModel: NSObject, MKLocalSearchCompleterDelegate {
    private let completer = MKLocalSearchCompleter()
    
   
    var searchText = ""
    var mapStyle: MapStyle = .standard
    
    // MKLocalSearchCompletion 결과
    var completions = [SearchCompletions]()
    
    var searchResults: [MKMapItem] = []
    
    override init() {
        super.init()
        
        self.completer.delegate = self
    }
    
    
    func updateLocation(queryFragment: String) {
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
    
    func searchLocation(query: String, coordinate: CLLocationCoordinate2D? = nil) async throws -> [SearchResult] {
        print("Search")
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        
        let search = MKLocalSearch(request: request)
        
        if let coordinate {
            request.region = .init(.init(origin: .init(coordinate), size: .init(width: 1, height: 1)))
        }
        
        let response = try await search.start()
        
        return response.mapItems.compactMap { mapItem in
            guard let location = mapItem.placemark.location?.coordinate else { return nil }
            
            return .init(location: location)
        }
        
        
    }
    
    
}
