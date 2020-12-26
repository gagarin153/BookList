import UIKit

class DescriptionBookCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "DescriptionBookCell"
    
    private lazy var width: NSLayoutConstraint = {
        let width = self.contentView.widthAnchor.constraint(equalToConstant: self.bounds.size.width)
        width.isActive = true
        return width
    }()
    
    private let ratingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.borderWidth = 1.0
        button.setTitle("8.5", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let addDeleteToFavoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Добавить", for: .normal)
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Название: Преступление и наказание"
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.numberOfLines = 0
        label.text = "Автор: Ф.М. Достоевский"
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Жанр: роман, реализм, сатираы"
        return label
    }()
    
    private let publicationYearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Год публикации: 1809"
        return label
    }()
    
    
    private let bookImageView: UIImageView =  {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .softGray
       return imageView
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
        [self.bookImageView, self.ratingButton, self.addDeleteToFavoriteButton, self.nameLabel, self.authorLabel, self.genreLabel, self.publicationYearLabel].forEach {self.contentView.addSubview($0)}
                
        self.bookImageView.heightAnchor.constraint(equalToConstant: 215).isActive = true
        self.bookImageView.widthAnchor.constraint(equalToConstant: 140.0).isActive = true
        self.bookImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20 ).isActive = true
        self.bookImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20 ).isActive = true

        self.ratingButton.leadingAnchor.constraint(equalTo: self.bookImageView.trailingAnchor, constant: 20).isActive = true
        self.ratingButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        self.ratingButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.ratingButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        self.addDeleteToFavoriteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        self.addDeleteToFavoriteButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        self.addDeleteToFavoriteButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.addDeleteToFavoriteButton.widthAnchor.constraint(equalToConstant: 100).isActive = true

        self.nameLabel.leadingAnchor.constraint(equalTo: self.bookImageView.trailingAnchor, constant: 20).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.nameLabel.topAnchor.constraint(equalTo: self.ratingButton.bottomAnchor, constant: 10).isActive = true
        
        self.authorLabel.leadingAnchor.constraint(equalTo: self.bookImageView.trailingAnchor, constant: 20).isActive = true
        self.authorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.authorLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 10).isActive = true
        
        self.genreLabel.leadingAnchor.constraint(equalTo: self.bookImageView.trailingAnchor, constant: 20).isActive = true
        self.genreLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.genreLabel.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 10).isActive = true
        
        self.publicationYearLabel.leadingAnchor.constraint(equalTo: self.bookImageView.trailingAnchor, constant: 20).isActive = true
        self.publicationYearLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.publicationYearLabel.topAnchor.constraint(equalTo: self.genreLabel.bottomAnchor, constant: 10).isActive = true
        
        self.contentView.bottomAnchor.constraint(equalTo: self.bookImageView.bottomAnchor, constant: 20 ).isActive = true
    }
}
