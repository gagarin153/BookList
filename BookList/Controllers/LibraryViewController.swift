import UIKit

class LibraryViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let intrestingView = IntrestingView()
    private let twentyFirstCenturyBooksView = BooksView(description: "21 век")
    private let twentyCenturyBooksView = BooksView(description: "20 век")
    private let nineteenthСenturyBooksView = BooksView(description: "19 век")
    private let eighteenthCenturyBooksView = BooksView(description: "18 век")
    private let earlytCreationBooksView = BooksView(description: "ранее творчество")
    
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
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: earlytCreationBooksView.frame.maxY + 40)
        
    }
    
    private func setUpView() {
        view.addSubview(scrollView)
        scrollView.addSubview(intrestingView)
        scrollView.addSubview(twentyFirstCenturyBooksView)
        scrollView.addSubview(twentyCenturyBooksView)
        scrollView.addSubview(nineteenthСenturyBooksView)
        scrollView.addSubview(eighteenthCenturyBooksView)
        scrollView.addSubview(earlytCreationBooksView)

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
        twentyFirstCenturyBooksView.topAnchor.constraint(equalTo: self.intrestingView.bottomAnchor, constant: 20).isActive = true
        twentyFirstCenturyBooksView.leadingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        twentyFirstCenturyBooksView.trailingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        twentyFirstCenturyBooksView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        twentyCenturyBooksView.topAnchor.constraint(equalTo: self.twentyFirstCenturyBooksView.bottomAnchor, constant: 20).isActive = true
        twentyCenturyBooksView.leadingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        twentyCenturyBooksView.trailingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        twentyCenturyBooksView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        nineteenthСenturyBooksView.topAnchor.constraint(equalTo: self.twentyCenturyBooksView.bottomAnchor, constant: 20).isActive = true
        nineteenthСenturyBooksView.leadingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        nineteenthСenturyBooksView.trailingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        nineteenthСenturyBooksView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        eighteenthCenturyBooksView.topAnchor.constraint(equalTo: self.nineteenthСenturyBooksView.bottomAnchor, constant: 20).isActive = true
        eighteenthCenturyBooksView.leadingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        eighteenthCenturyBooksView.trailingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        eighteenthCenturyBooksView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        earlytCreationBooksView.topAnchor.constraint(equalTo: self.eighteenthCenturyBooksView.bottomAnchor, constant: 20).isActive = true
        earlytCreationBooksView.leadingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        earlytCreationBooksView.trailingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        earlytCreationBooksView.heightAnchor.constraint(equalToConstant: 220).isActive = true
    }
}

