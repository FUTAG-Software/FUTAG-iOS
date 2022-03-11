//
//  FTDepartmentInfoViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 10.02.2022.
//

import Foundation
import UIKit

class FTDepartmentInfoViewController: UIViewController {
    
    //MARK: - Properties
    
    var selectedTitle: String?
    var selectedImage: String?
    var selectedContent: String?
    
    private lazy var scroolView: UIScrollView = {
        let sc = UIScrollView(frame: .zero)
        sc.backgroundColor = .systemBackground
        sc.contentSize.width = self.view.frame.width
        sc.frame = self.view.bounds
        sc.autoresizingMask = .flexibleHeight
        sc.showsHorizontalScrollIndicator = true
        sc.bounces = true
        
        return sc
    }()
    
    private lazy var scrollSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        
        return view
        
        
    }()
    
    private lazy var headrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setDimensions(width: 250, height: 280)
        imageView.image = UIImage(named: selectedImage ?? "")
        
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
       label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
       label.textColor = .label
       label.text = "\(selectedTitle ?? "")"
       label.numberOfLines = .max
       
       return label
   }()
    
    private lazy var contentTextView: UILabel = {
       let label = UILabel()
       label.textColor = .label
       label.text = selectedContent
       label.numberOfLines = .max
       label.text = "\(selectedContent ?? "")"
       
       return label
   }()
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureUI()
        
    }
    
    //MARK: - API
    
    
    //MARK: - Selector
    
    
    
    //MARK: - Helper
    
    func configureUI() {
        
        self.title = "\(selectedTitle ?? "")"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .systemBackground
        
        view.addSubview(headrImageView)
        headrImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
        
        view.addSubview(scroolView)
        scroolView.anchor(top: headrImageView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0)
        
        scroolView.addSubview(scrollSubView)
        scrollSubView.anchor(top: scroolView.topAnchor, left: scroolView.leftAnchor, bottom: scroolView.bottomAnchor, width: view.frame.size.width)
        
        scrollSubView.addSubview(titleLabel)
        titleLabel.anchor(top: scrollSubView.topAnchor, left: scrollSubView.leftAnchor, paddingTop: 15, paddingLeft: 10)
        
        scrollSubView.addSubview(contentTextView)
        contentTextView.anchor(top: titleLabel.bottomAnchor, left: scrollSubView.leftAnchor, bottom: scrollSubView.bottomAnchor, right: scrollSubView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 20, paddingRight: 10)
        
    }
    
    
    

    

}
