import UIKit
import Firebase

class LibraryViewController: UIViewController, BooksViewDelegate, IntrestingViewDelegate {
    
    private let activityIndicator = UIActivityIndicatorView()
    private let activityIndicatorView = UIView()
    private let scrollView = UIScrollView()
    private lazy var intrestingView = IntrestingView()
    private lazy var topBooksView = BooksView(description: "Топ 25")
    private lazy var editorChoiceBooksView = BooksView(description: "Выбор редакции")

    private lazy var activityIndicatorViewConstraints = [
        activityIndicatorView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        activityIndicatorView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        activityIndicatorView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
        activityIndicatorView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setUpActivityIndicatorView()
        self.setUpNavigationController()
        self.setUpViewsConstraints()
        self.fetchDataRequest()
        self.setUpViewsConstraints()
        self.topBooksView.delegate = self
        self.editorChoiceBooksView.delegate = self
        self.intrestingView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.editorChoiceBooksView.frame.maxY + 60)
    }
    
    private func setUpViewsConstraints() {
        self.setUpScrollViewConstraint()
        self.setUpIntrestingViewConstraint()
        self.setUpBooksViewConstraint()
    }
    
    private func setUpActivityIndicatorView() {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicatorView.backgroundColor = .softGray
        self.activityIndicatorView.addSubview(activityIndicator)
        
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.activityIndicatorView.centerYAnchor).isActive = true
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.activityIndicatorView.centerXAnchor).isActive = true
        
        NSLayoutConstraint.activate(activityIndicatorViewConstraints)
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    
    private func deactivateActivityIndicatorConstraint() {
        self.activityIndicator.stopAnimating()
        NSLayoutConstraint.deactivate(activityIndicatorViewConstraints)
    }
    
    func navigateTo(book: Book?) {
        let rootVC = BookViewController()
        rootVC.modalPresentationStyle = .fullScreen
        rootVC.book = book
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    func openArticle(article: Article?) {
        let rootVC = ArticleViewController()
        rootVC.article = article
        rootVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    func openFullList(books: [Book?], title: String?) {
        let rootVC = FullBooksViewController()
        rootVC.modalPresentationStyle = .fullScreen
        rootVC.books = books
        rootVC.title = title
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    private func fetchDataRequest(){
        
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        NetworkManager.shared.downloadGeneralBooks(limit: 20) { (result) in
            switch result  {
            case .success(let books):
                DispatchQueue.main.async {
                    self.topBooksView.setBooks(books: books)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        NetworkManager.shared.downloadEditorChoiceBooks { (result) in
            switch result  {
            case .success(let books):
                DispatchQueue.main.async {
                    self.editorChoiceBooksView.setBooks(books: books)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            dispatchGroup.leave()
        }
        
                dispatchGroup.enter()
                NetworkManager.shared.downloadArticles { (result) in
                    switch result  {
                    case .success(let articles):
                        DispatchQueue.main.async {
                        self.intrestingView.setArticles(articles: articles)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    dispatchGroup.leave()
                }
        
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.deactivateActivityIndicatorConstraint()
        }
    }
    
    private func setUpView() {
        self.view.addSubview(scrollView)
        [self.intrestingView, self.topBooksView, self.editorChoiceBooksView].forEach { self.scrollView.addSubview($0) }
        self.view.backgroundColor = .softGray
        self.view.addSubview(self.activityIndicatorView)
        self.scrollView.showsVerticalScrollIndicator = false
    }
    
    private func setUpNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Библиотека"
    }
    
    private func setUpScrollViewConstraint() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func setUpIntrestingViewConstraint() {
        intrestingView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        intrestingView.leadingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        intrestingView.trailingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        intrestingView.heightAnchor.constraint(equalToConstant: 260).isActive = true
    }
    
    private func setUpBooksViewConstraint() {
        topBooksView.topAnchor.constraint(equalTo: self.intrestingView.bottomAnchor, constant: 20).isActive = true
        topBooksView.leadingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        topBooksView.trailingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        topBooksView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        editorChoiceBooksView.topAnchor.constraint(equalTo: self.topBooksView.bottomAnchor, constant: 20).isActive = true
        editorChoiceBooksView.leadingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        editorChoiceBooksView.trailingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        editorChoiceBooksView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
    }
}

