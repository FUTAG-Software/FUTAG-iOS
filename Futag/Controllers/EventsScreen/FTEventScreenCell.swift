//
//  FTEventScreenCell.swift
//  Futag
//
//  Created by Furkan Erdoğan on 2.02.2022.
//

import Foundation
import UIKit
import SDWebImage


class FTEventScreenCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let reuseIdentifier = String(describing: FTEventScreenCell.self)
    
    var eventList: Event! {
        
        didSet {
            topImageView.setImage(with: eventList.image)
            titleLabel.text = eventList.title
            
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
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setDimensions(width: 250, height: 200)
        
        
        
        
        return imageView
    }()
    
    private lazy var container2 : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        //view.backgroundColor = .systemGray6
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.text = "2021 2022 dönemi"
        label.textAlignment = .center
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
        container2.anchor( left: container.leftAnchor, bottom: container.bottomAnchor, right: container.rightAnchor)
        
        container2.addSubview(titleLabel)
        titleLabel.anchor(top: container2.topAnchor, left: container2.leftAnchor, bottom: container.bottomAnchor, right: container2.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
        
        
    }
    
    
}
