import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    var handler = {}
    private let signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("вход", for: .normal)
        let radius: CGFloat = 5.0
        button.layer.cornerRadius = radius
        button.addTarget(self, action: #selector(signInButtonStartTouch), for: .touchDown)
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(signInButtonCancelTapped), for: .touchCancel)
        button.addTarget(self, action: #selector(signInButtonDragAwayTapped), for: .touchDragExit)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.borderWidth = 1.0
        button.setTitle("регистрация", for: .normal)
        button.setTitleColor(.black, for: .normal)
        let radius: CGFloat = 5.0
        button.layer.cornerRadius = radius
        button.addTarget(self, action: #selector(signUpButtonStartTouch), for: .touchDown)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(signUpButtonCancelTapped), for: .touchCancel)
        button.addTarget(self, action: #selector(signUpButtonDragAwayTapped), for: .touchDragExit)
        return button
    }()
    
    private let confirmSignUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("зарегистрировать", for: .normal)
        let radius: CGFloat = 5.0
        button.layer.cornerRadius = radius
        button.addTarget(self, action: #selector(confirmSignUpButtonStartTouch), for: .touchDown)
        button.addTarget(self, action: #selector(confirmSignUpButtonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(confirmSignUpButtonCancelTapped), for: .touchCancel)
        button.addTarget(self, action: #selector(confirmSignUpButtonDragAwayTapped), for: .touchDragExit)
        return button
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.text = "Почта"
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.text = "Пароль"
        return label
    }()
    
    private let repeatPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.text = "Пароль"
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.text = "Имя"
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField =  UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.placeholder = "Введите вашу почту"
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField =  UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.placeholder = "Введите ваш пароль"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let repeatPasswordTextField: UITextField = {
        let textField =  UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.placeholder = "Повторите ваш пароль"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let nameTextField: UITextField = {
        let textField =  UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.placeholder = "Введите ваше имя"
        return textField
    }()
    
    private lazy var signInConstraints = [
        self.emailLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100.0),
        self.emailLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 80.0),
        self.emailLabel.widthAnchor.constraint(equalToConstant: 80),
        self.emailLabel.heightAnchor.constraint(equalToConstant: 25),
        self.emailTextField.topAnchor.constraint(equalTo: self.emailLabel.topAnchor),
        self.emailTextField.leadingAnchor.constraint(equalTo: self.emailLabel.trailingAnchor, constant: 10.0),
        self.emailTextField.widthAnchor.constraint(equalToConstant: 200),
        self.emailTextField.heightAnchor.constraint(equalToConstant: 25),
        
        self.passwordLabel.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 20.0),
        self.passwordLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 80.0),
        self.passwordLabel.widthAnchor.constraint(equalToConstant: 80),
        self.passwordLabel.heightAnchor.constraint(equalToConstant: 25),
        self.passwordTextField.topAnchor.constraint(equalTo: self.passwordLabel.topAnchor),
        self.passwordTextField.leadingAnchor.constraint(equalTo: self.passwordLabel.trailingAnchor, constant: 10),
        self.passwordTextField.widthAnchor.constraint(equalToConstant: 200),
        self.passwordTextField.heightAnchor.constraint(equalToConstant: 25),
        
        self.signInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        self.signInButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 40.0),
        self.signInButton.widthAnchor.constraint(equalToConstant: 130.0),
        self.signInButton.heightAnchor.constraint(equalToConstant: 50.0),
        
        self.signUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        self.signUpButton.topAnchor.constraint(equalTo: self.signInButton.bottomAnchor, constant: 20.0),
        self.signUpButton.widthAnchor.constraint(equalToConstant: 130.0),
        self.signUpButton.heightAnchor.constraint(equalToConstant: 50.0)
    ]
    
    
    private lazy var signUpConstraints = [
        self.nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100.0),
        self.nameLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 80.0),
        self.nameLabel.widthAnchor.constraint(equalToConstant: 80),
        self.nameLabel.heightAnchor.constraint(equalToConstant: 25),
        self.nameTextField.topAnchor.constraint(equalTo: self.nameLabel.topAnchor),
        self.nameTextField.leadingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor, constant: 10.0),
        self.nameTextField.widthAnchor.constraint(equalToConstant: 200),
        self.nameTextField.heightAnchor.constraint(equalToConstant: 25),
        
        self.emailLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 20.0),
        self.emailLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 80.0),
        self.emailLabel.widthAnchor.constraint(equalToConstant: 80),
        self.emailLabel.heightAnchor.constraint(equalToConstant: 25),
        self.emailTextField.topAnchor.constraint(equalTo: self.emailLabel.topAnchor),
        self.emailTextField.leadingAnchor.constraint(equalTo: self.emailLabel.trailingAnchor, constant: 10),
        self.emailTextField.widthAnchor.constraint(equalToConstant: 200),
        self.emailTextField.heightAnchor.constraint(equalToConstant: 25),
        
        self.passwordLabel.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 20.0),
        self.passwordLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 80.0),
        self.passwordLabel.widthAnchor.constraint(equalToConstant: 80),
        self.passwordLabel.heightAnchor.constraint(equalToConstant: 25),
        self.passwordTextField.topAnchor.constraint(equalTo: self.passwordLabel.topAnchor),
        self.passwordTextField.leadingAnchor.constraint(equalTo: self.passwordLabel.trailingAnchor, constant: 10),
        self.passwordTextField.widthAnchor.constraint(equalToConstant: 200),
        self.passwordTextField.heightAnchor.constraint(equalToConstant: 25),
        
        
        self.repeatPasswordLabel.topAnchor.constraint(equalTo: self.passwordLabel.bottomAnchor, constant: 20.0),
        self.repeatPasswordLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 80.0),
        self.repeatPasswordLabel.widthAnchor.constraint(equalToConstant: 80),
        self.repeatPasswordLabel.heightAnchor.constraint(equalToConstant: 25),
        self.repeatPasswordTextField.topAnchor.constraint(equalTo: self.repeatPasswordLabel.topAnchor),
        self.repeatPasswordTextField.leadingAnchor.constraint(equalTo: self.repeatPasswordLabel.trailingAnchor, constant: 10),
        self.repeatPasswordTextField.widthAnchor.constraint(equalToConstant: 200),
        self.repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 25),
        
        
        self.confirmSignUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        self.confirmSignUpButton.topAnchor.constraint(equalTo: self.repeatPasswordLabel.bottomAnchor, constant: 40.0),
        self.confirmSignUpButton.widthAnchor.constraint(equalToConstant: 180.0),
        self.confirmSignUpButton.heightAnchor.constraint(equalToConstant: 50.0),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        navigationController?.navigationBar.prefersLargeTitles = true
        [self.emailLabel, self.emailTextField, self.passwordLabel, self.passwordTextField].forEach {self.view.addSubview($0)}
        self.setSignInWindow()
    }
    
    private func setSignInWindow() {
        self.navigationItem.leftBarButtonItem = nil
        title = "Вход"
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
        let image = UIImage(named: "CloseIconTemplate")?.withRenderingMode(.alwaysOriginal)
        let closeButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(closeButtonTapped))
        self.navigationItem.leftBarButtonItem  = closeButton
        self.setUpSignInConstraints()
    }
    
    private func setSignUpWindow() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Регистрация"
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
        let image = UIImage(named: "backArrow")?.withRenderingMode(.alwaysOriginal)
        let backButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(arrowButtonTapped))
        self.navigationItem.leftBarButtonItems?.insert(backButton, at: 0)
        self.setUpSignUpConstraints()
    }
    
    private func setUpSignInConstraints() {
        NSLayoutConstraint.deactivate(self.signUpConstraints)
        
        [self.confirmSignUpButton, self.nameLabel, self.nameTextField, self.repeatPasswordLabel, self.repeatPasswordTextField, self.confirmSignUpButton].forEach {$0.removeFromSuperview()}
        [ self.signInButton, self.signUpButton].forEach { self.view.addSubview($0)}
        
        NSLayoutConstraint.activate(self.signInConstraints)
    }
    
    private func setUpSignUpConstraints() {
        NSLayoutConstraint.deactivate(self.signInConstraints)
        
        [self.signUpButton, self.signInButton].forEach {$0.removeFromSuperview()}
        
        [ self.nameLabel, self.nameTextField, self.repeatPasswordLabel, self.repeatPasswordTextField, self.confirmSignUpButton].forEach {self.view.addSubview($0)}
        
        NSLayoutConstraint.activate(self.signUpConstraints)
    }
    
    private func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    @objc private func enableDrag() {
        
    }
    
    @objc private func arrowButtonTapped() {
        self.hideKeyboard()
        self.setSignInWindow()
    }
    
    @objc private func closeButtonTapped() {
        self.hideKeyboard()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func signUpButtonStartTouch (_ sender: UIButton) {
        self.signUpButton.isExclusiveTouch = true
        
        UIView.animate(withDuration: 0.1) {
            sender.transform = .init(scaleX:0.9, y: 0.9)
        }
        self.signUpButton.backgroundColor = .lightGray
    }
    
    @objc private func signUpButtonTapped (_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
        self.signUpButton.backgroundColor = .white
        self.hideKeyboard()
        self.setSignUpWindow()
    }
    
    @objc private func signUpButtonCancelTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
        self.signUpButton.backgroundColor = .white
    }
    
    @objc private func signUpButtonDragAwayTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
        self.signUpButton.backgroundColor = .white
    }
    
    
    @objc private func signInButtonStartTouch (_ sender: UIButton) {
        guard let emailText = self.emailTextField.text, let passwordText = self.passwordTextField.text, !passwordText.isEmpty, !emailText.isEmpty else { return }
        
        UIView.animate(withDuration: 0.1) {
            sender.transform = .init(scaleX:0.9, y: 0.9)
        }
        self.signInButton.backgroundColor = .lightGray
    }
    
    @objc private func signInButtonTapped (_ sender: UIButton) {
        guard let emailText = self.emailTextField.text, let passwordText = self.passwordTextField.text, !passwordText.isEmpty, !emailText.isEmpty else { return }
        
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
        self.signInButton.backgroundColor = .black
        self.hideKeyboard()
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { user, error in
            if let _ = error, user == nil {
                let alert = UIAlertController(title: "Ошибка при входе",
                                              message: "",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc private func signInButtonCancelTapped(_ sender: UIButton) {
        guard let emailText = self.emailTextField.text, let passwordText = self.passwordTextField.text, !passwordText.isEmpty, !emailText.isEmpty else { return }
        
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
        self.signInButton.backgroundColor = .black
    }
    
    @objc private func signInButtonDragAwayTapped(_ sender: UIButton) {
        guard let emailText = self.emailTextField.text, let passwordText = self.passwordTextField.text, !passwordText.isEmpty, !emailText.isEmpty else { return }
        
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
        self.signInButton.backgroundColor = .black
    }
    
    @objc private func confirmSignUpButtonTapped(_ sender: UIButton) {
        guard let emailText = self.emailTextField.text, let passwordText = self.passwordTextField.text, let nameText = self.nameTextField.text, let repeatPasswordText = self.repeatPasswordTextField.text, !passwordText.isEmpty, !emailText.isEmpty, !nameText.isEmpty, !repeatPasswordText.isEmpty  else { return }
        
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
        
        self.confirmSignUpButton.backgroundColor = .black
        self.hideKeyboard()
        
        if passwordText != repeatPasswordText {
            let alert = UIAlertController(title: "Ошибка",
                                          message: "Пароли не совпадают",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let dispatchGroup = DispatchGroup()
        
        Auth.auth().createUser(withEmail: emailText, password: passwordText) { (result, error) in
            if let _ = error  {
                let alert = UIAlertController(title: "Ошибка при регистрации",
                                              message: error?.localizedDescription,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
                return
            } else {
                let changeRequest = result?.user.createProfileChangeRequest()
                
                changeRequest?.displayName = nameText
                dispatchGroup.enter()
                changeRequest?.commitChanges(completion: { (_) in
                    self.handler()
                    dispatchGroup.leave()
                })
            }
                        
            dispatchGroup.notify(queue: DispatchQueue.main) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    
    @objc private func confirmSignUpButtonCancelTapped(_ sender: UIButton) {
        guard let emailText = self.emailTextField.text, let passwordText = self.passwordTextField.text, let nameText = self.nameTextField.text, let repeatPasswordText = self.repeatPasswordTextField.text, !passwordText.isEmpty, !emailText.isEmpty, !nameText.isEmpty, !repeatPasswordText.isEmpty  else { return }
        
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
        self.confirmSignUpButton.backgroundColor = .black
    }
    
    @objc private func confirmSignUpButtonDragAwayTapped(_ sender: UIButton) {
        guard let emailText = self.emailTextField.text, let passwordText = self.passwordTextField.text, let nameText = self.nameTextField.text, let repeatPasswordText = self.repeatPasswordTextField.text, !passwordText.isEmpty, !emailText.isEmpty, !nameText.isEmpty, !repeatPasswordText.isEmpty  else { return }
        
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
        self.confirmSignUpButton.backgroundColor = .black
    }
    
    
    @objc private func confirmSignUpButtonStartTouch (_ sender: UIButton) {
        guard let emailText = self.emailTextField.text, let passwordText = self.passwordTextField.text, let nameText = self.nameTextField.text, let repeatPasswordText = self.repeatPasswordTextField.text, !passwordText.isEmpty, !emailText.isEmpty, !nameText.isEmpty, !repeatPasswordText.isEmpty  else { return }
        
        UIView.animate(withDuration: 0.1) {
            sender.transform = .init(scaleX:0.9, y: 0.9)
        }
        self.confirmSignUpButton.backgroundColor = .lightGray
    }
    
    @objc private func hideKeyboard() {
        [self.emailTextField, self.passwordTextField, self.nameTextField, self.repeatPasswordTextField].forEach { $0.resignFirstResponder() }
    }
    
}
