import UIKit

class BookViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        var layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            let width = UIScreen.main.bounds.size.width - 16
            layout.estimatedItemSize = CGSize(width: width, height: 1)
            return layout
        }()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(DescriptionBookCollectionViewCell.self, forCellWithReuseIdentifier: DescriptionBookCollectionViewCell.reuseIdentifier)
        collectionView.register(AnnotationCollectionViewCell.self, forCellWithReuseIdentifier: AnnotationCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .softGray
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .softGray
        self.view.addSubview(collectionView)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80.0, right: 0)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Книга"
        self.setUpLayout()
    }
    
    private func setUpLayout() {
        self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DescriptionBookCollectionViewCell.reuseIdentifier, for: indexPath) as? DescriptionBookCollectionViewCell else { return UICollectionViewCell() }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnnotationCollectionViewCell.reuseIdentifier, for: indexPath) as? AnnotationCollectionViewCell else { return UICollectionViewCell() }
            return cell
        }
    }
    
   
}
