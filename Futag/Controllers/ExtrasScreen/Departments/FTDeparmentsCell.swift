//
//  FTDeparmentsCell.swift
//  Futag
//
//  Created by Furkan Erdoğan on 8.02.2022.
//
import Foundation
import UIKit
import SDWebImage


class FTDeparmentsCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let reuseIdentifier = String(describing: FTDeparmentsCell.self)
    
    var container : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        //view.backgroundColor = .systemGray6
        view.backgroundColor = .tertiarySystemBackground
        
        
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.backgroundColor = UIColor.systemBackground
        view.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        view.layer.shadowOpacity = 0.8
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    
    private lazy var container2 : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        //view.backgroundColor = .systemGray6
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.tertiarySystemBackground
        view.setDimensions(width: 70, height: 70)
        view.layer.cornerRadius = 20
        
        
        return view
    }()
    
     let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 70, height: 70)
        iv.image = UIImage(named: "girisimcilik")
        
        
        return iv
    }()
    
     let titleLabel: UILabel = {
        let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        label.text = "Birimlerimiz"
        label.numberOfLines = .max
        
        return label
    }()
    
    private let forwardImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "chevron.forward")
        iv.tintColor = .clubYellow
        
        
        return iv
    }()
    
    
    
    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        
        switch traitCollection.userInterfaceStyle {
        case .dark:
            print("Dark")
            
            
        case .light:
            container.backgroundColor = .systemGray6
        default:
            print("something else")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - API
    
    
    //MARK: - Selector
    
    
    
    //MARK: - Helper
    
    func configureUI() {
        
        contentView.addSubview(container)
        container.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor , right: contentView.rightAnchor, paddingLeft: 30, paddingRight: 10)
        
        contentView.addSubview(container2)
        container2.centerY(inView: container, leftAnchor: container.leftAnchor, paddingLeft: -30)
        
        container2.addSubview(logoImageView)
        logoImageView.center(inView: container2)
        
        
        container.addSubview(titleLabel)
        titleLabel.anchor(top: container.topAnchor, left: container.leftAnchor, bottom: container.bottomAnchor, right: container.rightAnchor, paddingTop: 10, paddingLeft: 60, paddingBottom: 10, paddingRight: 10)
        
        
        
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
            let targetSize = CGSize(width: layoutAttributes.frame.width, height: 90)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .required)
            return layoutAttributes
        }
    
}
