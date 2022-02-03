//
//  FTBlogScreenCell.swift
//  Futag
//
//  Created by Furkan Erdoğan on 2.02.2022.
//

import Foundation
import UIKit
import SDWebImage


class FTBlogScreenCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let reuseIdentifier = String(describing: FTBlogScreenCell.self)
    
    var blogList: Blog! {
        
        didSet {
            topImageView.setImage(with: blogList.featured_image.large)
            titleLabel.text = blogList.title
            writerLabel.text = blogList.author
            
        }
    }
    
    var container : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        //view.backgroundColor = .systemGray6
        view.backgroundColor = .white
        
        
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.backgroundColor = UIColor.white
        view.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        view.layer.shadowOpacity = 0.8
        
        return view
    }()
    
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setDimensions(width: 250, height: 200)
        imageView.image = UIImage(named: "denemeImage")
        
        
        return imageView
    }()
    
    private lazy var container2 : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        //view.backgroundColor = .systemGray6
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.text = "FARKLILIKLAR"
        label.numberOfLines = .max
        
        return label
    }()
    
    private let writerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.text = "Lorem Ipsum"
        label.textColor = .clubYellow
        label.numberOfLines = .max
        
        return label
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
        container.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor , right: contentView.rightAnchor)
        
        container.addSubview(topImageView)
        topImageView.anchor(top: container.topAnchor, left: container.leftAnchor, bottom: container.bottomAnchor, right: container.rightAnchor)
        
        container.addSubview(container2)
        container2.anchor( left: container.leftAnchor, bottom: container.bottomAnchor, right: container.rightAnchor, height: 50)
        
        container2.addSubview(titleLabel)
        titleLabel.anchor(top: container2.topAnchor, left: container2.leftAnchor, right: container2.rightAnchor, paddingLeft: 10, paddingRight: 5)
        
        container2.addSubview(writerLabel)
        writerLabel.anchor(top: titleLabel.bottomAnchor, left: container2.leftAnchor, bottom: container2.bottomAnchor, right: container2.rightAnchor, paddingLeft: 10, paddingRight: 5)
        
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
            let targetSize = CGSize(width: layoutAttributes.frame.width, height: 250)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .required)
            return layoutAttributes
        }
    
}
