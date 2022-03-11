//
//  FTProfileScreenViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 9.01.2022.
//

import UIKit
import Firebase
import SDWebImage

class FTProfileScreenViewController: UIViewController {

    //MARK: - Properties
    
    private var user: User
    
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
    
   
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 150, height: 150)
        iv.layer.cornerRadius = 75
        iv.layer.masksToBounds = true
        iv.backgroundColor = .systemBackground
        
        
        
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.text = "Kamil Çömlekçi"
        
        
        return label
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(systemName: "envelope.fill")
        let view = Utilities().inputContainerView(withImage: image!, textField: emailTextField)
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Mailiniz")
        tf.text = "denemedeneme@gmail.com"
        tf.keyboardType = .emailAddress
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    private lazy var birhdayContainerView: UIView = {
        let image = UIImage(systemName: "calendar")
        let view = Utilities().inputContainerView(withImage: image!, textField: birthdayTextField)
        return view
    }()
    
    private let birthdayTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Doğum Gününüz")
        tf.text = "13.03.2000"
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Profili Düzenle", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .clubYellow
        button.layer.cornerRadius = 20
        button.setDimensions(width: 100, height: 50)
        
        button.addTarget(self, action: #selector(setProfileInfoTapped), for: .touchUpInside)

        
        return button
    }()
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Çıkış Yap", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .clubYellow
        button.layer.cornerRadius = 20
        button.setDimensions(width: 100, height: 50)
        
        button.addTarget(self, action: #selector(logOutButtonPressed), for: .touchUpInside)

        
        return button
    }()
    
    
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementedd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        configureUI()
        configureUserInfo()
    }
    
    //MARK: - API
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        fetcUser()
    }
    
    
    
    //MARK: - Selector
    
    @objc func setProfileInfoTapped() {
        let vc = FTSetProfileInfoViewController()
        vc.selectedImage = user.profileImage
        vc.selectedName = user.name
        vc.selectedSurname = user.surname
        vc.selectedBirthday = user.birthday
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func logOutButtonPressed() {
        do {
            try Auth.auth().signOut()
            let controller = FTLoginScreenViewController()
            controller.delegate = self.tabBarController as? FTMainTabBarControllerViewController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } catch {
            print("DEBUG: Failed to log user out")
        }
    }
    
    
    
    
    
    //MARK: - Helper
    
    func fetcUser() {
        UserService.fetchUser { user in
            self.user = user
            self.emailTextField.text = user.email
            self.birthdayTextField.text = user.birthday
            self.profileImageView.sd_setImage(with: user.profileImage, completed: nil)
            self.nameLabel.text = "\(user.name) \(user.surname)"
            
        }
    }
    
    func configureUserInfo() {
        birthdayTextField.text = user.birthday
        emailTextField.text = user.email
        nameLabel.text = "\(user.name) \(user.surname)"
        
        guard let url = URL(string: "\(user.profileImage!)") else {return}
        profileImageView.sd_setImage(with: url, completed: nil)
    }
    
    func configureUI() {
        
        self.title = "Profil"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(scroolView)
        scroolView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0)
        
        scroolView.addSubview(scrollSubView)
        scrollSubView.anchor(top: scroolView.topAnchor, left: scroolView.leftAnchor, bottom: scroolView.bottomAnchor, width: view.frame.size.width)
        
        scrollSubView.addSubview(profileImageView)
        profileImageView.centerX(inView: scrollSubView, topAnchor: scrollSubView.safeAreaLayoutGuide.topAnchor)
        
        scrollSubView.addSubview(nameLabel)
        nameLabel.centerX(inView: scrollSubView, topAnchor: profileImageView.bottomAnchor, paddingTop: 20)
        
        let tfStack = UIStackView(arrangedSubviews: [ emailContainerView,  birhdayContainerView])
        tfStack.axis = .vertical
        tfStack.spacing  = 15
        tfStack.distribution = .fillEqually
        
        scrollSubView.addSubview(tfStack)
        tfStack.anchor(top: nameLabel.bottomAnchor, left: scrollSubView.leftAnchor, right: scrollSubView.rightAnchor, paddingTop: 50, paddingLeft: 10, paddingRight: 10)
        
        
        scrollSubView.addSubview(editProfileButton)
        editProfileButton.anchor(top: tfStack.bottomAnchor, left: scrollSubView.leftAnchor, right: scrollSubView.rightAnchor, paddingTop: 60, paddingLeft: 10, paddingRight: 10, height: 120)
        
        scrollSubView.addSubview(signOutButton)
        signOutButton.anchor(top: editProfileButton.bottomAnchor, left: scrollSubView.leftAnchor, bottom: scrollSubView.bottomAnchor, right: scrollSubView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 60, paddingRight: 10, height: 120)
        
    }

}
