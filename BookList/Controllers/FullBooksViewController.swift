//
//  FullBooksViewController.swift
//  BookList
//
//  Created by Sultan on 27.12.2020.
//

import UIKit

class FullBooksViewController: UIViewController {

     var books = [Book?]()
    
//    private let placeHolderimageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = UIImage(named: "booksImage")
//        return imageView
//    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80.0, right: 0)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .softGray
        navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.setUpLayout()
    }
    
    private func setUpLayout() {
        [self.tableView].forEach {self.view.addSubview($0)}
//
//        self.placeHolderimageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        self.placeHolderimageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        self.placeHolderimageView.heightAnchor.constraint(equalToConstant: 350).isActive = true
//        self.placeHolderimageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension FullBooksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.reuseIdentifier, for: indexPath) as? BookTableViewCell, let book = books[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.setCell(with: book.name, imagePath: book.imagePath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootVC = BookViewController()
        rootVC.modalPresentationStyle = .fullScreen
        rootVC.book = books[indexPath.row]
        navigationController?.pushViewController(rootVC, animated: true)
    }
}
