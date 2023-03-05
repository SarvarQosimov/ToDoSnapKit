import UIKit
import CoreData
import SnapKit

class PlusVC: UIViewController {
    
    //MARK: Elements
    
    let writeTaskTF = UITextField()
    private (set) lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 130, height: 30)
        let cv = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.register(CellForCategory.self, forCellWithReuseIdentifier: "CellForCategory")
        return cv
    }()
    let addTask = UIButton(type: .system)
    let cancelBtn = UIButton(type: .system)
    let pickDate = UIPickerView()
   
    //MARK: Variables

    var backColor : UIColor = .white
    var contex = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var selectedDay = "Today"
    var selectedTime = "00:00"
    var selectedType = "Other"
    
    var changeTask = ""
    var isChanging = false
    var shouldChane: Core2!
    let categories = [
        CategoryDM(name: "Personal",task: "empty", backgraundColor: .white),
        CategoryDM(name: "Work",task: "empty", backgraundColor: .white),
        CategoryDM(name: "Meeting",task: "empty", backgraundColor: .white),
        CategoryDM(name: "Study",task: "empty", backgraundColor: .white),
        CategoryDM(name: "Shopping",task: "empty", backgraundColor: .white),
        CategoryDM(name: "Party",task: "empty", backgraundColor: .white)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        initElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isChanging {
            
            writeTaskTF.text = shouldChane.text
            
            switch shouldChane.typeTask {
            case "personal": categories[0].backgraundColor = .systemYellow
            case "work": categories[1].backgraundColor = .green
            case "meeting": categories[2].backgraundColor = .red
            case "study":categories[3].backgraundColor = .blue
            case "shopping":categories[4].backgraundColor = .orange
            default:categories[5].backgraundColor = .lightGray
                
                collectionView.reloadData()
            }
        }
    }

    //MARK: initElements
       
    func initElements(){
        
        writeTaskTF.placeholder = "Write your task"
        writeTaskTF.textAlignment = .center
        writeTaskTF.borderStyle = .bezel
        writeTaskTF.clipsToBounds = true
        writeTaskTF.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(writeTaskTF.snp.bottom).offset(50)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        addTask.backgroundColor = #colorLiteral(red: 0.4053157568, green: 0.5812619328, blue: 0.9316132665, alpha: 1)
        addTask.tintColor = .white
        addTask.setTitle("Add task", for: .normal)
        addTask.layer.cornerRadius = 8
        addTask.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-70)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(228)
        }
        addTask.addTarget(self, action: #selector(addTaskPressed), for: .touchUpInside)
        
        cancelBtn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        cancelBtn.tintColor = .blue
        cancelBtn.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(50)
        }
        cancelBtn.addTarget(self, action: #selector(canceled(_:)), for: .touchUpInside)
        
        pickDate.dataSource = self
        pickDate.delegate = self
        pickDate.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(collectionView.snp.bottom).offset(30)
            make.bottom.equalTo(addTask.snp.top).offset(-30)
        }
                
    }
    
    //MARK: addSubViews
    func addSubViews(){
        view.addSubview(writeTaskTF)
        view.addSubview(collectionView)
        view.addSubview(addTask)
        view.addSubview(cancelBtn)
        view.addSubview(pickDate)
    }
    
    
    //MARK: Core Data
    
    func saveData(){
       
        let newData = Core2(context: contex!)
        newData.typeTask = selectedType
        newData.isDode = false
        newData.chosenTime = selectedTime
        newData.chosenDay = selectedDay
        newData.text = writeTaskTF.text!
        
        do {
           try contex?.save()
        } catch {
            print("error")
        }
        
    }
        
    func changeData(){
        
        shouldChane.typeTask = selectedType
        shouldChane.chosenTime = selectedTime
        shouldChane.chosenDay = selectedDay
        shouldChane.text = writeTaskTF.text!
        
        do {
           try contex?.save()
        } catch {
            print("error")
        }
        
    }
    
    //MARK: @objcFunc
    
    @objc func addTaskPressed(_ sender: Any){

        if isChanging {
            changeData()
        } else {
            saveData()
        }
        
        dismiss(animated: true)
    }
    
    @objc func canceled(_ sender: Any){
       dismiss(animated: true)
    }
    
    
    
}
//MARK: UICollectionViewDataSource

extension PlusVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellForCategory", for: indexPath) as? CellForCategory else { return UICollectionViewCell() }
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        

        cell.updataCell(data: categories[indexPath.item])
        return cell
    }
}

//MARK: UICollectionViewDelegate

extension PlusVC : UICollectionViewDelegate {
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        for i in categories {
            i.backgraundColor = .white
        }
        
        switch categories[indexPath.item].name {
        case "Personal": selectedType = "personal"
        categories[indexPath.item].backgraundColor = .systemYellow
        case "Work": selectedType = "work"
            categories[indexPath.item].backgraundColor = .green
        case "Meeting": selectedType = "meeting"
            categories[indexPath.item].backgraundColor = .red
        case "Study": selectedType = "study"
            categories[indexPath.item].backgraundColor = .blue
        case "Shopping": selectedType = "shopping"
            categories[indexPath.item].backgraundColor = .orange
        default: selectedType = "party"
            categories[indexPath.item].backgraundColor = .darkGray
        }
        collectionView.reloadData()
                
    }
}

//MARK: UIPickerView

extension PlusVC: UIPickerViewDelegate {
    
}

extension PlusVC: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 3
        } else {
            return 24
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            
            switch row {
            case 0: return "Today"
            case 1: return "Tomorrow"
            default: return "After tomorrow"
                
            }
        } else {
            
            if row <= 9 {
                switch row {
                case row: return "0\(row):00"
                default: return "not match"
                }
            } else {
                switch row {
                case row: return "\(row):00"
                default: return "not match"
                }
            }
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            switch row {
            case 0: selectedDay = "Today"
            case 1: selectedDay = "Tomorrow"
            default: selectedDay = "After tomorrow"
            }
        } else {
            if row <= 9 {
                switch row {
                case row: selectedTime =  "0\(row):00"
                default: selectedTime =  "not match"
                }
            } else {
                switch row {
                case row: selectedTime =  "\(row):00"
                default: selectedTime =  "not match"
                }
            }
        }
    }
    
}

