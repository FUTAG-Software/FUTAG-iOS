//
//  FTEventsScreenViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 9.01.2022.
//

import UIKit

struct Event: Decodable {
    let title: String
    let details: String
    let det: String
    let image: String
    let form_link: String
}

class FTEventsScreenViewController: UIViewController {

    //MARK: - Properties
    
    let commentFlowLayout = CommentFlowLayout()
    
    var eventList = [Event]() {
        didSet{
            collectionView.reloadData()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let coll = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
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
        collectionView.register(FTEventScreenCell.self, forCellWithReuseIdentifier:FTEventScreenCell.reuseIdentifier)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
                layout.minimumLineSpacing = 10
                layout.minimumInteritemSpacing = 10
                layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            let size = CGSize(width:(collectionView.bounds.width-30)/2, height: 250)
                layout.itemSize = size
        }
    }
    
    //MARK: - API
    
    func fetchData() {
        Service.shared.fetchEventData { data in
            
            self.eventList = data
            
        }
    }
    
    
    //MARK: - Selector
    
    
    
    //MARK: - Helper
    
    func configureUI() {
        
        self.title = "Etkinlikler"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
    }

}

extension FTEventsScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FTEventScreenCell.reuseIdentifier, for: indexPath) as! FTEventScreenCell
        
        cell.eventList = eventList[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
            return CGSize(width: size, height: 250)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FTEventsTextScreenViewController()
        vc.selectedImage = eventList[indexPath.row].image
        vc.selectedTitle = eventList[indexPath.row].title
        vc.selectedDetail = eventList[indexPath.row].details
        vc.selectedLink = eventList[indexPath.row].form_link
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
