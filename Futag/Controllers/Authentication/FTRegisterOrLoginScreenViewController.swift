//
//  FTRegisterOrLoginScreenViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 9.01.2022.
//

import UIKit

class FTRegisterOrLoginScreenViewController: UIViewController {

    //MARK: - Properties
    
    private let logoHeadImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "topLogoHead")
        
        
        return iv
    }()
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 110, height: 120)
        iv.image = UIImage(named: "futagLogoSiyah")
        
        
        return iv
    }()
    
    private let clubLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.text = "#BIRKULUPTENDAHAFAZLASI"
        
        
        return label
    }()
    
    private let inspireTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = .max
        label.textAlignment = .center
        label.text = "Başarı, zaman içerisinde çok çalışmaya ve tutkuyla bağlıdır. Eğer gerçekten çok çalışırsanız, uzun bir süre boyunca gerçekten çok çalışırsanız, karşılığını alacaksınız."
        
        
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Giriş Yap", for: .normal)
        button.setTitleColor(.clubGray, for: .normal)
        button.backgroundColor = .clubYellow
        button.layer.cornerRadius = 20
        
        button.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)

        
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Kayıt Ol", for: .normal)
        button.setTitleColor(.clubGray, for: .normal)
        button.backgroundColor = .clubYellow
        button.layer.cornerRadius = 20
        
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)

        
        return button
    }()
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureUI()
        
        
    }
    
    //MARK: - API
    
    
    //MARK: - Helper
    
    func configureUI() {
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoHeadImageView)
        logoHeadImageView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: -200)
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: self.view, topAnchor: logoHeadImageView.bottomAnchor, paddingTop: -140)
        
        view.addSubview(clubLabel)
        clubLabel.centerX(inView: self.view, topAnchor: logoImageView.bottomAnchor, paddingTop: 20)
        
        view.addSubview(inspireTextLabel)
        inspireTextLabel.anchor(top: clubLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
        let buttonStack = UIStackView(arrangedSubviews: [loginButton, registerButton])
        buttonStack.axis = .vertical
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 20
        view.addSubview(buttonStack)
        buttonStack.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingBottom: 20, paddingRight: 40, height: 120)
        
    }
    
    @objc func logInButtonPressed() {
        print("zxzxzx")
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc func registerButtonPressed() {
        
        let vc = FTRegisterViewController()
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true, completion: nil)
        
    }

}
