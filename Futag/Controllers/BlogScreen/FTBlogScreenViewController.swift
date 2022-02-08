//
//  FTBlogScreenViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 9.01.2022.
//

import UIKit

struct Blog: Decodable {
    let id: Int
    let link: String
    let slug: String
    let title: String
    let content: String
    let summary: String
    let author: String
    var featured_image: Image
}

struct Image: Decodable {
    let thumbnail: String
    let medium: String
    let large: String
    
}

class FTBlogScreenViewController: UIViewController {

    //MARK: - Properties
    
    var blogs = [Blog]() {
        didSet{
            collectionView.reloadData()
        }
    }
    
    let commentFlowLayout = CommentFlowLayout()
    
    private lazy var collectionView: UICollectionView = {
        let coll = UICollectionView(frame: .zero, collectionViewLayout: CommentFlowLayout())
        coll.translatesAutoresizingMaskIntoConstraints = false
        
        
        return coll
    }()
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        fetchData()
        configureUI()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FTBlogScreenCell.self, forCellWithReuseIdentifier:FTBlogScreenCell.reuseIdentifier)
        commentFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        commentFlowLayout.minimumLineSpacing = 5
        collectionView.collectionViewLayout = commentFlowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        
        
    }
    
    //MARK: - API
    
    func fetchData() {
        Service.shared.fetchBlogData { blogData in
            self.blogs = blogData
        }
    }
    
    
    //MARK: - Selector
    
    
    
    //MARK: - Helper
    
    func configureUI() {
        
        self.title = "Blog"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
    }

}

extension FTBlogScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return blogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FTBlogScreenCell.reuseIdentifier, for: indexPath) as! FTBlogScreenCell
        
        cell.blogList = blogs[indexPath.row]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FTBlogTextScreenViewController()
        vc.selectedImage = blogs[indexPath.row].featured_image.large
        vc.selectedTitle = blogs[indexPath.row].title
        vc.selectedAuthor = blogs[indexPath.row].author
        vc.selectedContent = blogs[indexPath.row].content
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
