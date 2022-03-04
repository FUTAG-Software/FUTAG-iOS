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
        
        let externalAffairs = Department(name: "Dış İlişkiler Ve Organizasyon", number: 1, imageName: "DIS-ILISKILER-birimi", content: "Birimimizin amacı; ulusal ve uluslararası kuruluşlar için üniversite temsilciliğini üstlenmek ve düzenlediğimiz etkinlikler için yetkili kişiler ile iletişime geçmektir. Topluluğumuz adına dışarıyla bağlantı sağlamamızın yanı sıra, sponsorluk ve reklam konularında da çalışmalar yürütmekteyiz.\n\nBirim olarak, ileriki dönemlerde topluluğumuzu ülkemizin önde gelen toplulukları ile aynı kategoride görmek ve üniversitemizi en güzel şekilde temsil etmeyi sağlamayı hedeflemekteyiz.", logoName: "dis")
        let innovation = Department(name: "Girişimcilik Ve İnovasyon Birimi", number: 2, imageName: "GIVIN-birimi", content: "Birim olarak amacımız düzenleyeceğimiz etkinlik ve eğitimlerle üyelerimizin iletişim yeteneklerini geliştirerek takım çalışması yöntemi ile yeni ürün ve fikir oluşturmalarına destek olmaktır.\n\nFikirlerin uygulama ve pratik ile gerçek değerlerine ulaştıkları bilincindeyiz.Girişimcilik ve İnovasyon birimi olarak, ekip arkadaşlarımızın girişimcilik ekosistemine dahil olmalarını sağlamak amacıyla fikirlerini destekleyerek üretme aşamalarına getirmelerini hedeflemekteyiz.", logoName: "girisimcilik")
        let media = Department(name: "Medya Ve Tasarım Birimi", number: 2, imageName: "MEDYA-birimi", content: "Birimimizin amacı; topluluğumuzun ihtiyaç duyduğu reklam çalışmalarını yürütmek ve tanıtımımıza katkı sağlamaktır. Topluluğumuz tanıtımının yanı sıra sosyal medya yöneticiliği ve fotoğrafçılık alanında çalışmalar yürütmekteyiz.\n\nBirim olarak, ileriki dönemlerde topluluğumuzun sosyal medyadaki tanıtımlarını arttırarak hedef kitlemizi büyütmeyi amaçlamaktayız.", logoName: "medya")
        let project = Department(name: "Proje Ve Arge Birimi", number: 1, imageName: "PROJE-birimi", content: "Birim olarak amacımız üretmeye ve geliştirmeye hevesli ekip arkadaşlarımızla birlikte projeler tasarlayıp bu projeleri istenilen alanda desteklemektir.\n\nİster teknik ister sosyal projeler olsun gelişmekte olan teknolojiye ve sosyal dünyaya uyum sağlamak, bu projeleri geliştirirken aynı zamanda bireysel yeteneklerimizi de geliştirmek öncelikli hedeflerimizdir.", logoName: "proje")
        let social = Department(name: "Sosyal Sorumluluk Ve Faaliyet Birimi", number: 1, imageName: "SSF-birimi", content: "Birim olarak: Etrafımızda bulunan çocuk, genç ve yaşlı her bir bireyin daha mutlu ve huzurlu bir hayat geçirmesi için çalışıyoruz. Aynı doğayı paylaştığımız bütün canlılara daha güvenilir bir yaşam alanı sağlamak hepimizin insanlık görevidir.\n\nBizler hep beraber çevremizi ve geleceğimizi daha güzel, mutlu ve huzurlu yapmayı hedeflemekteyiz.", logoName: "ssf")
        let software = Department(name: "Yazılım Birimi", number: 1, imageName: "YAZILIM-birimi", content: "Birim olarak amacımız topluluğumuzun yazılım konusunda ihtiyacı olan ürünlerin tasarım ve mimarisini yapmaktır. Ortaya çıkarılan ürünlerin dışında ekip arkadaşlarımıza dışarıdan sağlanan uzman desteği ile çeşitli eğitimler düzenlenmektedir.\n\nDijital dönüşüm sürecine uyum sağlamanın önemini bilerek, çalışmaya devam ediyor ve her yeni dönemde inovatif ürünler ortaya koymayı hedefliyoruz.", logoName: "yazilim")
        
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
