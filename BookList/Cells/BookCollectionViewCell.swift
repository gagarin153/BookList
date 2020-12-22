import UIKit
import Firebase
import Kingfisher


class BookCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "BookCell"
    
    private let imageView: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .white
        i.translatesAutoresizingMaskIntoConstraints = false
        i.layer.cornerRadius = 10.0
        return i
    }()
    
     private let textLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "Heiti TC", size: 11)
        l.text = "Книга"
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
    
    
    func setCell(with text: String, imagePath: String) {
        textLabel.text = text
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child(imagePath)

        imageRef.downloadURL { url, error in
            print(url)
          if let error = error {
            print(error.localizedDescription)
          } else {
            self.imageView.kf.setImage(with: url)
          }
        }
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
