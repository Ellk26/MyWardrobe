//
//  HeaderCollectionReusableView.swift
//  MyWardrobe
//
//  Created by elliott kung on 2020-10-02.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView, UISearchBarDelegate{
        
    static let identifier = "HeaderCollectionReuseableView"
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    public func configure() -> UISearchBar{
        backgroundColor = .white
        addSubview(searchBar)
        return searchBar
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        searchBar.frame = bounds
    }
    
}
