//
//  FTForgotPasswordViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 27.02.2022.
//

import Foundation
import UIKit

protocol ResetPasswordControllerDelegate: class {
    func controllerDidSendResetPasswordLink(_ controller: FTForgotPasswordViewController)
}

class FTForgotPasswordViewController: UIViewController {
    
    //MARK: - Properties
    
    private var viewModel = ResetPasswordViewModel()
    weak var delegate: ResetPasswordControllerDelegate?
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.text = "Şifremi Unuttum"
        
        
        return label
    }()
    
    private let infoTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = .max
        label.textAlignment = .center
        label.text = "Şifrenizi yenilemek için lütfen e-posta adresinizi giriniz."
        
        
        return label
    }()
    
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(systemName: "envelope.fill")
        let view = Utilities().inputContainerView(withImage: image!, textField: emailTextField)
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Mailiniz")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Gönder", for: .normal)
        button.setTitleColor(.clubGray, for: .normal)
        button.backgroundColor = .clubYellow.withAlphaComponent(0.5)
        button.layer.cornerRadius = 20
        
        button.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)

        
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
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.text = "#BIRKULUPTENDAHAFAZLASI"
        
        
        return label
    }()
    
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.setDimensions(width: 40, height: 40)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        
        return button
    }()
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureUI()
        view.backgroundColor = .systemBackground
        
    }
    
    //MARK: - API
    
    
    //MARK: - Selector
    
    @objc func sendButtonPressed() {
        
        print("xxxxx")
        
        guard let email = emailTextField.text?.lowercased() else {return}
        
        showLoader(true)
        AuthService.resetPassword(withEmail: email) { error in
            if let error = error {
                self.showMessage(withTitle: "Hata", message: error.localizedDescription)
                
                self.showLoader(false)
                
                return
            }
            
            self.delegate?.controllerDidSendResetPasswordLink(self)
         
        }
        
    }
    
    @objc func backButtonTapped() {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            
            viewModel.email = sender.text
            
        }
        
        updateForm()
    }
    
    
    
    //MARK: - Helper
    
    func configureUI() {
        
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: -4, paddingLeft: 20)
        
        view.addSubview(registerLabel)
        registerLabel.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        
        view.addSubview(infoTextLabel)
        infoTextLabel.anchor(top: registerLabel.bottomAnchor , left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
        
        
        view.addSubview(emailContainerView)
        emailContainerView.anchor(top: infoTextLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 30, paddingRight: 30)
        
        view.addSubview(registerButton)
        registerButton.anchor(top: emailContainerView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40,  paddingRight: 40, height: 50)
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: registerButton.bottomAnchor, paddingTop: 30)
        
        view.addSubview(clubLabel)
        clubLabel.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor,  right: view.rightAnchor, paddingTop: 10, paddingBottom: 80)
        
    }
    

}

extension FTForgotPasswordViewController: FormViewModel {
    func updateForm() {
        registerButton.backgroundColor = viewModel.buttonBackgroundColor
        registerButton.isEnabled = viewModel.formIsValid
    }
    
    
    
}



