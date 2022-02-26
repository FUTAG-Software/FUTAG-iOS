//
//  FTSettingsViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 26.02.2022.
//

import UIKit
import StoreKit

struct Setting {
    let seetingImage: String
    let title: String
    let isOpened: Bool
}



class FTSettingsViewController: UIViewController {

    //MARK: - Properties
    
    var settings = [Setting]() {
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
    
    lazy var usersSwitch: UISwitch = {
        let sw = UISwitch()
        sw.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        sw.addTarget(self, action: #selector(darkModeSwitchChanged), for: UIControl.Event.valueChanged)

        
        
        return sw
    }()
    
    lazy var usersSwitch2: UISwitch = {
        let sw = UISwitch()
        sw.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        sw.isOn = false
        sw.addTarget(self, action: #selector(notificatonSwitchChanged), for: UIControl.Event.valueChanged)

        
        
        return sw
    }()
    
    lazy var usersSwitch3: UISwitch = {
        let sw = UISwitch()
        sw.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        sw.isOn = false
        sw.addTarget(self, action: #selector(notificatonSwitchChanged), for: UIControl.Event.valueChanged)

        
        
        return sw
    }()
    
    lazy var languageContainer : UIView = {
       let view = UIView()
       view.clipsToBounds = true
       //view.backgroundColor = .systemGray6
       view.layer.masksToBounds = true
       view.backgroundColor = UIColor.tertiarySystemBackground
       view.setDimensions(width: 60, height: 60)
       view.layer.cornerRadius = 30
       
       
       return view
   }()
    
    let logoImageView: UIImageView = {
       let iv = UIImageView()
       iv.setDimensions(width: 40, height: 40)
       iv.image = UIImage(named: "uk")
       
       
       return iv
   }()
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getData()
        configureUI()
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FTSettingsCell.self, forCellWithReuseIdentifier:FTSettingsCell.reuseIdentifier)
        commentFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        commentFlowLayout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = commentFlowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        
    }
    
    //MARK: - API
    
    
    //MARK: - Selector
    
    @objc func darkModeSwitchChanged() {
        
    }
    
    @objc func notificatonSwitchChanged() {
        
    }
    
    
    
    //MARK: - Helper
    
    func configureUI() {
        
        self.title = "Ayarlar"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        
        
    }
    
    
    //MARK: - Datas
    
    func getData() {
        
        let darkMode = Setting(seetingImage: "moon", title: "Koyu Mod", isOpened: false)
        let noti = Setting(seetingImage: "notification", title: "Bildirimler", isOpened: false)
        let language = Setting(seetingImage: "turkey", title: "", isOpened: false)
        
        settings.append(darkMode)
        settings.append(noti)
        settings.append(language)
        
        
        
    }

}

extension FTSettingsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FTSettingsCell.reuseIdentifier, for: indexPath) as! FTSettingsCell
        
        
        
        cell.titleLabel.text = settings[indexPath.row].title
        cell.logoImageView.image = UIImage(named: settings[indexPath.row].seetingImage)
        
        if indexPath.row == 0 {
            cell.container.addSubview(self.usersSwitch)
            self.usersSwitch.anchor(top: cell.container.topAnchor, right: cell.container.rightAnchor, paddingTop: 25, paddingRight: 10)
        }
        
        if indexPath.row == 1 {
            cell.container.addSubview(self.usersSwitch2)
            self.usersSwitch2.anchor(top: cell.container.topAnchor, right: cell.container.rightAnchor, paddingTop: 25, paddingRight: 10)
        }
        
        if indexPath.row == 2 {
            cell.container.addSubview(self.languageContainer)
            self.languageContainer.centerY(inView: cell.container, leftAnchor: cell.container.rightAnchor, paddingLeft: -80)
            
            cell.container.addSubview(usersSwitch3)
            usersSwitch3.center(inView: cell.container)
            
            languageContainer.addSubview(logoImageView)
            logoImageView.center(inView: languageContainer)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
        
        
    }
    
    
}
