//
//  CustomMenuCell.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//


import UIKit

class CustomMenuCell: UITableViewCell {
    let titleLabel = UILabel()
    let iconImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCustomCell()
    }
    
    func configCell(menu: String?) {
        if menu != nil {
            self.titleLabel.text = menu
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomMenuCell {
    func setupCustomCell() {
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
        ])
    }
}
