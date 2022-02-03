//
//  FTMainScreenTextViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 2.02.2022.
//

import Foundation
import UIKit
import SwiftSoup


class FTMainScreenTextViewController: UIViewController {
    
    
    var selectedImage: String?
    var selectedAuthor: String?
    var selectedTitle: String?
    var selectedContent: String?
    
    //MARK: - Properties
    
    private lazy var scroolView: UIScrollView = {
        let sc = UIScrollView(frame: .zero)
        sc.backgroundColor = .white
        sc.contentSize.width = self.view.frame.width
        sc.frame = self.view.bounds
        sc.autoresizingMask = .flexibleHeight
        sc.showsHorizontalScrollIndicator = true
        sc.bounces = true
        
        return sc
    }()
    
    private lazy var scrollSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        
        return view
        
        
    }()
    
    private lazy var headrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setImage(with: selectedImage ?? "")
        
        
        return imageView
    }()
    
    private lazy var authorLabel: UILabel = {
       let label = UILabel()
       label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
       label.textColor = .clubYellow
       label.text = selectedAuthor
       label.numberOfLines = .max
       
       return label
   }()
    
    private lazy var contentTextView: UILabel = {
       let label = UILabel()
       label.textColor = .black
       label.text = selectedContent
       label.numberOfLines = .max
        
        let formattedString = selectedContent!
                                .htmlAttributedString()
            .with(font:UIFont.systemFont(ofSize: 16, weight: .semibold))
        
        label.attributedText = formattedString
       
       return label
   }()
    
    
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        configureUI()
    }
    
    //MARK: - API
    
    
    //MARK: - Selector
    
    
    
    //MARK: - Helper
    
    func configureUI() {
        
        
        
        
        
        self.title = selectedTitle
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(headrImageView)
        headrImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
        
        view.addSubview(scroolView)
        scroolView.anchor(top: headrImageView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0)
        
        scroolView.addSubview(scrollSubView)
        scrollSubView.anchor(top: scroolView.topAnchor, left: scroolView.leftAnchor, bottom: scroolView.bottomAnchor, width: view.frame.size.width)
        
        scrollSubView.addSubview(authorLabel)
        authorLabel.anchor(top: scrollSubView.topAnchor, right: scrollSubView.rightAnchor, paddingTop: 15, paddingRight: 15)
        
        scrollSubView.addSubview(contentTextView)
        contentTextView.anchor(top: authorLabel.bottomAnchor, left: scrollSubView.leftAnchor, bottom: scrollSubView.bottomAnchor, right: scrollSubView.rightAnchor, paddingLeft: 10, paddingRight: 10)
        
        
        
    }
    
}
