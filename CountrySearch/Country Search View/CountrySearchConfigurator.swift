//
//  CountrySearchConfigurator.swift
//  CountrySearch
//
//  Created by Karen Bagotchay on 4/29/25.
//

import Foundation

class CountrySearchConfigurator {
    
    func configure(viewController: CountrySearchViewController) {
        let router = CountrySearchRouter(viewController: viewController)
        let presenter = CountrySearchPresenter(router: router)
        viewController.presenter = presenter
    }
}
