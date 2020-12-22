import UIKit

class ProfileViewController: UIViewController {

    private let  titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let title = "BookList"
        let titleTextSize: CGFloat = 80.0
        let textAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: titleTextSize)]
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .softGray
        navigationController?.navigationBar.isHidden = true
        self.setUpConstaints()
    }
    
    private func setUpConstaints() {
        [self.titleLabel, self.signInButton].forEach { self.view.addSubview($0) }
        
        self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 200.0).isActive = true
        self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        self.signInButton.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 40.0).isActive = true
        self.signInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.signInButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        self.signInButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
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
        
    }
    
    @objc private func signInButtonCancelTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
        self.signInButton.backgroundColor = .black
    }
    
}
