//
//  StarRatingCell.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//


import UIKit
import Cosmos

class StarRatingCell: UITableViewCell {

    var cosmosView = CosmosView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupStarCosmosView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(rating: CGFloat?) {
        var value: Double = 0
        if let vote = rating {
            value = Double(vote)/2
        }
        self.cosmosView.rating = value
    }
}

extension StarRatingCell {
    
    func setupStarCosmosView() {
        self.contentView.addSubview(self.cosmosView)
        self.cosmosView.settings.updateOnTouch = false
        self.cosmosView.settings.fillMode = .half
        self.cosmosView.settings.starSize = 30
        self.cosmosView.translatesAutoresizingMaskIntoConstraints = false
        cosmosView.topAnchor.constraint(equalTo: self.contentView.topAnchor , constant : 8).isActive = true
        cosmosView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant : 16).isActive = true
    }
}
