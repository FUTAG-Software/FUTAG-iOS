//
//  FTRegisterViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 9.01.2022.
//

import UIKit
import FirebaseMessaging
import FirebaseFirestore
import Firebase

class FTRegisterViewController: UIViewController {

    //MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    weak var delegate: AuthenticationDelegate?
    
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
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.text = "Kayıt Ol"
        
        
        return label
    }()
    
    private let infoTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = .max
        label.textAlignment = .center
        label.text = "Kaydolmak için bilgilerinizi ekleyin"
        
        
        return label
    }()
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
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
        let image = UIImage(systemName: "lock.fill")
        let view = Utilities().inputContainerView(withImage: image!, textField: passwordTextField)
        return view
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Şifre")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var passwordAgainContainerView: UIView = {
        let image = UIImage(systemName: "lock.fill")
        let view = Utilities().inputContainerView(withImage: image!, textField: passWordAgainTextField)
        return view
    }()
    
    private let passWordAgainTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Şifre (Tekrar)")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let datePicker = UIDatePicker()
    
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
    
    private let loginAccountButton: UIButton = {
        let button = Utilities().attributedButton("Zaten Hesabın Var Mı?", " Giriş Yap")
        button.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        return button
    }()
    
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.configureUI()
        showDatePicker()
    }
    
    //MARK: - API
    
    
    //MARK: - Selector
    
    @objc func loginButtonAction() {
        
        print("xxxx")
        
        navigationController?.popViewController(animated: true)
        
        
    
    }
    
    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date

       //ToolBar
       let toolbar = UIToolbar();
       toolbar.sizeToFit()
       let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
      let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

     toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        birthdayTextField.inputAccessoryView = toolbar
        birthdayTextField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){

       let formatter = DateFormatter()
       formatter.dateFormat = "dd-MM-yyyy"
       birthdayTextField.text = formatter.string(from: datePicker.date)
       self.view.endEditing(true)
     }

     @objc func cancelDatePicker(){
        self.view.endEditing(true)
      }
    

    
    
    //MARK: - Helper
    
    func configureUI() {
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        switch traitCollection.userInterfaceStyle {
        case .dark:
            print("Dark")
            plusPhotoButton.tintColor = .white
            plusPhotoButton.setImage(UIImage(named: "userProfileWhite"), for: .normal)
            
            
        case .light:
            plusPhotoButton.tintColor = .clubGray
            plusPhotoButton.setImage(UIImage(named: "userProfileBlack"), for: .normal)
        default:
            print("something else")
        }
        
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
        
        scrollSubView.addSubview(loginAccountButton)
        loginAccountButton.anchor(top: registerButton.bottomAnchor, left: scrollSubView.leftAnchor,
                                     bottom: scrollSubView.safeAreaLayoutGuide.bottomAnchor,
                                     right: scrollSubView.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 20, paddingRight: 40)
        
    }
    
    
    @objc func registerButtonPressed() {
        
        
        var profileImage = profileImage
        if profileImage == nil {
            
            profileImage = UIImage(named: "userDefaultProfile1")
        }
        
        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespaces),
              !name.isEmpty else {
            showMessage(withTitle: "İsim", message: "Lütfen isminizi girin")
            return
        }
        guard let surname = surnameTextField.text?.trimmingCharacters(in: .whitespaces),
              !surname.isEmpty else {
            showMessage(withTitle: "Soyad", message: "Lütfen soyadınızı girin")
            return
        }
        
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespaces).lowercased(),
              !email.isEmpty else {
            showMessage(withTitle: "Email", message: "Lütfen email adresinizi girin")
            return
        }
        guard let password = passwordTextField.text?.trimmingCharacters(in: .whitespaces),
              !password.isEmpty else {
            showMessage(withTitle: "Parola", message: "Lütfen parolanızı girin")
            return
        }
       
        let birhday = birthdayTextField.text
        
        if passwordTextField.text != passWordAgainTextField.text {
            showMessage(withTitle: "Hata", message: "Girdiğiniz parolalar eşleşmiyor")
            
            return
        }



        let credentials = AuthCredentials(email: email, password: password, name: name, surname: surname, profileImage: profileImage, birthday: birhday)
        
        showLoader(true)

        AuthService.shared.registerUser(withCredential: credentials) { error in
            if let error = error {
                print("DEBUG: Failed to register user \(error.localizedDescription)")
                
                self.showLoader(false)

                return
            }
            print("DEBUG: Successfuly registered user with firestore..")
            self.showLoader(false)
            
            Messaging.messaging().subscribe(toTopic: "food_notification") { error in
              print("Subscribed to food_notification topic")
            }
            
            Messaging.messaging().subscribe(toTopic: "futag_notification") { error in
              print("Subscribed to futag_notification topic")
            }
            
            self.delegate?.authenticationDidComplete()
                
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
