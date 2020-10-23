//
//  WeatherCollectionViewCell.swift
//  MyWardrobe
//
//  Created by elliott kung on 2020-10-22.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "WeatherCollectionViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "hello"
        label.layer.borderWidth = 1
        label.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        contentView.frame = CGRect(x: 0, y: 0, width: 500, height: 100)
        contentView.addSubview(label)
        contentView.addSubview(weatherImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height/4)
        
        //weatherImage.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }
    
}
