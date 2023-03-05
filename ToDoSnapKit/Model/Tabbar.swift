import UIKit
import SnapKit

class Tabbar: UITabBarController {
    
    let btn = UIButton(type: .system)
    private let firstVC = HomeVC()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setuptabbar()
    }
    
//MARK: setUpTabbar
    
    func setuptabbar(){
        tabBar.addSubview(btn)
       
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 25
        btn.clipsToBounds = true
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(tabBar.snp.top).offset(-10)
        }
        
        btn.isUserInteractionEnabled = true
        btn.addTarget(self, action: #selector(addPressed(_:)), for: .touchUpInside)
        
        let vc1 = HomeVC()
        let item1 = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: nil)
        
        vc1.tabBarItem = item1
        
        let vc2 = TaskVC()
        let item2 = UITabBarItem(title: "Task", image: UIImage(systemName: "die.face.4"), selectedImage: nil)
        vc2.tabBarItem = item2
        
        let plusVC = PlusVC()
        let plusItem = UITabBarItem(title: nil, image: UIImage(systemName: "plus"), selectedImage: nil)
        tabBar.backgroundColor = .white
        plusVC.tabBarItem = plusItem
        tabBarController?.selectedIndex = 2
        viewControllers = [vc1,plusVC,vc2]
        DispatchQueue.main.async {
            if let items = self.tabBar.items {
                items[1].isEnabled = false
            }
        }
    }
    
    //MARK: @objc functions

    @objc func addPressed(_ sender: UIButton){
        let plusVC = PlusVC()
        plusVC.modalPresentationStyle = .fullScreen
        present(plusVC, animated: true)
    }
    
}


