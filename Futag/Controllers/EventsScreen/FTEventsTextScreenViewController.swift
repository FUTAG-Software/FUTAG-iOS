//
//  FTEventsTextScreenViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 2.02.2022.
//

import Foundation
import UIKit
import SwiftSoup


class FTEventsTextScreenViewController: UIViewController {
    
    
    var selectedImage: String?
    var selectedLink: String?
    var selectedDetail: String?
    var selectedDetail2: String?
    var selectedTitle: String?
    
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
        imageView.setDimensions(width: 250, height: 220)
        imageView.setImage(with: selectedImage ?? "")
        
        
        return imageView
    }()
    
    private lazy var authorLabel: UILabel = {
       let label = UILabel()
       label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
       label.textColor = .clubYellow
       label.text = "Kayıt için tıklayınız."
       label.numberOfLines = .max
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
                label.isUserInteractionEnabled = true
                label.addGestureRecognizer(tap)
       
       return label
   }()
    
    private lazy var contentTextView: UILabel = {
       let label = UILabel()
       label.textColor = .label
       label.numberOfLines = .max
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        label.text = selectedDetail
        
       
       return label
   }()
    
    private lazy var contentTextView2: UILabel = {
       let label = UILabel()
       label.textColor = .label
       label.numberOfLines = .max
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        label.text = selectedDetail2
        
       
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
    
    @objc func labelTapped() {
        
        let controller = FTEventsWebViewScreenController()
        controller.selectedLink = self.selectedLink
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
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
        contentTextView.anchor(top: authorLabel.bottomAnchor, left: scrollSubView.leftAnchor, right: scrollSubView.rightAnchor,paddingTop: 20, paddingLeft: 10, paddingBottom: 80, paddingRight: 10)
        
        scrollSubView.addSubview(contentTextView2)
        contentTextView2.anchor(top: contentTextView.bottomAnchor, left: scrollSubView.leftAnchor, bottom: scrollSubView.bottomAnchor, right: scrollSubView.rightAnchor,paddingTop: 20, paddingLeft: 10, paddingBottom: 80, paddingRight: 10)
        
        
        
    }
    
}
