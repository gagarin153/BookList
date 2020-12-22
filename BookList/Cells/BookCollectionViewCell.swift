import UIKit
import Firebase
import Kingfisher


class BookCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "BookCell"
    
    private let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .softGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Heiti TC", size: 11)
        label.text = "Книга"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpConstaints()
    }
    
    
    func setCell(with text: String, imagePath: String) {
        nameLabel.text = text
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
    
    
    private func setUpConstaints() {
        [self.bookImageView, self.nameLabel].forEach { self.contentView.addSubview($0) }
        
        self.bookImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.bookImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        self.bookImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15).isActive = true
        self.bookImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.nameLabel.topAnchor.constraint(equalTo: self.bookImageView.bottomAnchor, constant: 10).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
}
