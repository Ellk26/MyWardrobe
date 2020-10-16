//
//  WeatherViewController.swift
//  MyWardrobe
//
//  Created by elliott kung on 2020-09-21.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: WeatherVC components
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.placeholder = "Type a location"
        
        return searchBar
    }()
    
    
    
    // MARK: Components Constraint Setups
    
    func setSearchBarConstraints(){
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Weather"
        view.backgroundColor = .white
        
        // search bar
        view.addSubview(searchBar)
        setSearchBarConstraints()
        
    }
    
    
    
    
}
