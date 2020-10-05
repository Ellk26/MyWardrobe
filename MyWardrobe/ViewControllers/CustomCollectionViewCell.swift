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
        let highlight = UIView()
        highlight.alpha = 0.5
        highlight.backgroundColor = .black
        highlight.isHidden = true
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
        contentView.layer.borderWidth = 1
//        contentView.addSubview(myLabel)
        contentView.addSubview(myImageView)
        contentView.clipsToBounds = true
        contentView.addSubview(highlightView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        myLabel.frame = CGRect(x: 5,
//                                            y: contentView.frame.size.height - 50,
//                                            width: contentView.frame.size.width - 10,
//                                            height: 50)
        
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
    
//    public func configure(label: String){
//        myLabel.text = label
//        
//    }
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        myLabel.text = nil
//    }
    
    
    
}
