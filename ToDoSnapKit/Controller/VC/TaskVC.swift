
import UIKit
import CoreData

class TaskVC: UIViewController {
    //MARK: Elements
    
    let mainView = UIView()
    let nameLbl = UILabel()
    let warningLbl = UILabel()
    let userImg = UIImageView()
    let projectsLbl = UILabel()
    
    private (set) lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 23
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 160, height: 180)
        let cv = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        cv.layer.cornerRadius = 6
        cv.clipsToBounds = true
        cv.backgroundColor = .clear
        cv.register(Cell.self, forCellWithReuseIdentifier: "Cell")
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()

    //MARK: Variables

    let context = ( UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var names = ["personal","work","meeting","study","shopping","party"]
    var sortedPersonal = [Core2]()
    var sortedWork = [Core2]()
    var sortedMeeting = [Core2]()
    var sortedStudy = [Core2]()
    var sortedShopping = [Core2]()
    var sortedParty = [Core2]()
    var allCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        addSubView()
        initElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        collectionView.reloadData()
        nameLbl.text = "Hello \(UserDefaults.standard.object(forKey: "lastNameTF.text") as! String)"
        let imgUser = UserDefaults.standard.object(forKey: "userImg") as? String
        userImg.image = imgUser?.toImage()
        allCount = 0
        
    }
    
    //MARK: initElements
    
    func initElements(){
      
        mainView.backgroundColor = #colorLiteral(red: 0.2777633071, green: 0.495888412, blue: 0.8678069711, alpha: 1)
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(150)
        }
        
        nameLbl.text = "Hello"
        nameLbl.font = .systemFont(ofSize: 30, weight: .bold)
        nameLbl.textColor = .white
        nameLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(53)
            make.left.equalToSuperview().offset(28)
        }
        
        warningLbl.font = .systemFont(ofSize: 20, weight: .medium)
        warningLbl.textColor = .white
        warningLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(28)
        }
        
        userImg.layer.cornerRadius = 35
        userImg.clipsToBounds = true
        userImg.backgroundColor = .red
        userImg.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalTo(70)
            make.right.equalToSuperview().offset(-18)
            make.top.equalToSuperview().offset(53)
        }

        projectsLbl.text = "Projects"
        projectsLbl.font = .systemFont(ofSize: 20, weight: .regular)
        projectsLbl.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(18)
        }
        
                collectionView.snp.makeConstraints { make in
                    make.top.equalTo(projectsLbl.snp.bottom).offset(16)
                    make.left.equalToSuperview().offset(16)
                    make.right.equalToSuperview().offset(-16)
                    make.bottom.equalToSuperview().offset(-50)
            }
    }
    
    //MARK: addSubView
   
    func addSubView(){
        view.addSubview(mainView)
        mainView.addSubview(nameLbl)
        mainView.addSubview(warningLbl)
        mainView.addSubview(userImg)
        view.addSubview(projectsLbl)
        view.addSubview(collectionView)
    }
     
}

//MARK: UICollectionViewDataSource

extension TaskVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? Cell else { return UICollectionViewCell() }
              
        /*
                            work with fetchedData
         */

        var fetchedData = try! context?.fetch(Core2.fetchRequest())
        var cnt = 0

        switch indexPath.item {
        case indexPath.item:
                        
            for i in fetchedData! {
                if i.typeTask == names[indexPath.item] {
                    cnt += 1
                }
            }
            cell.updateCell(name: names[indexPath.item], number: cnt)
            allCount += cnt
         
            if allCount == 0 {
                warningLbl.text = "You don`t have task"
            } else {
                warningLbl.text = "You have \(allCount) tasks"
            }
            
            
            
        default: print("error")
            
        }
        
        return cell
    }

}

//MARK: UICollectionViewDelegate

extension TaskVC : UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HomeVC()
        
        var fetchedData = try! context?.fetch(Core2.fetchRequest())

        sortedPersonal = [Core2]()
        sortedWork = [Core2]()
        sortedMeeting = [Core2]()
        sortedStudy = [Core2]()
        sortedShopping = [Core2]()
        sortedParty = [Core2]()
        
        for i in fetchedData!  {
            
            if i.typeTask == names[indexPath.row] {
                //
                if indexPath.item == 0  {
                    sortedPersonal.append(i)
                } else if indexPath.item == 1 {
                    sortedWork.append(i)
                } else if indexPath.item == 2 {
                    sortedMeeting.append(i)
                } else if indexPath.item == 3 {
                    sortedStudy.append(i)
                } else if indexPath.item == 4 {
                    sortedShopping.append(i)
                } else {
                    sortedParty.append(i)
                }
                //
            }
        }
        
        if indexPath.item == 0 {
            
            vc.sortedDay(data: sortedPersonal)
        } else if indexPath.item == 1 {
            vc.sortedDay(data: sortedWork)
        } else if indexPath.item == 2 {
            vc.sortedDay(data: sortedMeeting)
        } else if indexPath.item == 3 {
            vc.sortedDay(data: sortedStudy)
        } else if indexPath.item == 4 {
            vc.sortedDay(data: sortedShopping)
        } else {
            vc.sortedDay(data: sortedParty)
        }
        
        vc.mainView.heightAnchor.constraint(equalToConstant: 0).isActive = true

        present(vc, animated: true)
    }
    
    
}


