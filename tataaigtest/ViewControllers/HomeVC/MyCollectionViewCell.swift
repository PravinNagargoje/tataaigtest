//
//  MyCollectionViewCell.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class MyCollectionViewCell: UICollectionViewCell {
    
    var poster = UIImageView()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpCell()
    }
    
    func cellConfig(movieData: MovieData) {
        if let poster = movieData.poster,
            let url = URL(string: "http://image.tmdb.org/t/p/w185/\(poster)")
        {
            self.poster.kf.setImage(with: url)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyCollectionViewCell {
    
    func setUpCell() {
        contentView.addSubview(poster)
        poster.contentMode = .scaleAspectFill
        poster.layer.cornerRadius = 7
        poster.clipsToBounds = true
        poster.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            
            poster.topAnchor.constraint(equalTo: contentView.topAnchor),
            poster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            poster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
