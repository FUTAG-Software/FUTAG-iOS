//
//  FTSetPasswordViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 2.02.2022.
//

import UIKit

class FTSetPasswordViewController: UIViewController {

    //MARK: - Properties
    
    private lazy var scroolView: UIScrollView = {
        let sc = UIScrollView(frame: .zero)
        sc.backgroundColor = .white
        sc.contentSize.width = self.view.frame.width
        sc.frame = self.view.bounds
        sc.autoresizingMask = .flexibleHeight
        sc.showsHorizontalScrollIndicator = true
        sc.bounces = true
        
        return sc
    }()
    
    private lazy var scrollSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        
        return view
        
        
    }()
    
    private let setPasswordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.text = "Lütfen yeni şifrenizi giriniz"
        
        return label
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(systemName: "lock.fill")
        let view = Utilities().inputContainerView(withImage: image!, textField: passwordTextField)
        return view
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Şifre")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var newPasswordContainerView: UIView = {
        let image = UIImage(systemName: "lock.fill")
        let view = Utilities().inputContainerView(withImage: image!, textField: newPasswordTextField)
        return view
    }()
    
    private let newPasswordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Yeni Şifre")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var newPasswordAgainContainerView: UIView = {
        let image = UIImage(systemName: "lock.fill")
        let view = Utilities().inputContainerView(withImage: image!, textField: newPassWordAgainTextField)
        return view
    }()
    
    private let newPassWordAgainTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Yeni Şifre (Tekrar)")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var setPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Şifreyi Değiştir", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .clubYellow
        button.layer.cornerRadius = 20
        button.setDimensions(width: 100, height: 50)
        
//        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)

        
        return button
    }()
    
    private lazy var logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 150, height: 160)
        iv.image = UIImage(named: "futagLogoSiyah")
        iv.tintColor = .lightGray
        
        return iv
    }()
    
    private let clubLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.text = "#BIRKULUPTENDAHAFAZLASI"
        
        
        return label
    }()
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        configureUI()
    }
    
    //MARK: - API
    
    
    //MARK: - Selector
    
    @objc func setProfileInfoTapped() {
        let vc = FTSetProfileInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    //MARK: - Helper
    
    func configureUI() {
        
        view.backgroundColor = .white
        self.title = "Şifreyi Değiştir"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(scroolView)
        scroolView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0)
        
        scroolView.addSubview(scrollSubView)
        scrollSubView.anchor(top: scroolView.topAnchor, left: scroolView.leftAnchor, bottom: scroolView.bottomAnchor, width: view.frame.size.width)
        
        
        scrollSubView.addSubview(setPasswordLabel)
        setPasswordLabel.centerX(inView: scrollSubView, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
        
        let tfStack = UIStackView(arrangedSubviews: [ passwordContainerView,  newPasswordContainerView, newPasswordAgainContainerView])
        tfStack.axis = .vertical
        tfStack.spacing  = 15
        tfStack.distribution = .fillEqually
        
        scrollSubView.addSubview(tfStack)
        tfStack.anchor(top: setPasswordLabel.bottomAnchor, left: scrollSubView.leftAnchor, right: scrollSubView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: 10)
        
        
        scrollSubView.addSubview(setPasswordButton)
        setPasswordButton.anchor(top: tfStack.bottomAnchor, left: scrollSubView.leftAnchor, right: scrollSubView.rightAnchor, paddingTop: 40, paddingLeft: 10, paddingBottom: 60, paddingRight: 10, height: 120)
        
        scrollSubView.addSubview(logoImageView)
        logoImageView.centerX(inView: scrollSubView, topAnchor: setPasswordButton.bottomAnchor, paddingTop: 30)
        
        scrollSubView.addSubview(clubLabel)
        clubLabel.anchor(top: logoImageView.bottomAnchor, left: scrollSubView.leftAnchor, bottom: scrollSubView.bottomAnchor, right: scrollSubView.rightAnchor, paddingTop: 10, paddingBottom: 80)
        
        
        
    }

}