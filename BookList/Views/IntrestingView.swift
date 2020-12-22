import UIKit

class IntrestingView: UIView {
        
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.backgroundColor = .clear
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private let intrestingLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Интересное"
        return l
    }()
    
    private  let containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 30.0
        return v
    }()
    
    private  let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Далее", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10.0
        button.backgroundColor = .black  //.whiteGray
        return button
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setUpViews()
        setUpConstraints()
    }
    
    private func setUpViews() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(intrestingLabel)
        self.addSubview(containerView)
        containerView.addSubview(collectionView)
        containerView.addSubview(nextButton)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ArticleCollectionViewCell.self, forCellWithReuseIdentifier: ArticleCollectionViewCell.reuseIdentifier)
    }
    
    private  func setUpConstraints() {
        intrestingLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        intrestingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        containerView.topAnchor.constraint(equalTo: intrestingLabel.bottomAnchor, constant: 5).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -5).isActive = true
        
        nextButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 145).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IntrestingView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCollectionViewCell.reuseIdentifier, for: indexPath) as? ArticleCollectionViewCell
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}

