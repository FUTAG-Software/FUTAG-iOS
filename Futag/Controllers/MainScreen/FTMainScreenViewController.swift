//
//  FTMainScreenViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 9.01.2022.
//

import UIKit
import ImageSlideshow
import Kingfisher
import SDWebImage
import Alamofire
import UserNotifications

struct MainAd: Decodable {
    let id: Int
    let title: String
    let details: String
    let price: String
    let image: String
    let redirecting_link: String
}

struct Post: Decodable {
    let id: Int
    let link: String
    let slug: String
    let title: String
    let content: String
    let summary: String
    let author: String
    var featured_image: Image
}

class FTMainScreenViewController: UIViewController {

    //MARK: - Properties
    
    var adList = [MainAd]() {
        didSet{
            collectionView.reloadData()
        }
    }
    
    var posts = [Post]() {
        didSet{
            collectionView.reloadData()
        }
    }
    
    private var headerImagemageSlide: ImageSlideshow = {
        let slide = ImageSlideshow()
        slide.backgroundColor = .systemBackground
        
        
        return slide
    }()
    
    var imageSDWebImageSrc = [SDWebImageSource]()

    
//    let sdWebImageSource = [SDWebImageSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, SDWebImageSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, SDWebImageSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
    
    var sdWebImageSource2 = [SDWebImageSource]()
    
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
        
        switch traitCollection.userInterfaceStyle {
        case .dark:
            print("Dark")
            
            view.backgroundColor = .black
            collectionView.backgroundColor = .black
            
            
        case .light:
            view.backgroundColor = .white
            collectionView.backgroundColor = .white
        default:
            print("something else")
        }
        
        
        
        
        
        
        fetchData()
        fetchPostData()
        self.configureUI()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FTMainScreenCell.self, forCellWithReuseIdentifier:FTMainScreenCell.reuseIdentifier)
        commentFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        commentFlowLayout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = commentFlowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    
    //MARK: - API
    
    func fetchData() {
        
        
        Service.shared.fetchAdData { data in
            
            self.adList = data
            
            for i in data {
                self.sdWebImageSource2.append(SDWebImageSource(urlString: i.image)!)
                self.headerImagemageSlide.setImageInputs(self.sdWebImageSource2)
            }
            
        }
    }
    
    func fetchPostData() {
        Service.shared.fetchPostData { data in
            self.posts = data
        }
    }
    
    
    //MARK: - Selector
    
    
    
    //MARK: - Helper
    
    func configureUI() {
        
        navigationController?.navigationBar.isHidden = false
        
        
        headerImagemageSlide.slideshowInterval = 5.0
        headerImagemageSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        headerImagemageSlide.contentScaleMode = UIViewContentMode.scaleAspectFit
        

        headerImagemageSlide.delegate = self

        
        
        view.addSubview(headerImagemageSlide)
        headerImagemageSlide.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,right: view.rightAnchor, height: 280)
        
        view.addSubview(collectionView)
        collectionView.anchor(top: headerImagemageSlide.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: -30)
        
    }

}

extension FTMainScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FTMainScreenCell.reuseIdentifier, for: indexPath) as! FTMainScreenCell
        
        cell.postList = posts[indexPath.row]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FTMainScreenTextViewController()
        vc.selectedImage = posts[indexPath.row].featured_image.large
        vc.selectedTitle = posts[indexPath.row].title
        vc.selectedAuthor = posts[indexPath.row].author
        vc.selectedContent = posts[indexPath.row].content
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


extension FTMainScreenViewController: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
}
