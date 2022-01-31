//
//  FTOnBoardingScreen2ViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 9.01.2022.
//

import UIKit
import Lottie

class FTOnBoardingScreen2ViewController: UIViewController {

    //MARK: - Properties
    
    
    private var animationView: AnimationView?
    
    private let blogLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.text = "İster Blog Yazılarını Oku İstersen Etkinliklere Tek Tıkla Kayıt Ol"
        
        
        
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("İleri", for: .normal)
        button.backgroundColor = .animation1Blue
        button.layer.cornerRadius = 20
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        
        
        
        return button
    }()
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.configureUI()
        
        
    }
    
    //MARK: - API
    
    
    //MARK: - Helper
    
    func configureUI() {
        view.backgroundColor = .white
        
        //Animation View
        
        animationView = .init(name: "blog")
          
        animationView!.frame = view.bounds
          
        animationView!.contentMode = .scaleAspectFit
          
        animationView!.loopMode = .loop
          
        animationView!.animationSpeed = 0.5
          
        view.addSubview(animationView!)
        animationView?.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 50, width: 240, height: 240)
          
        animationView!.play()
        
        //Blog Label
        
        view.addSubview(blogLabel)
        blogLabel.anchor(top: animationView?.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 60)
        
        view.addSubview(nextButton)
        nextButton.anchor(left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingBottom: 40, paddingRight: 40, height: 40)
        
    }
    
    // MARK: - Selectors
    
    @objc func buttonPressed() {
        
        print("DEBUG: Buton pressed")
        
        let vc = FTOnBoardingScreen3ViewController()
        
        navigationController?.pushViewController(vc, animated: true)
        
    }

}
