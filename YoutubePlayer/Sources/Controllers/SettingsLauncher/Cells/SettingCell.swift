//
//  SettingCell.swift
//  YoutubePlayer
//
//  Created by André Campopiano on 20/03/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }

    var setting:Setting?{
        didSet{
            if let name = setting?.name {
                nameLabel.text = name.rawValue
            }
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named:imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    let nameLabel:UILabel = {
       
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
        
    }()
    
    let iconImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override func setupViews(){
        backgroundColor = UIColor.white
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        

        
    }
    
    
    
}
