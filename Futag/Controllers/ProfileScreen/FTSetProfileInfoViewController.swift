//
//  FTSetProfileInfoViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 2.02.2022.
//

import UIKit
import SDWebImage
import FirebaseFirestore
import Firebase
import AVFoundation

var isDeleteAcount = false

class FTSetProfileInfoViewController: UIViewController {

    //MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    var selectedImage: URL?
    var selectedName: String?
    var selectedSurname: String?
    var selectedBirthday: String?
    
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
        iv.sd_setImage(with: self.selectedImage, completed: nil)
        iv.tintColor = .clubGray
        iv.layer.cornerRadius = 75
        iv.layer.masksToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleAddProfilePhoto))
            iv.isUserInteractionEnabled = true
            iv.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        return iv
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.text = selectedName
        
        
        return label
    }()
    
    private lazy var nameContainerView: UIView = {
        let image = UIImage(systemName: "person.fill")
        let view = Utilities().inputContainerView(withImage: image!, textField: nameTextField)
        return view
    }()
    
    private lazy var nameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Adınız")
        tf.text = selectedName
        return tf
    }()
    
    private lazy var surnameameContainerView: UIView = {
        let image = UIImage(systemName: "person.fill")
        let view = Utilities().inputContainerView(withImage: image!, textField: surnameTextField)
        return view
    }()
    
    private lazy var surnameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Soyadınız")
        tf.text = selectedSurname
        return tf
    }()
    
    private lazy var birhdayContainerView: UIView = {
        let image = UIImage(systemName: "calendar")
        let view = Utilities().inputContainerView(withImage: image!, textField: birthdayTextField)
        return view
    }()
    
    let datePicker = UIDatePicker()

    
    private lazy var birthdayTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Doğum Gününüz")
        tf.text = selectedBirthday
        return tf
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Değişiklikleri Kaydet", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .clubYellow
        button.layer.cornerRadius = 20
        button.setDimensions(width: 100, height: 50)
        
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)

        
        return button
    }()
    
    private lazy var setPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Şifreyi Değiştir", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .clubYellow
        button.layer.cornerRadius = 20
        button.setDimensions(width: 100, height: 50)
        
        button.addTarget(self, action: #selector(setPasswordButtonPressed), for: .touchUpInside)

        
        return button
    }()
    
    private lazy var deleteAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hesabımı Sil", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .clubYellow
        button.layer.cornerRadius = 20
        button.setDimensions(width: 100, height: 50)
        
        button.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)

        
        return button
    }()
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        configureUI()
        
        showDatePicker()
    }
    
    //MARK: - API
    
    
    //MARK: - Selector
    
    @objc func setPasswordButtonPressed() {
        let vc = FTSetPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func deleteButtonPressed() {
        let user = Auth.auth().currentUser
        
        showLoader(true)
        

        user?.delete { error in
          if let error = error {
              print("DEBUG: Error is \(error.localizedDescription)")
              
              do {
                  try Auth.auth().signOut()
                  let controller = FTLoginScreenViewController()
                  controller.delegate = self.tabBarController as? FTMainTabBarControllerViewController
                  let nav = UINavigationController(rootViewController: controller)
                  nav.modalPresentationStyle = .fullScreen
                  isDeleteAcount = true
                  
                  self.present(nav, animated: true, completion: nil)
                  
                  
              } catch {
                  print("DEBUG: Failed to log user out")
              }
              
          } else {
            // Account deleted.
              
              print("Account Deleted")
              
              self.showLoader(false)
              
              let controller = FTLoginScreenViewController()
              controller.delegate = self.tabBarController as? FTMainTabBarControllerViewController
              let nav = UINavigationController(rootViewController: controller)
              nav.modalPresentationStyle = .fullScreen
              self.present(nav, animated: true, completion: nil)
          }
        }
    }
    
    @objc func saveButtonPressed() {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        
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
        
        guard let birthday = birthdayTextField.text?.trimmingCharacters(in: .whitespaces),
              !birthday.isEmpty else {
            showMessage(withTitle: "Soyad", message: "Lütfen soyadınızı girin")
            return
        }
        
        let values = ["name": name,
                      "surname": surname,
                      "birthday":  birthday] as [String : Any]
        
        showLoader(true)

        COLLECTION_USERS.document(uid).updateData(values) { err in
            if let error = err {
                self.showMessage(withTitle: "Hata", message: error.localizedDescription)
                self.showLoader(false)
            }
            
            self.showLoader(false)
        }
        
    }
    
    func setProfileImage() {
        
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
        
        
        self.title = "Profili Düzenle"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(scroolView)
        scroolView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0)
        
        scroolView.addSubview(scrollSubView)
        scrollSubView.anchor(top: scroolView.topAnchor, left: scroolView.leftAnchor, bottom: scroolView.bottomAnchor, width: view.frame.size.width)
        
        scrollSubView.addSubview(profileImageView)
        profileImageView.centerX(inView: scrollSubView, topAnchor: scrollSubView.safeAreaLayoutGuide.topAnchor)
        
        
        let tfStack = UIStackView(arrangedSubviews: [ nameContainerView, surnameameContainerView,  birhdayContainerView])
        tfStack.axis = .vertical
        tfStack.spacing  = 15
        tfStack.distribution = .fillEqually
        
        scrollSubView.addSubview(tfStack)
        tfStack.anchor(top: profileImageView.bottomAnchor, left: scrollSubView.leftAnchor, right: scrollSubView.rightAnchor, paddingTop: 40, paddingLeft: 10, paddingRight: 10)
        
        
        scrollSubView.addSubview(editProfileButton)
        editProfileButton.anchor(top: tfStack.bottomAnchor, left: scrollSubView.leftAnchor, right: scrollSubView.rightAnchor, paddingTop: 60, paddingLeft: 10, paddingRight: 10, height: 120)
        
        scrollSubView.addSubview(setPasswordButton)
        setPasswordButton.anchor(top: editProfileButton.bottomAnchor, left: scrollSubView.leftAnchor, right: scrollSubView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: 10, height: 120)
        
        
        scrollSubView.addSubview(deleteAccountButton)
        deleteAccountButton.anchor(top: setPasswordButton.bottomAnchor, left: scrollSubView.leftAnchor, bottom: scrollSubView.bottomAnchor, right: scrollSubView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 60, paddingRight: 10, height: 120)
        
        
        
    }
    
    func updateProfileImage() {
            guard let image = profileImage else { return }
        
        self.showLoader(true)
            
        AuthService.shared.updateProfileImage(image: image) { profileImageUrl in
            self.showLoader(false)
            }
        }

}

extension FTSetProfileInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        
        profileImageView.setDimensions(width: 150, height: 150)
        profileImageView.layer.cornerRadius = 150 / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.tintColor = .clubGray
        profileImageView.layer.borderColor = UIColor.white.cgColor
        
        self.profileImageView.image = profileImage.withRenderingMode(.alwaysOriginal)
        
        
        
        dismiss(animated: true) {
            print("XCXCXC")
            self.updateProfileImage()
        }
    }
    
}
