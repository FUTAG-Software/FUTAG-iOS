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

class FTMainScreenViewController: UIViewController {

    //MARK: - Properties
    
    private var headerImagemageSlide: ImageSlideshow = {
        let slide = ImageSlideshow()
        
        
        
        return slide
    }()
    
    var imageSDWebImageSrc = [SDWebImageSource]()

    
    let sdWebImageSource = [SDWebImageSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, SDWebImageSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, SDWebImageSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]


    

    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.configureUI()
    }
    
    //MARK: - API
    
    
    //MARK: - Selector
    
    
    
    //MARK: - Helper
    
    func configureUI() {
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        
        headerImagemageSlide.slideshowInterval = 5.0
        headerImagemageSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        headerImagemageSlide.contentScaleMode = UIViewContentMode.scaleAspectFill
        

        headerImagemageSlide.delegate = self

        headerImagemageSlide.setImageInputs(sdWebImageSource)
        
        view.addSubview(headerImagemageSlide)
        headerImagemageSlide.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,right: view.rightAnchor, height: 280)
        
    }

}


extension FTMainScreenViewController: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
}
