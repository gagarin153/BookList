import UIKit
import Firebase
import SwiftyJSON

class LibraryViewController: UIViewController {
    
    private let activityIndicator = UIActivityIndicatorView()
    private let activityIndicatorView = UIView()
    private let scrollView = UIScrollView()
    private let intrestingView = IntrestingView()
    private let topBooksView = BooksView(description: "Топ 100")
    private let editorChoiceBooksView = BooksView(description: "Выбор редакции")
    private let db = Firestore.firestore()
    private var topBooksJSONArray = [JSON]()
    private var editorChoiceBooksJSONArray = [JSON]()
    private lazy var activityIndicatorViewConstraints = [
        activityIndicatorView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        activityIndicatorView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        activityIndicatorView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
        activityIndicatorView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpActivityIndicatorView()
        setUpNavigationController()
        fetchDataRequest()
        delay(3) {
            self.deactivateConstraint()
        }
        setUpViewsConstraints()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.editorChoiceBooksView.frame.maxY + 60)
    }
    
    private func setUpViewsConstraints() {
        setUpScrollViewConstraint()
        setUpIntrestingViewConstraint()
        setUpBooksViewConstraint()
    }
    
    private func setUpActivityIndicatorView() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.backgroundColor = .softGray
        activityIndicatorView.addSubview(activityIndicator)
        
        activityIndicator.centerYAnchor.constraint(equalTo: self.activityIndicatorView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: self.activityIndicatorView.centerXAnchor).isActive = true
        
        NSLayoutConstraint.activate(activityIndicatorViewConstraints)
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    private func deactivateConstraint() {
        activityIndicator.stopAnimating()
        NSLayoutConstraint.deactivate(activityIndicatorViewConstraints)
    }
    
    private func fetchDataRequest(){
        
        let group1 = DispatchGroup()
        let group2 = DispatchGroup()
        
        group1.enter()
        self.db.collection("Books").limit(to: 6).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for  document in querySnapshot!.documents {
                    self.topBooksJSONArray.append(JSON(document.data()))
                    if self.topBooksJSONArray.count == querySnapshot!.documents.count {
                        group1.leave()
                    }
                }
            }
        }
        
        group2.enter()
        self.db.collection("Editor choice").limit(to: 1).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print(querySnapshot!.documents.count)
                for document in querySnapshot!.documents {
                    let ref = document.get("book") as? DocumentReference
                    ref?.getDocument { (bookDocument, error) in
                        if let bookDocument = bookDocument, bookDocument.exists {
                            self.editorChoiceBooksJSONArray.append(JSON( bookDocument.data()!))
                            if self.editorChoiceBooksJSONArray.count == querySnapshot!.documents.count {
                                group2.leave()
                            }
                        } else {
                            print("Document does not exist")
                        }
                    }
                    
                }
            }
        }
        
        group1.notify(queue: .main){
            self.topBooksView.setBooks(books: self.topBooksJSONArray)
        }
        
        group2.notify(queue: .main){
            self.editorChoiceBooksView.setBooks(books: self.editorChoiceBooksJSONArray)
        }
    }
    
    private func setUpView() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(intrestingView)
        self.scrollView.addSubview(topBooksView)
        self.scrollView.addSubview(editorChoiceBooksView)
        
        self.view.backgroundColor = .softGray
        self.view.addSubview(activityIndicatorView)
        
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

