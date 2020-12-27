import UIKit
import Firebase

class BookTableViewCell: UITableViewCell {
    static let reuseIdentifier = "BookTableViewCell"

    
    private let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .softGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Heiti TC", size: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 5.0
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func setUpLayout() {
        [self.containerView, self.bookImageView, self.nameLabel].forEach { self.contentView.addSubview($0) }
        
        self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5.0).isActive = true
        self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10.0).isActive = true
        self.containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10.0).isActive = true

        self.bookImageView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -10).isActive = true
        self.bookImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 10).isActive = true
        self.bookImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10).isActive = true
        self.bookImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.nameLabel.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: self.bookImageView.trailingAnchor, constant: 5).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -5).isActive = true

       // self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
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
    
    
}
