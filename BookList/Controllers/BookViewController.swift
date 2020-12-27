import UIKit
import Firebase

class BookViewController: UIViewController {
    
    var book: Book?
    private var handle: AuthStateDidChangeListenerHandle?
    
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
        collectionView.allowsSelection = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .softGray
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80.0, right: 0)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Книга"
        self.setUpLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
  
    
    private func setUpLayout() {
        [self.collectionView].forEach {self.view.addSubview($0)}
        
        self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DescriptionBookCollectionViewCell.reuseIdentifier, for: indexPath) as? DescriptionBookCollectionViewCell else { return UICollectionViewCell() }
            cell.book = book
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnnotationCollectionViewCell.reuseIdentifier, for: indexPath) as? AnnotationCollectionViewCell else { return UICollectionViewCell() }
            cell.annotationText = book?.annotation
            return cell
        }
    }
    
   
}

extension BookViewController {
   @objc func addDeleteToFavoriteButtonTapped() {
        let db = Firestore.firestore()
        let path = book?.id ?? " "

    guard let user = User.shared.userData else {
        
        let vc = SignInViewController()
        vc.handler = {
            self.delay(1) {
                self.collectionView.reloadData()
            }
        }
        let detailVC = UINavigationController(rootViewController: vc)
        self.showDetailViewController(detailVC, sender: self)
        return
        
    }
        if  !(user.favoriatBooks.contains(book))   {
            db.collection("Favoriats").document((User.shared.userData?.uid) ?? " ").updateData([
                "favoriatsBook": FieldValue.arrayUnion([db.document("/Books/\(path)")])
            ])
            User.shared.userData?.favoriatBooks.append(book)
        } else {
            db.collection("Favoriats").document((User.shared.userData?.uid) ?? " ").updateData([
                "favoriatsBook": FieldValue.arrayRemove([db.document("/Books/\(path)")])
            ])
            User.shared.userData?.favoriatBooks.removeAll(where: {$0 == book})
        }
        self.collectionView.reloadData()
    }
}
