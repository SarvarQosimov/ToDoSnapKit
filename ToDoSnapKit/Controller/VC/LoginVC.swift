import UIKit

class LoginVC: UIViewController {
    
    //MARK: Varialbe
    
    let selectImgBtn : UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(systemName: "camera"), for: .normal)
        btn.setTitle("", for: .normal)
        btn.layer.cornerRadius = 75
        btn.backgroundColor = #colorLiteral(red: 0.3679881692, green: 0.6620878577, blue: 0.9280409217, alpha: 1)
        btn.tintColor = .white
        btn.heightAnchor.constraint(equalToConstant: 150).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        btn.layer.cornerRadius = 75
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(selectImgPressed(_ :)), for: .touchUpInside)
        return btn
    }()
    
    let stckViewForBtn : UIStackView = {
       let stc = UIStackView()
        stc.axis = .vertical
        stc.alignment = .center
        return stc
    }()
    
    let surnameTF : UITextField = {
       let tf = UITextField()
        tf.placeholder = "   Surname"
        tf.layer.cornerRadius = 14
        tf.layer.borderWidth = 1
        tf.layer.borderColor = #colorLiteral(red: 0.8739379048, green: 0.8988533616, blue: 0.9541849494, alpha: 1)
        tf.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return tf
    }()
    
    let lastNameTF : UITextField = {
       let tf = UITextField()
        tf.placeholder = "   Lastname"
        tf.layer.cornerRadius = 14
        tf.layer.borderWidth = 1
        tf.layer.borderColor = #colorLiteral(red: 0.8739379048, green: 0.8988533616, blue: 0.9541849494, alpha: 1)
        tf.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return tf
    }()
    
    let emailTF : UITextField = {
       let tf = UITextField()
        tf.placeholder = "   E-mail"
        tf.layer.cornerRadius = 14
        tf.layer.borderWidth = 1
        tf.layer.borderColor = #colorLiteral(red: 0.8739379048, green: 0.8988533616, blue: 0.9541849494, alpha: 1)
        tf.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return tf
    }()
    
    let stackViewForTFs : UIStackView = {
       let stc = UIStackView()
        stc.axis = .vertical
        stc.spacing = 10
        return stc
    }()
    
    let signUpBtn : UIButton = {
       let btn = UIButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.3398018777, green: 0.8421423435, blue: 0.07016777247, alpha: 1)
        btn.layer.cornerRadius = 8
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 228).isActive = true
        btn.addTarget(self, action: #selector(signUpPressed(_ :)), for: .touchUpInside)
        return btn
    }()
    
    let mainStackView : UIStackView = {
       let stc = UIStackView()
        stc.axis = .vertical
        stc.spacing = 63
        return stc
    }()
            
    var userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupElements()
        
    }
    
    //MARK: @objc func

    @objc func selectImgPressed(_ sender : Any){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc func signUpPressed(_ sender : Any){
       
        let vc = Tabbar()
        let img = selectImgBtn.imageView?.image?.toJpegString(compressionQuality:10)
              
        surnameTF.layer.borderColor = UIColor.white.cgColor
        lastNameTF.layer.borderColor = UIColor.white.cgColor
        emailTF.layer.borderColor = UIColor.white.cgColor
        
        if !surnameTF.text!.isEmpty {
            if !lastNameTF.text!.isEmpty {
                if !emailTF.text!.isEmpty {
                   //
                    userDefaults.set(img, forKey: "userImg")
                   
                    userDefaults.set(surnameTF.text, forKey: "surnameTF.text")
                    userDefaults.set(lastNameTF.text, forKey: "lastNameTF.text")
                    userDefaults.set(emailTF.text, forKey: "emailTF.text")
                    userDefaults.set(true, forKey: "isLogin")
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: true)
                    //
                } else {
                    emailTF.layer.borderWidth = 1
                    emailTF.layer.borderColor = UIColor.red.cgColor
                }
            } else {
                lastNameTF.layer.borderWidth = 1
                lastNameTF.layer.borderColor = UIColor.red.cgColor
            }
        } else {
            surnameTF.layer.borderWidth = 1
            surnameTF.layer.borderColor = UIColor.red.cgColor
        }
        
    }
    
    //MARK: Functions
    
    func setupElements(){
        view.addSubview(mainStackView)
        
        stckViewForBtn.addArrangedSubview(selectImgBtn)
        
        stackViewForTFs.addArrangedSubview(surnameTF)
        stackViewForTFs.addArrangedSubview(lastNameTF)
        stackViewForTFs.addArrangedSubview(emailTF)
        
        mainStackView.addArrangedSubview(stckViewForBtn)
        mainStackView.addArrangedSubview(stackViewForTFs)
        mainStackView.addArrangedSubview(signUpBtn)

        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(128)
            make.left.equalTo(37)
            make.right.equalTo(-38)
        }
        
    }
    
}

//MARK: UIImagePickerControllerDelegate

extension LoginVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        selectImgBtn.setImage(image, for: .normal)
        dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}
