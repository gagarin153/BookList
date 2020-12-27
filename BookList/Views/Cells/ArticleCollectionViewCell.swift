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
        let imageView = UIImageView()
        imageView.backgroundColor = .softGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "articleImage")
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Топ 10 романов русской литературы"
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(textLabel)
        self.setUpConstaints() 
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
