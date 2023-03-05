import SnapKit
import UIKit

class StartVC: UIViewController {
    
    //MARK: Variables
   
    let img : UIImageView = {
       let i = UIImageView()
        i.image = UIImage(named: "StartVCImage")
        i.translatesAutoresizingMaskIntoConstraints = false
        i.heightAnchor.constraint(equalToConstant: 242).isActive = true
        i.widthAnchor.constraint(equalToConstant: 219).isActive = true
        return i
    }()
   
    let titleLable : UILabel = {
       let lbl = UILabel()
        lbl.text = "Remenders made simple"
        lbl.textColor = #colorLiteral(red: 0.3333333333, green: 0.3058823529, blue: 0.5607843137, alpha: 1)
        lbl.font = UIFont(name: "Rubik-Medium", size: 20)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let textLable : UILabel = {
       let lbl = UILabel()
        lbl.text  = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris pllentasque erat in blandit luctus"
        lbl.font = UIFont(name: "OpenSans-VariableFont_wdth,wght", size: 17)
        lbl.textColor = #colorLiteral(red: 0.5098039216, green: 0.6274509804, blue: 0.7176470588, alpha: 1)
        lbl.textAlignment = .center
        lbl.numberOfLines = 3
        return lbl
    }()
    
    @objc let getStartedBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Get started", for: .normal)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = #colorLiteral(red: 0.3803921569, green: 0.9019607843, blue: 0.1019607843, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 228).isActive = true
        btn.addTarget(self, action: #selector(getStartedPressed(_ :)), for: .touchUpInside)
        return btn
    }()
    
    let stacView1 : UIStackView = {
       let stc = UIStackView()
        stc.axis = .vertical
        stc.alignment = .center
        stc.spacing = 51
        return stc
    }()

    let stacView2 : UIStackView = {
       let stc = UIStackView()
        stc.axis = .vertical
        stc.spacing = 70
        return stc
    }()
    
    let mainStacView : UIStackView = {
       let stc = UIStackView()
        stc.axis = .vertical
        stc.spacing = 21
        return stc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupElements()
        self.getStartedBtn.isUserInteractionEnabled = true
    }

    func setupElements(){
        view.addSubview(mainStacView)
        
        stacView1.addArrangedSubview(img)
        stacView1.addArrangedSubview(titleLable)
        stacView2.addArrangedSubview(textLable)
        stacView2.addArrangedSubview(getStartedBtn)
        
        mainStacView.addArrangedSubview(stacView1)
        mainStacView.addArrangedSubview(stacView2)
        
        mainStacView.snp.makeConstraints { make in
            make.top.equalTo(139)
            make.left.equalTo(31)
            make.right.equalTo(-31)
        }

    }
    
    @objc private func getStartedPressed(_ sender : UIButton){
       let vc = LoginVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
