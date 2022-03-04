//
//  FTExtrasScreenViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 9.01.2022.
//

import UIKit
import StoreKit

struct Extra {
    let name: String
    let number: Int
    let imageName: String
}



class FTExtrasScreenViewController: UIViewController {

    //MARK: - Properties
    
    var extras = [Extra]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let commentFlowLayout = CommentFlowLayout()
    
    private lazy var collectionView: UICollectionView = {
        let coll = UICollectionView(frame: .zero, collectionViewLayout: CommentFlowLayout())
        coll.backgroundColor = .systemBackground
        coll.translatesAutoresizingMaskIntoConstraints = false
        
        
        return coll
    }()
    
    private let copyRightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.text = "Copyright © 2022 by Furkan Erdogan"
        label.textColor = .label
        label.textAlignment = .center
        
        return label
    }()
    
    
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getData()
        configureUI()
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FTExtrasScreenCell.self, forCellWithReuseIdentifier:FTExtrasScreenCell.reuseIdentifier)
        commentFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        commentFlowLayout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = commentFlowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        
    }
    
    //MARK: - API
    
    
    //MARK: - Selector
    
    
    
    //MARK: - Helper
    
    func configureUI() {
        
        self.title = "Daha Fazlası"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        view.addSubview(copyRightLabel)
        copyRightLabel.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        
        
        
    }
    
    
    //MARK: - Datas
    
    func getData() {
        
        let departments = Extra(name: "Birimlerimiz", number: 0, imageName: "futagLogoSiyah")
        let biziOyla = Extra(name: "Bizi Oyla", number: 1, imageName: "star")
        let feedBack = Extra(name: "Geri Bildirim", number: 2, imageName: "email")
        let infoUs = Extra(name: "Hakkımızda", number: 3, imageName: "info")
        let settings = Extra(name: "Ayarlar", number: 4, imageName: "setting")
        
        extras.append(departments)
        extras.append(biziOyla)
        extras.append(feedBack)
        extras.append(infoUs)
        extras.append(settings)
        
    }

}

extension FTExtrasScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return extras.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FTExtrasScreenCell.reuseIdentifier, for: indexPath) as! FTExtrasScreenCell
        
        cell.titleLabel.text = extras[indexPath.row].name
        cell.logoImageView.image = UIImage(named: extras[indexPath.row].imageName)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if extras[indexPath.row].number == 0 {
            
            
            let vc = FTDepartmentsScreenViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        } else if extras[indexPath.row].number == 1 {
            
            
            if #available(iOS 14.0, *) {
                    if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                        SKStoreReviewController.requestReview(in: scene)
                    }
                } else if #available(iOS 10.3, *) {
                    SKStoreReviewController.requestReview()
                }
            
        } else if extras[indexPath.row].number == 2 {
            
            let appURL = URL(string: "mailto:futag@firat.edu.tr")!

            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL)
            }
            
        } else if extras[indexPath.row].number == 3 {
            let vc = FTAboutUsScreenController()
            navigationController?.pushViewController(vc, animated: true)
            
        } else if extras[indexPath.row].number == 4 {
            
            let vc = FTSettingsViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
    }
    
    
}


