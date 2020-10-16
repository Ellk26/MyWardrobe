//
//  CustomCollectionViewCell.swift
//  MyWardrobe
//
//  Created by elliott kung on 2020-09-22.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.text = "Custom"
        label.textAlignment = .center
        return label
    }()
    
    private let highlightView: UIView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.frame = CGRect(x: 0,
                                                y: 0,
                                                width: 60,
                                                height: 60)
        imageView.tintColor = .white
        
        let highlight = UIView()
        highlight.alpha = 0.5
        highlight.backgroundColor = .black
        highlight.isHidden = true
        highlight.addSubview(imageView)
        
        return highlight
    }()
    
    override var isHighlighted: Bool{
        didSet{
            highlightView.isHidden = !isHighlighted
        }
    }
    
    override var isSelected: Bool{
        didSet{
            highlightView.isHidden = !isSelected
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 0
        contentView.addSubview(myImageView)
        contentView.clipsToBounds = true
        contentView.addSubview(highlightView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myImageView.frame = CGRect(x: 0,
                                               y: 0,
                                               width: contentView.frame.size.width,
                                               height: contentView.frame.size.height)
        
        highlightView.frame = CGRect(x: 0,
                                                  y: 0,
                                                  width: contentView.frame.size.width,
                                                  height: contentView.frame.size.height)
    }
    
    public func configureImage(image: UIImage){
        myImageView.image = image
    }
    
    
    
}
