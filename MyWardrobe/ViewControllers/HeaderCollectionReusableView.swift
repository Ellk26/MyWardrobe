//
//  HeaderCollectionReusableView.swift
//  MyWardrobe
//
//  Created by elliott kung on 2020-10-02.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "HeaderCollectionReuseableView"
    
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    public func configure(){
        backgroundColor = .white
        addSubview(searchBar)
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        searchBar.frame = bounds
    }
}
