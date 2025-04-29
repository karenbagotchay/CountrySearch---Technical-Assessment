//
//  CountrySearchViewController.swift
//  CountrySearch
//
//  Created by Karen Bagotchay on 4/29/25.
//

import Foundation
import UIKit

class CountrySearchViewController: UIViewController {
    
    var configurator: CountrySearchConfigurator?
    var presenter: CountrySearchPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(viewController: self)
    }
}
