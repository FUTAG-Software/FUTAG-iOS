//
//  FTExtrasScreenViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 9.01.2022.
//

import UIKit

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
        
        
        
    }
    
    
    //MARK: - Datas
    
    func getData() {
        
        let departments = Extra(name: "Birimlerimiz", number: 0, imageName: "futagLogoSiyah")
        let biziOyla = Extra(name: "Bizi Oyla", number: 1, imageName: "inboxMail")
        let feedBack = Extra(name: "Birimlerimiz", number: 2, imageName: "inboxMail")
        let infoUs = Extra(name: "Birimlerimiz", number: 3, imageName: "infoIcon")
        let settings = Extra(name: "Birimlerimiz", number: 4, imageName: "inboxMail")
        
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
        
        let vc = FTDepartmentsScreenViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
