//
//  CountriesDataManager.swift
//  CountrySearch
//
//  Created by Karen Bagotchay on 4/29/25.
//

import Foundation
import Combine

class CountriesDataManager {
    
    static let shared = CountriesDataManager()
    
    private init() {}
    
    enum RequestStatus {
        case fetching
        case success
        case error(NetworkError)
    }
    
    private(set) var countries: [Country] = []
    
    var getAllCountriesSubject = PassthroughSubject<RequestStatus, Never>()
    
    func fetchCountries() {
        Task { [weak self] in
            guard let self else {
                return
            }
            self.getAllCountriesSubject.send(.fetching)
            let result = await APIClient.shared.getAllCountries()
            
            switch result {
            case .success(let countries):
                self.countries = countries
                self.getAllCountriesSubject.send(.success)
            case .failure(let error):
                self.getAllCountriesSubject.send(.error(error))
            }
        }
    }
}
