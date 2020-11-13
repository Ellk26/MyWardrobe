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
        label.text = "Weather"
        //label.layer.borderWidth = 1
        //label.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "questionmark.circle")
//        imageView.layer.borderWidth = 1
//        imageView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        imageView.frame = CGRect(x: 250, y: 50, width: 500, height: 100)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        //contentView.layer.borderWidth = 1
        //contentView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
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
        
        weatherImage.frame = CGRect(x: 0, y: 50, width: contentView.frame.size.width, height: contentView.frame.size.height/2)
    }
    
    func setLabel(location: String){
        label.text = location
    }
    
    func setIcon(iconID: String){
        switch iconID {
        case "01d":
            weatherImage.image = UIImage(systemName: "sun.max.fill")
        case "01n":
            weatherImage.image = UIImage(systemName: "sun.max")
        case "02d":
            weatherImage.image = UIImage(systemName: "cloud.sun.fill")
        case "02n":
            weatherImage.image = UIImage(systemName: "cloud.sun")
        case "03d":
            weatherImage.image = UIImage(systemName: "cloud.fill")
        case "03n":
            weatherImage.image = UIImage(systemName: "cloud")
        case "04d":
            weatherImage.image = UIImage(systemName: "cloud")
        case "04n":
            weatherImage.image = UIImage(systemName: "cloud")
        case "09d":
            weatherImage.image = UIImage(systemName: "cloud.rain.fill")
        case "10d":
            weatherImage.image = UIImage(systemName: "cloud.sun.rain.fill")
        case "11d":
            weatherImage.image = UIImage(systemName: "cloud.bolt.rain.fill")
        case "13d":
            weatherImage.image = UIImage(systemName: "snow")
        case "50d":
            weatherImage.image = UIImage(systemName: "cloud.fog.fill")
        default:
            weatherImage.image = UIImage(systemName: "questionmark.circle")
        }
    }
    
}
