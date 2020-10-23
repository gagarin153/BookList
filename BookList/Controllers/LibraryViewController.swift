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
        view.addSubview(intrestingView)
        view.backgroundColor = .softGray
    }
        
    private func setUpNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Библиотека"
    }
    
    private func setUpScrollViewConstraint() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 1500)
    }
    
    private func setUpIntrestingViewConstraint() {
        intrestingView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        intrestingView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        intrestingView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        intrestingView.heightAnchor.constraint(equalToConstant: 240).isActive = true
    }
}

