import UIKit

class LibraryViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    
    private let intrestingView = IntrestingView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpNavigationController()
        setUpScrollViewConstraint()
        setUpIntrestingViewConstraint()
    }
    
    private func setUpView() {
        view.addSubview(scrollView)
        scrollView.addSubview(intrestingView)
        view.backgroundColor = .softGray
    }
        
    private func setUpNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Библиотека"
    }
    
    private func setUpScrollViewConstraint() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 300)

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
}

