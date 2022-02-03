//
//  FTMainScreenCell.swift
//  Futag
//
//  Created by Furkan Erdoğan on 2.02.2022.
//

import Foundation
import UIKit
import SDWebImage


class FTMainScreenCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let reuseIdentifier = String(describing: FTMainScreenCell.self)
    
    var postList: Post! {
        
        didSet {
            topImageView.setImage(with: postList.featured_image.large)
            titleLabel.text = postList.title
            
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
        view.layer.cornerRadius = 12
        
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.clubGray.cgColor
        
        
        
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
        view.backgroundColor = .white
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.text = "YÖNETIM KURULU SEÇIMI GERÇEKLEŞTI ÇOK GÜZEL OLDU"
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
        container.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor , right: contentView.rightAnchor, paddingLeft: 10, paddingRight: 10)
        
        container.addSubview(topImageView)
        topImageView.anchor(top: container.topAnchor, left: container.leftAnchor, right: container.rightAnchor)
        
        container.addSubview(container2)
        container2.anchor(top: topImageView.bottomAnchor, left: container.leftAnchor, bottom: container.bottomAnchor, right: container.rightAnchor)
        
        container2.addSubview(titleLabel)
        titleLabel.anchor(top: container2.topAnchor, left: container2.leftAnchor, bottom: container2.bottomAnchor, right: container2.rightAnchor, paddingLeft: 15, paddingRight: 5)
        
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
            let targetSize = CGSize(width: layoutAttributes.frame.width, height: 280)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .sceneSizeStayPut)
            return layoutAttributes
        }
    
}
