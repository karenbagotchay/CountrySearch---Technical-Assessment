//
//  CountrySearchViewController.swift
//  CountrySearch
//
//  Created by Karen Bagotchay on 4/29/25.
//

import Foundation
import UIKit
import TinyConstraints

class CountrySearchViewController: UIViewController {
    
    var configurator: CountrySearchConfigurator?
    var presenter: CountrySearchPresenter?
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let nameField: UITextField = {
        let textfield = UITextField()
        textfield.layer.borderColor = UIColor.gray.cgColor
        textfield.layer.borderWidth = 1
        return textfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(viewController: self)
        presenter?.viewDidLoad()
        setUpView()
        setUpConstraints()
    }
    
    private func setUpView() {
        view.addSubview(mainView)
        mainView.addSubview(nameField)
    }
    
    private func setUpConstraints() {
        mainView.edgesToSuperview()
    }
}
