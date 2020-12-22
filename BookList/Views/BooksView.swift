import UIKit
import Firebase

class BooksView: UIView {
    
    private var books = [Book]()
    private let storage = Storage.storage()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.backgroundColor = .clear
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private let descriptionLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let fullListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBlue
        label.text = "см. все"
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private  let containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 10.0
        return v
    }()
        
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    init(description text: String) {
        self.init()
        self.descriptionLabel.text = text
        self.setUpViews()
        self.setUpConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBooks(books: [Book]) {
        self.books = books
        self.collectionView.reloadData()
    }
    
    private func setUpViews() {
        self.addSubview(descriptionLabel)
        self.addSubview(fullListLabel)
        self.addSubview(containerView)
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.reuseIdentifier)
    }
    
    
    private  func setUpConstraints() {
        descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        fullListLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        fullListLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        containerView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20).isActive = true
    }
}

extension BooksView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  books.count <= 6 ? books.count : 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.reuseIdentifier, for: indexPath) as? BookCollectionViewCell else { return  UICollectionViewCell()}
        
        cell.setCell(with: books[indexPath.item].name, imagePath: books[indexPath.item].imagePath)
        return cell 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}
