import UIKit
import Firebase

class BooksView: UIView {
    
    private var books: [Book?]?
    private let storage = Storage.storage()
    private var navigateTo: ((Book?)->())?
    private var openFullList: (([Book?], String?)->())?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fullListButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("см. все", for: .normal)
        button.addTarget(self, action: #selector(fullListButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private  let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        return view
    }()
        
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    init(description text: String, handler:  @escaping (Book?)->(), openFullList: @escaping ([Book?], String?)->() ) {
        self.init()
        self.descriptionLabel.text = text
        self.setUpViews()
        self.setUpConstraints()
        self.navigateTo = handler
        self.openFullList = openFullList
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBooks(books: [Book?]?) {
        self.books = books
        self.collectionView.reloadData()
    }
    
    private func setUpViews() {
        [self.descriptionLabel, self.fullListButton, self.containerView].forEach {self.addSubview($0)}
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(self.collectionView)
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.reuseIdentifier)
    }
    
    
    private  func setUpConstraints() {
        
        self.fullListButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.fullListButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        self.descriptionLabel.centerYAnchor.constraint(equalTo: self.fullListButton.centerYAnchor).isActive = true
        self.descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        self.containerView.topAnchor.constraint(equalTo: self.fullListButton.bottomAnchor, constant: 5).isActive = true
        self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.collectionView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20).isActive = true
    }
    
    @objc private  func fullListButtonTapped() {
        if let books = self.books {
            self.openFullList!(books, descriptionLabel.text)
        }
    }
    
    func getBooksCount() -> Int? {
        return books?.count
    }
}

extension BooksView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = books?.count else {return 0}
        return count > 5 ? 5 : count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.reuseIdentifier, for: indexPath)as? BookCollectionViewCell, let books = books  else { return  UICollectionViewCell()}
        
        cell.setCell(with: books[indexPath.item]!.name, imagePath: books[indexPath.item]!.imagePath)
        return cell 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let navigateTo = self.navigateTo else { return }
        
        navigateTo(books?[indexPath.item])
    }
    
}
