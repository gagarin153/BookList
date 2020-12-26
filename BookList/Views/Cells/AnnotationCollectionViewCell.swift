//
//  AnnotationTableViewCell.swift
//  BookList
//
//  Created by Sultan on 25.12.2020.
//

import UIKit

class AnnotationCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "AnnotationCell"
    
    private lazy var width: NSLayoutConstraint = {
        let width = self.contentView.widthAnchor.constraint(equalToConstant: self.bounds.size.width)
        width.isActive = true
        return width
    }()
    
    private let annotationLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Двенадцать стульев (1927 г.) - роман, написанный почти век назад, а кажется, что совсем недавно. Его цитируют все, даже те, кто не прочел ни страницы текста и не смотрел ни одной экранизации, а их было уже немало. Остап Бендер, Великий комбинатор, стал персонажем нарицательным, и по всей России ему ставят памятники. История про то, как Бендер вместе со своим напарником Кисой Воробьяниновым пытаются найти бриллианты мадам Петуховой, спрятанные в одном из 12 стульев мебельного гарнитура, стала поистине народной классикой. Роман переиздавался в России почти 200 раз, он переведен на множество языков, хотя довольно сложно передать тот юмор, которым перенасыщена эта удивительная во всех смыслах книга. Книга, которая до сих пор так до конца и не разгадана: почему Валентин Катаев предложил этот сюжет двум малоизвестным журналистам родом из Одессы, есть ли у героев прототипы, кто скрывается за фигурой Остапа Бендера? Возможно, эти загадки так навсегда и останутся загадками. А заседание продолжается, господа присяжные заседатели"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpContentView()
        self.setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        self.width.constant = self.bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    private func setUpContentView() {
        let radius: CGFloat = 10.0
        self.contentView.layer.cornerRadius = radius
        self.contentView.backgroundColor = .white
    }

    private func setUpLayout() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.annotationLabel)
        
        self.annotationLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        self.annotationLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        self.annotationLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20.0).isActive = true

        self.contentView.bottomAnchor.constraint(equalTo: self.annotationLabel.bottomAnchor, constant: 20).isActive = true
    }
   
}
