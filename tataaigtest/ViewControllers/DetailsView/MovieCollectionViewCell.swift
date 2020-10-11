//
//  MovieCollectionViewCell.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
   
    var moviePoster = UIImageView()
    var view: UIView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(moviePoster)
        moviePoster.contentMode = .scaleAspectFill
        moviePoster.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints : [NSLayoutConstraint] = [
            moviePoster.topAnchor.constraint(equalTo: contentView.topAnchor),
            moviePoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            moviePoster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            moviePoster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
}
