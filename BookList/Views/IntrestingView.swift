import UIKit

protocol IntrestingViewDelegate {
    func openArticle(article: Article?) ->()
}

class IntrestingView: UIView {
    
    private var articles: [Article?]?
    var delegate: IntrestingViewDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let intrestingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.text = "Интересное"
        return label
    }()
    
    private  let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 30.0
        return view
    }()
    
    private  let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Далее", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10.0
        button.backgroundColor = .black  //.whiteGray
        return button
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.setUpViews()
        self.setUpConstraints()
    }
    
    func setArticles(articles: [Article?]?) {
        self.articles = articles
        self.collectionView.reloadData()
    }
    
    private func setUpViews() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(intrestingLabel)
        self.addSubview(containerView)
        containerView.addSubview(collectionView)
        containerView.addSubview(nextButton)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ArticleCollectionViewCell.self, forCellWithReuseIdentifier: ArticleCollectionViewCell.reuseIdentifier)
    }
    
    private  func setUpConstraints() {
        intrestingLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        intrestingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        containerView.topAnchor.constraint(equalTo: intrestingLabel.bottomAnchor, constant: 5).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -5).isActive = true
        
        nextButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 145).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IntrestingView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCollectionViewCell.reuseIdentifier, for: indexPath) as? ArticleCollectionViewCell, let article = articles?[indexPath.row] else { return UICollectionViewCell() }
        
        cell.setCell(with: article.name, imagePath: article.mainImagePath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.openArticle(article: articles?[indexPath.item])
    }
    
}

