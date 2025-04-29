//
//  CountrySearchPresenter.swift
//  CountrySearch
//
//  Created by Karen Bagotchay on 4/29/25.
//

import Foundation
import Combine

class CountrySearchPresenter {
    
    private let router: CountrySearchRouter
    
    required init(router: CountrySearchRouter) {
        self.router = router
    }
    
    private var cancellables: Set<AnyCancellable> = []
    private let datamanger = CountriesDataManager.shared
    
    func viewDidLoad() {
        setUpSubscibers()
        datamanger.fetchCountries()
    }
    
    private func setUpSubscibers() {
        
        CountriesDataManager.shared.getAllCountriesSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] requestStatus in
                guard let self else {
                    return
                }
                // TODO: Remove print
                print("Regions:")
                let regions = self.datamanger.countries.compactMap({ $0.region }).joined(separator: ", ")
                print(regions)
                
                print("Countries:")
                let countries = self.datamanger.countries.compactMap({ $0.commonName }).joined(separator: ",")
                print(countries)
                
            }
            .store(in: &cancellables)
    }
}
