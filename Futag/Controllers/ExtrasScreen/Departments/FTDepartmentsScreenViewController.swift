//
//  FTDepartmentsScreenViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 8.02.2022.
//

import UIKit

struct Department {
    let name: String
    let number: Int
    let imageName: String
    let content: String
    let logoName: String
}

class FTDepartmentsScreenViewController: UIViewController {

    //MARK: - Properties
    
    var departments = [Department]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let commentFlowLayout = CommentFlowLayout()
    
    private lazy var collectionView: UICollectionView = {
        let coll = UICollectionView(frame: .zero, collectionViewLayout: CommentFlowLayout())
        coll.backgroundColor = .clear
        coll.translatesAutoresizingMaskIntoConstraints = false
        
        
        return coll
    }()
    
    private let leftImageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 80, height: 100)
        iv.image = UIImage(named: "solKenarlık")
        
        
        
        return iv
    }()
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       
        
        getData()
        configureUI()
        
        switch traitCollection.userInterfaceStyle {
        case .dark:
            view.backgroundColor = .black
            
            
            
        case .light:
            view.backgroundColor = .white
        default:
            print("something else")
        }
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FTDeparmentsCell.self, forCellWithReuseIdentifier:FTDeparmentsCell.reuseIdentifier)
        commentFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        commentFlowLayout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = commentFlowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        
    }
    
    //MARK: - API
    
    
    //MARK: - Selector
    
    
    
    //MARK: - Helper
    
    func configureUI() {
        
        self.title = "Birimlerimiz"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        
        
        view.addSubview(leftImageView)
        leftImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor)
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20)
        
        
        
    }
    
    
    //MARK: - Datas
    
    func getData() {
        
        let externalAffairs = Department(name: "Dış İlişkiler Ve Organizasyon", number: 1, imageName: "denemeImage", content: "merhaba benim adım algoritma bir problemin çözüm kümesiimdir. Sonuç dayımdır yanlış yazdım sonlu sayı dayımdır.", logoName: "dis")
        let innovation = Department(name: "Girişimcilik Ve İnovasyon Birimi", number: 2, imageName: "", content: "", logoName: "girisimcilik")
        let media = Department(name: "Medya Ve Tasarım Birimi", number: 2, imageName: "", content: "", logoName: "medya")
        let project = Department(name: "Proje Ve Arge Birimi", number: 1, imageName: "", content: "", logoName: "proje")
        let social = Department(name: "Sosyal Sorumluluk Ve Faaliyet Birimi", number: 1, imageName: "", content: "", logoName: "ssf")
        let software = Department(name: "Yazılım Birimi", number: 1, imageName: "", content: "", logoName: "yazilim")
        
        departments.append(externalAffairs)
        departments.append(innovation)
        departments.append(media)
        departments.append(project)
        departments.append(social)
        departments.append(software)
        
    }

}

extension FTDepartmentsScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return departments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FTDeparmentsCell.reuseIdentifier, for: indexPath) as! FTDeparmentsCell
        
        cell.titleLabel.text = departments[indexPath.row].name
        cell.logoImageView.image = UIImage(named: departments[indexPath.row].logoName)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FTDepartmentInfoViewController()
        vc.selectedTitle = departments[indexPath.row].name
        vc.selectedImage = departments[indexPath.row].imageName
        vc.selectedContent = departments[indexPath.row].content
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
