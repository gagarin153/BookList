import UIKit
import Firebase
import SwiftyJSON

class LibraryViewController: UIViewController {
    
    private let activityIndicator = UIActivityIndicatorView()
    private let scrollView = UIScrollView()
    private let intrestingView = IntrestingView()
    private let topHundredBooksView = BooksView(description: "Топ 100")
    private let editorChoiceBooksView = BooksView(description: "Выбор редакции")
    private let db = Firestore.firestore()
    private var jsonArray = [JSON]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpActivityIndicator()
        setUpNavigationController()
        fetchDataRequest()
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
    
    private func setUpActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func fetchDataRequest(){
        let group = DispatchGroup()
        
        group.enter()
        self.db.collection("Books").limit(to: 15).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.jsonArray.append(JSON(document.data()))
                }
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.setUpViewsConstraints()

            print(self.jsonArray)
        }
    }
    
    private func setUpView() {
        self.view.addSubview(activityIndicator)
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(intrestingView)
        self.scrollView.addSubview(topHundredBooksView)
        self.scrollView.addSubview(editorChoiceBooksView)
        
        self.view.backgroundColor = .softGray
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

