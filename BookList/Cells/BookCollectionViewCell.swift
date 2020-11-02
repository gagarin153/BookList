//
//  BookCollectionViewCell.swift
//  BookList
//
//  Created by Sultan on 27.10.2020.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "BookCell"
    
     let imageView: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .systemIndigo
        i.translatesAutoresizingMaskIntoConstraints = false
        i.layer.cornerRadius = 10.0
        return i
    }()
    
     let textLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "Heiti TC", size: 11)
        l.text = "Преступление и наказание"
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        self.addSubview(textLabel)
        
        setUpConstaints()
    }
    
    private func setUpConstaints() {        
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        textLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
}
