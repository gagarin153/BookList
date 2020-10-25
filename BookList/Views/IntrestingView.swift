import UIKit

class IntrestingView: UIView {
    
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
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Далее", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.layer.cornerRadius = 10.0
        b.backgroundColor = .whiteGray
        return b
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setUpSelf()
        setUpConstraints()
    }
    
    private func setUpSelf() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(intrestingLabel)
        self.addSubview(containerView)
        self.addSubview(nextButton)
       
    }
    
    private  func setUpConstraints() {
        intrestingLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        intrestingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        containerView.topAnchor.constraint(equalTo: intrestingLabel.bottomAnchor, constant: 5).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        nextButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 145).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
