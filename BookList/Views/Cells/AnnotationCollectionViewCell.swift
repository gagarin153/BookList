//
//  AnnotationTableViewCell.swift
//  BookList
//
//  Created by Sultan on 25.12.2020.
//

import UIKit

class AnnotationCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "AnnotationCell"
    
    private lazy var width: NSLayoutConstraint = {
        let width = self.contentView.widthAnchor.constraint(equalToConstant: self.bounds.size.width)
        width.isActive = true
        return width
    }()
    
    var annotationText: String? {
        didSet {
            self.annotationLabel.text = annotationText
        }
    }
    
    private let annotationLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpContentView()
        self.setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        self.width.constant = self.bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    private func setUpContentView() {
        let radius: CGFloat = 10.0
        self.contentView.layer.cornerRadius = radius
        self.contentView.backgroundColor = .white
    }

    private func setUpLayout() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.annotationLabel)
        
        self.annotationLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        self.annotationLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        self.annotationLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20.0).isActive = true

        self.contentView.bottomAnchor.constraint(equalTo: self.annotationLabel.bottomAnchor, constant: 20).isActive = true
    }
   
}
