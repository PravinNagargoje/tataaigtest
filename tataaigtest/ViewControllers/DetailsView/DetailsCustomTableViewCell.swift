//
//  DetailsCustomTableViewCell.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class DetailsCustomTableViewCell: UITableViewCell {

    let txtLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       setupCell()
   }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData(data: String?) {        
        if let value = data {
            self.txtLabel.text = value
        }
    }
}

extension DetailsCustomTableViewCell{
    
    func setupCell(){
        txtLabel.numberOfLines = 0
        txtLabel.lineBreakMode = .byWordWrapping
        
        self.contentView.addSubview(txtLabel)
        txtLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints : [NSLayoutConstraint] = [
            txtLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            txtLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -8),
            txtLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            txtLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            txtLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 26)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
}
