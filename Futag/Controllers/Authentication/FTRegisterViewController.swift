//
//  FTRegisterViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 9.01.2022.
//

import UIKit

class FTRegisterViewController: UIViewController {

    //MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
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
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.text = "Kayıt Ol"
        
        
        return label
    }()
    
    private let infoTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = .max
        label.textAlignment = .center
        label.text = "Kaydolmak için bilgilerinizi ekleyin"
        
        
        return label
    }()
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .clubGray
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameContainerView: UIView = {
        let image = UIImage(systemName: "person.fill")
        let view = Utilities().inputContainerView(withImage: image!, textField: nameTextField)
        return view
    }()
    
    private let nameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Adınız")
        return tf
    }()
    
    private lazy var surnameameContainerView: UIView = {
        let image = UIImage(systemName: "person.fill")
        let view = Utilities().inputContainerView(withImage: image!, textField: surnameTextField)
        return view
    }()
    
    private let surnameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Soyadınız")
        return tf
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
        let image = UIImage(systemName: "key.fill")
        let view = Utilities().inputContainerView(withImage: image!, textField: passwordTextField)
        return view
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Şifre")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var passwordAgainContainerView: UIView = {
        let image = UIImage(systemName: "key.fill")
        let view = Utilities().inputContainerView(withImage: image!, textField: passWordAgainTextField)
        return view
    }()
    
    private let passWordAgainTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Şifre (Tekrar)")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var birhdayContainerView: UIView = {
        let image = UIImage(systemName: "calendar")
        let view = Utilities().inputContainerView(withImage: image!, textField: birthdayTextField)
        return view
    }()
    
    private let birthdayTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Doğum Gününüz")
        return tf
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
    
    private let haveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Zaten Hesabın Var Mı ?"
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = .lightGray
        label.numberOfLines = 2
        
        return label
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(.clubYellow, for: .normal)
        button.setTitle("Giriş Yap", for: .normal)
        button.setDimensions(width: 80, height: 30)
        
        button.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        
        
        return button
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
        
        
    
    }
    
    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    //MARK: - Helper
    
    func configureUI() {
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(scroolView)
        scroolView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0)
        
        scroolView.addSubview(scrollSubView)
        scrollSubView.anchor(top: scroolView.topAnchor, left: scroolView.leftAnchor, bottom: scroolView.bottomAnchor, width: view.frame.size.width)
        
        scrollSubView.addSubview(registerLabel)
        registerLabel.centerX(inView: scrollSubView, topAnchor: scrollSubView.safeAreaLayoutGuide.topAnchor)
        
        scrollSubView.addSubview(infoTextLabel)
        infoTextLabel.centerX(inView: scrollSubView, topAnchor: registerLabel.bottomAnchor, paddingTop: 10)
        
        scrollSubView.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: scrollSubView, topAnchor: infoTextLabel.bottomAnchor, paddingTop: 10)
        plusPhotoButton.setDimensions(width: 128, height: 128)
        
        let tfStack = UIStackView(arrangedSubviews: [nameContainerView, surnameameContainerView, emailContainerView, passwordContainerView, passwordAgainContainerView, birhdayContainerView])
        tfStack.axis = .vertical
        tfStack.spacing  = 15
        tfStack.distribution = .fillEqually
        
        scrollSubView.addSubview(tfStack)
        tfStack.anchor(top: plusPhotoButton.bottomAnchor, left: scrollSubView.leftAnchor, right: scrollSubView.rightAnchor, paddingTop: 40, paddingLeft: 30, paddingRight: 30)
        
        scrollSubView.addSubview(registerButton)
        registerButton.anchor(top: tfStack.bottomAnchor, left: scrollSubView.leftAnchor, right: scrollSubView.rightAnchor, paddingTop: 40, paddingLeft: 40,  paddingRight: 40, height: 50)
        
        scrollSubView.addSubview(haveAccountLabel)
        haveAccountLabel.anchor(top: registerButton.bottomAnchor, left: registerButton.leftAnchor,bottom: scrollSubView.bottomAnchor, paddingTop: 30, paddingLeft: 50, paddingBottom: 20)

        scrollSubView.addSubview(logInButton)
        logInButton.anchor(top: registerButton.bottomAnchor, left: haveAccountLabel.rightAnchor, bottom: scrollSubView.bottomAnchor, paddingTop: 27.5, paddingLeft: -5, paddingBottom: 20)
        
    }
    
    
    @objc func registerButtonPressed() {
        
        
        let profileImage = profileImage
        guard let email = emailTextField.text?.lowercased() else { return }
        guard let password = passwordTextField.text else { return }
        guard let name = nameTextField.text else { return }
        guard let surname = surnameTextField.text else { return }
        guard let birhday = birthdayTextField.text else { return }
        
        
        
        let credentials = AuthCredentials(email: email, password: password, name: name, surname: surname, profileImage: profileImage, birthday: birhday)
        
        AuthService.shared.registerUser(withCredential: credentials) { error in
            if let error = error {
                print("DEBUG: Failed to register user \(error.localizedDescription)")
                
                return
            }
            print("DEBUG: Successfuly registered user with firestore..")
        }
        
        
    }

}

// MARK: - UIImagePickerControllerDelegate

extension FTRegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        
        plusPhotoButton.layer.cornerRadius = 128 / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
    
}
