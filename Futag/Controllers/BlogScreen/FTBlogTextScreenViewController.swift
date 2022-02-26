//
//  FTBlogTextScreenViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 2.02.2022.
//

import Foundation
import UIKit
import SwiftSoup


class FTBlogTextScreenViewController: UIViewController {
    
    
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
        imageView.setDimensions(width: 250, height: 200)
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
       label.textColor = .white
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
        
        
    }
    
    //MARK: - API
    
    
    //MARK: - Selector
    
    
    
    //MARK: - Helper
    
    func filterImgTag(text: String) -> String{
        return text.replacingOccurrences(of: "<img[^>]*>", with: "", options: String.CompareOptions.regularExpression)
    }
    
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

extension String {
    public var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }

        return attributedString.string
    }
}
