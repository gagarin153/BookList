import UIKit
import Firebase

class FullArticleCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "FullArticleCollectionViewCell"

    private lazy var width: NSLayoutConstraint = {
        let width = self.contentView.widthAnchor.constraint(equalToConstant: self.bounds.size.width)
        width.isActive = true
        return width
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.numberOfLines = 0
        label.text = "Интересное"
        return label
    }()
    
    private let bookImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .softGray
        return imageView
    }()
    
    private let textLabel: UILabel = {
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
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpLayout() {
        [self.titleLabel, self.bookImageView, self.textLabel].forEach {self.contentView.addSubview($0)}
        
        
        self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20.0).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20.0).isActive = true

        
        self.bookImageView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20).isActive = true
        self.bookImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.bookImageView.heightAnchor.constraint(equalToConstant: 350.0).isActive = true
        self.bookImageView.widthAnchor.constraint(equalToConstant: 230.0).isActive = true
        
        self.textLabel.topAnchor.constraint(equalTo: self.bookImageView.bottomAnchor, constant: 20).isActive = true
        self.textLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.textLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true

        self.contentView.bottomAnchor.constraint(equalTo: self.textLabel.bottomAnchor, constant: 20 ).isActive = true
    }
    
    func setCell(title: String, text: String, imagePath: String) {
        self.titleLabel.text = title
        self.textLabel.text = text
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child(imagePath)
        
        imageRef.downloadURL { url, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.bookImageView.kf.setImage(with: url)
            }
        }
    }
    
}
