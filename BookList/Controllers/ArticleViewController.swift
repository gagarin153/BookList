import UIKit

class ArticleViewController: UIViewController {

    var article: Article?
    
    private let collectionView: UICollectionView = {
        var layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            let width = UIScreen.main.bounds.size.width
            layout.estimatedItemSize = CGSize(width: width, height: 1)
            return layout
        }()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FullArticleCollectionViewCell.self, forCellWithReuseIdentifier: FullArticleCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsSelection = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80.0, right: 0)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Интересное"
        self.setUpLayout()
    }
    
    private func setUpLayout() {
        [self.collectionView].forEach {self.view.addSubview($0)}
        
        self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension ArticleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = article?.titles.count  else { return 0 }
        return count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FullArticleCollectionViewCell.reuseIdentifier, for: indexPath) as? FullArticleCollectionViewCell, let article = article else { return UICollectionViewCell() }
        
        cell.setCell(title: article.titles[indexPath.row], text: article.annotation[indexPath.row], imagePath: article.imagePaths[indexPath.row])
        return cell
    }
    
}
