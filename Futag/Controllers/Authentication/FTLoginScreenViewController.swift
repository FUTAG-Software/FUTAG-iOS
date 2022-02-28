//
//  FTLoginScreenViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 24.02.2022.
//

import UIKit

protocol AuthenticationDelegate: class {
    func authenticationDidComplete()
}

class FTLoginScreenViewController: UIViewController {

    //MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    weak var delegate: AuthenticationDelegate?
    
    private var viewModel = LoginViewModel()
    
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
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.text = "Giriş Yap"
        
        
        return label
    }()
    
    private let infoTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = .max
        label.textAlignment = .center
        label.text = "Giriş yapmak için bilgilerinizi giriniz"
        
        
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
    
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Giriş Yap", for: .normal)
        button.setTitleColor(.clubGray, for: .normal)
        button.backgroundColor = .clubYellow.withAlphaComponent(0.5)
        button.layer.cornerRadius = 20
        
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)

        
        return button
    }()
    
    private let haveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Hesabın yok mu?"
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = .lightGray
        label.numberOfLines = 2
        
        return label
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(.clubYellow, for: .normal)
        button.setTitle("Kayıt Ol", for: .normal)
        button.setDimensions(width: 80, height: 30)
        
        button.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        
        
        return button
    }()
    
    private lazy var forgotPassLabel: UILabel = {
        let label = UILabel()
        label.text = "Şifreni mi unuttun?"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textColor = .lightGray
        label.numberOfLines = 2
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
                label.isUserInteractionEnabled = true
                label.addGestureRecognizer(tap)
        
        return label
    }()
    
    private lazy var logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 150, height: 160)
        iv.image = UIImage(named: "futagLogoSiyah")
        iv.tintColor = .lightGray
        
        return iv
    }()
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.configureUI()
        
    }
    
    //MARK: - API
    
    
    //MARK: - Selector
    
    @objc func loginButtonAction() {
        
        let vc = FTRegisterViewController()
        vc.delegate = delegate
        
        navigationController?.pushViewController(vc, animated: true)
        
    
    }
    
    @objc func registerButtonPressed() {
        
        print("xyxy")
        
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespaces).lowercased(),
              !email.isEmpty else {
            showMessage(withTitle: "Email", message: "Lütfen email adresinizi girin")
            return
        }
        guard let password = passwordTextField.text?.trimmingCharacters(in: .whitespaces).lowercased(),
              !password.isEmpty else {
            showMessage(withTitle: "Parola", message: "Lütfen parolanızı girin")
            return
        }
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Failed to log user in \(error.localizedDescription)")
                self.showMessage(withTitle: "Hata", message: error.localizedDescription)
                return
            }
            
            self.delegate?.authenticationDidComplete()
            
            
        }
        
        
       
        
        
    }
    
    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func labelTapped() {
        
        print("xxx")
        let controller = FTForgotPasswordViewController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
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
        
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        view.addSubview(scroolView)
        scroolView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0)
        
        scroolView.addSubview(scrollSubView)
        scrollSubView.anchor(top: scroolView.topAnchor, left: scroolView.leftAnchor, bottom: scroolView.bottomAnchor, width: view.frame.size.width)
        
        scrollSubView.addSubview(registerLabel)
        registerLabel.centerX(inView: scrollSubView, topAnchor: scrollSubView.safeAreaLayoutGuide.topAnchor)
        
        scrollSubView.addSubview(infoTextLabel)
        infoTextLabel.centerX(inView: scrollSubView, topAnchor: registerLabel.bottomAnchor, paddingTop: 10)
        
        
        let tfStack = UIStackView(arrangedSubviews: [  emailContainerView, passwordContainerView])
        tfStack.axis = .vertical
        tfStack.spacing  = 15
        tfStack.distribution = .fillEqually
        
        scrollSubView.addSubview(tfStack)
        tfStack.anchor(top: infoTextLabel.bottomAnchor, left: scrollSubView.leftAnchor, right: scrollSubView.rightAnchor, paddingTop: 40, paddingLeft: 30, paddingRight: 30)
        
        scrollSubView.addSubview(registerButton)
        registerButton.anchor(top: tfStack.bottomAnchor, left: scrollSubView.leftAnchor, right: scrollSubView.rightAnchor, paddingTop: 40, paddingLeft: 40,  paddingRight: 40, height: 50)
        
        scrollSubView.addSubview(forgotPassLabel)
        forgotPassLabel.centerX(inView: scrollSubView, topAnchor: registerButton.bottomAnchor, paddingTop: 20)
        
        scrollSubView.addSubview(logoImageView)
        logoImageView.centerX(inView: scrollSubView, topAnchor: forgotPassLabel.bottomAnchor, paddingTop: 20)
        
        scrollSubView.addSubview(haveAccountLabel)
        haveAccountLabel.anchor(top: logoImageView.bottomAnchor, left: registerButton.leftAnchor,bottom: scrollSubView.bottomAnchor, paddingTop: 20, paddingLeft: 70, paddingBottom: 20)

        scrollSubView.addSubview(logInButton)
        logInButton.anchor(top: logoImageView.bottomAnchor, left: haveAccountLabel.rightAnchor, bottom: scrollSubView.bottomAnchor, paddingTop: 20, paddingLeft: -5, paddingBottom: 20)
        
    }
    
    func configureNotificationObservers(){
        
    }
    
    
}

//MARK: - FormViewModel

extension FTLoginScreenViewController: FormViewModel {
    func updateForm() {
        registerButton.backgroundColor = viewModel.buttonBackgroundColor
        registerButton.isEnabled = viewModel.formIsValid
    }
    
}

//MARK: - ResetPasswordControllerDelegate

extension FTLoginScreenViewController: ResetPasswordControllerDelegate {
    func controllerDidSendResetPasswordLink(_ controller: FTForgotPasswordViewController) {
        navigationController?.popViewController(animated: true)
        self.showMessage(withTitle: "Başarılı", message: "Email adresinize şifre yenileme linkini gönderdik")
    }
    
    
}

