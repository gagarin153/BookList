import UIKit
import Firebase

class ProfileViewController: UIViewController, BooksViewDelegate {
    
    private lazy var favoritesBooksView = BooksView(description: "Избранное")
    private var handle: AuthStateDidChangeListenerHandle?
    private var countOfFavoritsBook: Int?
    
    private let scrollView: UIScrollView = {
          let scrollView = UIScrollView()
          scrollView.translatesAutoresizingMaskIntoConstraints = false
          scrollView.showsVerticalScrollIndicator = false
          return scrollView
      }()
      
    
    private let  titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let title = "BookList"
        let titleTextSize: CGFloat = 80.0
        let textAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: titleTextSize)]
        label.attributedText = NSAttributedString(string: title, attributes: textAttribute)
        return label
    }()
    
    private let  descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        let title = "Сохрани понравившиеся книги"
        let titleTextSize: CGFloat = 25.0
        let textAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: titleTextSize)]
        label.attributedText = NSAttributedString(string: title, attributes: textAttribute)
        return label
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("Войти", for: .normal)
        let radius: CGFloat = 5.0
        button.layer.cornerRadius = radius
        button.addTarget(self, action: #selector(signInButtonStartTouch), for: .touchDown)
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(signInButtonCancelTapped), for: .touchDragExit)
        return button
    }()
    
    private let signOutButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("Выйти", for: .normal)
        let radius: CGFloat = 5.0
        button.layer.cornerRadius = radius
        button.addTarget(self, action: #selector(signOutButtonStartTouch), for: .touchDown)
        button.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(signOutButtonCancelTapped), for: .touchDragExit)
        return button
    }()
    
    private  let profileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemBlue
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 50.0
        label.textAlignment = .center
        label.textColor = .white
        let titleTextSize: CGFloat = 50.0
        let textAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: titleTextSize)]
        label.attributedText = NSAttributedString(string: " ", attributes: textAttribute)
        return label
    }()
    
    private  let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let titleTextSize: CGFloat = 30.0
        let textAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: titleTextSize)]
        label.attributedText = NSAttributedString(string: " ", attributes: textAttribute)
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15.0
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var initialConstraints = [
        self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 160.0),
        self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10.0),
        self.descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        
        self.signInButton.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 30.0),
        self.signInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        self.signInButton.heightAnchor.constraint(equalToConstant: 50.0),
        self.signInButton.widthAnchor.constraint(equalToConstant: 100.0)
    ]
    
    private lazy var profileConstraints = [
        
        self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        
        self.containerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20.0),
        self.containerView.leadingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
        self.containerView.trailingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        self.containerView.heightAnchor.constraint(equalToConstant: 200.0),
        
        self.profileLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 20),
        self.profileLabel.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
        self.profileLabel.widthAnchor.constraint(equalToConstant: 100.0),
        self.profileLabel.heightAnchor.constraint(equalToConstant: 100.0),

        self.nameLabel.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
        self.nameLabel.topAnchor.constraint(equalTo: self.profileLabel.bottomAnchor, constant: 20.0),

        self.favoritesBooksView.topAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 20.0),
        self.favoritesBooksView.leadingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
        self.favoritesBooksView.trailingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        self.favoritesBooksView.heightAnchor.constraint(equalToConstant: 220),

        self.signOutButton.topAnchor.constraint(equalTo:  self.containerView.topAnchor, constant: 8.0),
        self.signOutButton.heightAnchor.constraint(equalToConstant: 25.0),
        self.signOutButton.widthAnchor.constraint(equalToConstant: 80),
        self.signOutButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -8)
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .softGray
        self.title = "Профиль"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.favoritesBooksView.delegate = self
        self.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            self.setUpWindow()
        })
        
        if User.shared.userData?.favoriatBooks.count == 0 {
            let books =   User.shared.userData?.favoriatBooks
              self.countOfFavoritsBook = books?.count
              self.favoritesBooksView.setBooks(books: books)
        }
        if self.countOfFavoritsBook == nil && User.shared.userData?.favoriatBooks.count != nil {
          let books =   User.shared.userData?.favoriatBooks
            self.countOfFavoritsBook = books?.count
            self.favoritesBooksView.setBooks(books: books)
            
        }
        if self.countOfFavoritsBook != User.shared.userData?.favoriatBooks.count {
            self.fetchData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    func navigateTo(book: Book?) {
        let rootVC = BookViewController()
        rootVC.modalPresentationStyle = .fullScreen
        rootVC.book = book
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    func openFullList(books: [Book?], title: String?) {
        let rootVC = FullBooksViewController()
        rootVC.modalPresentationStyle = .fullScreen
        rootVC.books = books
        rootVC.title = title
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    private func setUpWindow() {
        
        if  let user = Auth.auth().currentUser  {
            
            NSLayoutConstraint.deactivate(self.initialConstraints)
            [self.titleLabel, self.descriptionLabel, self.signInButton].forEach { $0.removeFromSuperview() }
            if favoritesBooksView.getBooksCount() == nil { self.fetchData()}
            
            let dispatchgroup = DispatchGroup()
            dispatchgroup.enter()
            user.reload { _ in
                dispatchgroup.leave()
            }
            
            dispatchgroup.notify(queue: DispatchQueue.main) {
                //self.fetchData()
                self.navigationController?.navigationBar.isHidden = false
                self.view.addSubview(self.scrollView)
                [self.containerView, self.favoritesBooksView, self.signOutButton, self.profileLabel, self.nameLabel].forEach { self.scrollView.addSubview($0)}
               // User.shared.userData = UserData(authData: user)
                self.profileLabel.text = String(User.shared.userData?.name?.first ?? " ")
                self.nameLabel.text = User.shared.userData?.name
                NSLayoutConstraint.activate(self.profileConstraints)
            }
            
        } else {
            self.navigationController?.navigationBar.isHidden = true
            NSLayoutConstraint.deactivate(self.profileConstraints)
            [self.titleLabel, self.descriptionLabel, self.signInButton].forEach { self.view.addSubview($0) }
            [self.scrollView].forEach { $0.removeFromSuperview() }
            NSLayoutConstraint.activate(self.initialConstraints)
            self.favoritesBooksView.setBooks(books: nil)
        }
    }
    
    private func fetchData() {
        NetworkManager.shared.downloadFavoriatsBooks(for: Auth.auth().currentUser?.uid) { (result) in
            switch result  {
            case .success(let books):
                User.shared.userData?.favoriatBooks = books
                self.countOfFavoritsBook = books.count
                self.favoritesBooksView.setBooks(books: books)
            case .failure(let error):
               // self.favoritesBooksView.setBooks(books: nil)
                print(error.localizedDescription)
            }
        }
    }
    
    
    @objc private func signInButtonStartTouch (_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .init(scaleX:0.9, y: 0.9)
        }
        self.signInButton.backgroundColor = .lightGray
    }
    
    @objc private func signInButtonTapped (_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
        self.signInButton.backgroundColor = .black
        
        let vc = SignInViewController()
        vc.handler = self.setUpWindow
        
        let detailVC = UINavigationController(rootViewController: vc)
        self.showDetailViewController(detailVC, sender: self)
    }
    
    @objc private func signInButtonCancelTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
        self.signInButton.backgroundColor = .black
    }
    
    @objc private func signOutButtonStartTouch (_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .init(scaleX:0.9, y: 0.9)
        }
        self.signInButton.backgroundColor = .lightGray
    }
    
    @objc private func signOutButtonTapped (_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
        self.signInButton.backgroundColor = .black
        
        do {
            try Auth.auth().signOut()
        }
        catch { print("already logged out") }
        User.shared.userData = nil
    }
    
    @objc private func signOutButtonCancelTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
        self.signInButton.backgroundColor = .black
    }
    
}
