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
        imageView.setDimensions(width: view.frame.size.width, height: 300)
        
        
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
       label.textColor = .label
       label.text = selectedContent
       label.numberOfLines = .max
        
        let formattedString = selectedContent!
                                .htmlAttributedString()
            .with(font:UIFont.systemFont(ofSize: 16, weight: .semibold))
        
        let attributes: [NSAttributedString.Key: AnyObject] =
                          [NSAttributedString.Key.foregroundColor: UIColor.label]
        
        formattedString.addAttributes(attributes,
                                      range: NSRange.init(location: 0, length: formattedString.length ))
        
        label.attributedText = formattedString
       
       return label
   }()
    
    
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureUI()
        
        headrImageView.setImage(with: selectedImage ?? "")
    }
    
    //MARK: - API
    
    
    //MARK: - Selector
    
    
    
    //MARK: - Helper
    
    func configureUI() {
        
        self.title = selectedTitle
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isHidden = false
        
        
        view.addSubview(scroolView)
        scroolView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0)
        
        scroolView.addSubview(scrollSubView)
        scrollSubView.anchor(top: scroolView.topAnchor, left: scroolView.leftAnchor, bottom: scroolView.bottomAnchor, width: view.frame.size.width)
        
        scrollSubView.addSubview(headrImageView)
        headrImageView.anchor(top: scrollSubView.topAnchor, left: scrollSubView.leftAnchor, right: scrollSubView.rightAnchor)
        
        scrollSubView.addSubview(authorLabel)
        authorLabel.anchor(top: headrImageView.bottomAnchor, right: scrollSubView.rightAnchor, paddingTop: 15, paddingRight: 15)
        
        scrollSubView.addSubview(contentTextView)
        contentTextView.anchor(top: authorLabel.bottomAnchor, left: scrollSubView.leftAnchor, bottom: scrollSubView.bottomAnchor, right: scrollSubView.rightAnchor, paddingLeft: 10, paddingRight: 10)
        
        
        
    }
    
}
