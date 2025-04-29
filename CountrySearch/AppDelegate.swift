//
//  AppDelegate.swift
//  CountrySearch
//
//  Created by Karen Bagotchay on 4/29/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootViewController = CountrySearchViewController()
        rootViewController.configurator = .init()
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}

