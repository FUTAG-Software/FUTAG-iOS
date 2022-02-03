//
//  FTExtrasScreenCell.swift
//  Futag
//
//  Created by Furkan Erdoğan on 2.02.2022.
//

import Foundation
import UIKit
import SDWebImage


class FTExtrasScreenCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let reuseIdentifier = String(describing: FTExtrasScreenCell.self)
    
    var container : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        //view.backgroundColor = .systemGray6
        view.backgroundColor = .white
        
        
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.backgroundColor = UIColor.systemGray6
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
        view.backgroundColor = UIColor.white
        view.setDimensions(width: 60, height: 60)
        view.layer.cornerRadius = 30
        
        
        return view
    }()
    
     let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 40, height: 40)
        iv.image = UIImage(named: "futagLogoSiyah")
        
        
        return iv
    }()
    
     let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - API
    
    
    //MARK: - Selector
    
    
    
    //MARK: - Helper
    
    func configureUI() {
        
        contentView.addSubview(container)
        container.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor , right: contentView.rightAnchor, paddingLeft: 10, paddingRight: 10)
        
        container.addSubview(container2)
        container2.centerY(inView: container, leftAnchor: container.leftAnchor, paddingLeft: 20)
        
        container2.addSubview(logoImageView)
        logoImageView.center(inView: container2)
        
        
        container.addSubview(titleLabel)
        titleLabel.centerY(inView: container, leftAnchor: container.leftAnchor, paddingLeft: 100)
        
        container.addSubview(forwardImageView)
        forwardImageView.centerY(inView: container, leftAnchor: container.rightAnchor, paddingLeft: -30)
        
        
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
            let targetSize = CGSize(width: layoutAttributes.frame.width, height: 80)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .required)
            return layoutAttributes
        }
    
}
