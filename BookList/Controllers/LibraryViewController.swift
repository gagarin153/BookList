import UIKit

class LibraryViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let intrestingView = IntrestingView()
    private let topHundredBooksView = BooksView(description: "Топ 100")
    private let editorChoiceBooksView = BooksView(description: "Выбор редакции")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpNavigationController()
        setUpScrollViewConstraint()
        setUpIntrestingViewConstraint()
        setUpBooksViewConstraint()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: editorChoiceBooksView.frame.maxY + 60)
        
    }
    
    private func setUpView() {
        view.addSubview(scrollView)
        scrollView.addSubview(intrestingView)
        scrollView.addSubview(topHundredBooksView)
        scrollView.addSubview(editorChoiceBooksView)

        view.backgroundColor = .softGray
    }
        
    private func setUpNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Библиотека"
    }
    
    private func setUpScrollViewConstraint() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
    
    private func setUpIntrestingViewConstraint() {
        intrestingView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        intrestingView.leadingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        intrestingView.trailingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        intrestingView.heightAnchor.constraint(equalToConstant: 260).isActive = true
    }
    
    private func setUpBooksViewConstraint() {
        topHundredBooksView.topAnchor.constraint(equalTo: self.intrestingView.bottomAnchor, constant: 20).isActive = true
        topHundredBooksView.leadingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        topHundredBooksView.trailingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        topHundredBooksView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        editorChoiceBooksView.topAnchor.constraint(equalTo: self.topHundredBooksView.bottomAnchor, constant: 20).isActive = true
        editorChoiceBooksView.leadingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        editorChoiceBooksView.trailingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        editorChoiceBooksView.heightAnchor.constraint(equalToConstant: 220).isActive = true
    }
}

