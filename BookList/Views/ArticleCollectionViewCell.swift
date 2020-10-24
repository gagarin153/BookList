//
//  ArticleCollectionViewCell.swift
//  BookList
//
//  Created by Sultan on 24.10.2020.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ArticleCell"
    
    private let imageView: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .systemIndigo
        i.translatesAutoresizingMaskIntoConstraints = false
        i.layer.cornerRadius = 30.0
        return i
    }()
    
    private let textLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Топ 10 романов русской\n литературы"
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
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    
}
