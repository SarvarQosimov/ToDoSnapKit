import UIKit
import SnapKit
import CoreData

class HomeVC: UIViewController {

    //MARK: Elements
    
    let mainView = UIView()
    let nameLbl = UILabel()
    let warningLbl = UILabel()
    let userImg = UIImageView()
    lazy var tableView : UITableView = {
       let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        tv.register(CellForTableView.self, forCellReuseIdentifier: "CellForTableView")
        
        return tv
    }()
    let backBtn = UIButton(type: .system)
    
    //MARK: Varialbes

    var contex = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var tasksForToday: [Core2] = []
    var tasksForTomorrow: [Core2] = []
    var tasksForAfterTomorrow: [Core2] = []
    
    var isSorted = false
   
    var sortedToday = [Core2]()
    var sortedTomorrow = [Core2]()
    var sortedAfterTomorrow = [Core2]()
    
    var allTasksCount = 0
    
    //MARK: viewDidLoad,viewWillAppear

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        addSubView()
        initElements()
        fetchData()
        
      
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameLbl.text = "Hello \(UserDefaults.standard.object(forKey: "lastNameTF.text") as! String)"
        let imgUser = UserDefaults.standard.object(forKey: "userImg") as? String
        userImg.image = imgUser?.toImage()
       
        fetchData()
        tableView.reloadData()
       
        allTasksCount = tasksForToday.count + tasksForTomorrow.count + tasksForAfterTomorrow.count
     
        if allTasksCount == 0 {
            warningLbl.text = "You don`t have task"
        } else {
            warningLbl.text = "You have \(allTasksCount) tasks"
        }
        
    }
    
    @objc func donePressed(_ sender: Any){
        doUnSorted()
        dismiss(animated: true)
    }
        
    //MARK: Functions

    func doUnSorted(){
        isSorted = false
    }
    
    func updateData(item: Core2, bool: Bool){
        item.isDode = bool
        
        do {
            try contex?.save()
        } catch {
            print("error")
        }
        tableView.reloadData()
    }
    
    func sendToConvertData(data: [Core2], index: Int){
       
        let vc = PlusVC()
        
            vc.isChanging = true
            vc.changeTask = data[index].text!
            vc.shouldChane = data[index]
            vc.selectedType = data[index].typeTask!
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        
    }
    
    func sortedDay(data: [Core2]){
      
        isSorted = true
        
        for i in data {
            if i.chosenDay == "Today" {
                sortedToday.append(i)
            } else if i.chosenDay == "Tomorrow" {
                sortedTomorrow.append(i)
            } else {
                sortedAfterTomorrow.append(i)
            }
        }

        tableView.reloadData()
    }
    
    func alert1(){
        
        let alert = UIAlertController(title: "You finished task", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func alert2(){
        
        let alert = UIAlertController(title: "You did not do yet", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    //MARK: Core Data

    func fetchData(){
        
        do {
            let fetchedData =  try contex?.fetch(Core2.fetchRequest())
            tasksForToday = [Core2]()
            tasksForTomorrow = [Core2]()
            tasksForAfterTomorrow = [Core2]()
            for i in fetchedData! {
                if i.chosenDay == "Today" {
                    tasksForToday.append(i)
                } else if i.chosenDay == "Tomorrow" {
                    tasksForTomorrow.append(i)
                } else {
                    tasksForAfterTomorrow.append(i)
                }
            }
            
            tableView.reloadData()
            
        } catch {
            print("error")
        }
        
    }
    
    func deleteData(item: Core2){
        
        contex?.delete(item)
        
        do {
            try contex?.save()
        } catch {
            print("error")
        }
    }
    
    //MARK: initElements

    func initElements(){
       
        mainView.backgroundColor = #colorLiteral(red: 0.2433136702, green: 0.8537869453, blue: 0.642993927, alpha: 1)
        mainView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        nameLbl.font = .systemFont(ofSize: 30, weight: .bold)
        nameLbl.textColor = .white
        nameLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(53)
            make.left.equalToSuperview().offset(28)
        }
        
        warningLbl.text = "Today you have no tasks"
        warningLbl.font = .systemFont(ofSize: 20, weight: .medium)
        warningLbl.textColor = .white
        warningLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(28)
        }
        
        userImg.backgroundColor = .red
        userImg.layer.cornerRadius = 35
        userImg.clipsToBounds = true
        userImg.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalTo(70)
            make.right.equalToSuperview().offset(-18)
            make.top.equalToSuperview().offset(53)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(mainView.snp.bottom)
        }
        
        backBtn.setTitle("Done", for: .normal)
        backBtn.tintColor = #colorLiteral(red: 0.2433136702, green: 0.8537869453, blue: 0.642993927, alpha: 1)
        
        backBtn.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(50)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
        }
        backBtn.addTarget(self, action: #selector(donePressed(_:)), for: .touchUpInside)
    }
    
    //MARK: addSubView

    func addSubView(){
        view.addSubview(mainView)
        mainView.addSubview(nameLbl)
        mainView.addSubview(warningLbl)
        mainView.addSubview(userImg)
        
        view.addSubview(tableView)
        view.addSubview(backBtn)
    }
    
    }

//MARK: UITableViewDataSource

extension HomeVC : UITableViewDataSource {
    
    //MARK: - numberOfSections and numberOfRowsInSection -
    
    func numberOfSections(in tableView: UITableView) -> Int {
      
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if isSorted {
            //
            if section == 0 {
                return sortedToday.count
            } else if section == 1 {
                return sortedTomorrow.count
            } else {
                return sortedAfterTomorrow.count
            }
            //
        } else {
            //
            if section == 0 {
                return tasksForToday.count
            } else if section == 1 {
                return tasksForTomorrow.count
            } else {
                return tasksForAfterTomorrow.count
            }
            //
        }
    }
    
    //MARK: - cellForRowAt -
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"CellForTableView", for: indexPath) as? CellForTableView else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.delegateFinished = self
        cell.taskLbl.numberOfLines = 0
        if isSorted {
           // sorted
            if indexPath.section == 0 {
                
                if sortedToday[indexPath.row].isDode {
                    cell.isDone = true
                } else {
                    cell.isDone = false
                }
                
                cell.updateCell(data: sortedToday[indexPath.row],index: indexPath.row,section: indexPath.section,sort: true)

            } else if indexPath.section == 1 {
                
                if sortedTomorrow[indexPath.row].isDode {
                    cell.isDone = true
                } else {
                    cell.isDone = false
                }
                
                cell.updateCell(data: sortedTomorrow[indexPath.row],index: indexPath.row,section: indexPath.section,sort: true)

            } else {
                
                if sortedAfterTomorrow[indexPath.row].isDode {
                    cell.isDone = true
                } else {
                    cell.isDone = false
                }
                //
                
                cell.updateCell(data: sortedAfterTomorrow[indexPath.row],index: indexPath.row,section: indexPath.section,sort: true)
            }
            
        } else {
            // not sorted
            if indexPath.section == 0 {
                
                if tasksForToday[indexPath.row].isDode {
                    cell.isDone = true
                } else {
                    cell.isDone = false
                }
                
                cell.updateCell(data: tasksForToday[indexPath.row],index: indexPath.row,section: indexPath.section,sort: false)

            } else if indexPath.section == 1 {
                
                if tasksForTomorrow[indexPath.row].isDode {
                    cell.isDone = true
                } else {
                    cell.isDone = false
                }
                
                cell.updateCell(data: tasksForTomorrow[indexPath.row],index: indexPath.row,section: indexPath.section,sort: false)

            } else {
                
                if tasksForAfterTomorrow[indexPath.row].isDode {
                    cell.isDone = true
                } else {
                    cell.isDone = false
                }
                
                cell.updateCell(data: tasksForAfterTomorrow[indexPath.row],index: indexPath.row,section: indexPath.section,sort: false)
            }
        }
        
        return cell
        
    }
    
    //MARK: - titleForHeaderInSection -
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0  {
            return "Today"
        } else if section == 1 {
            return "Tomorrow"
        } else {
            return "After Tomorrow"
        }
    }
    
    //MARK: - heightForHeaderInSection -
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        if tasksForToday.isEmpty && section == 0 {
            return 0
        }

        if tasksForTomorrow.isEmpty && section == 1 {
            return 0
        }

        if tasksForAfterTomorrow.isEmpty && section == 2 {
            return 0
        }

        return 15
    }
    
}
    
//MARK: UITableViewDelegate

    extension HomeVC : UITableViewDelegate {
        
//MARK: - trailingSwipeActionsConfigurationForRowAt -
        
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

            let action = UIContextualAction(style: .destructive, title: "Delete") { [self] _, _, _ in
    
                if isSorted {
        //
        if indexPath.section == 0 {
            deleteData(item: sortedToday[indexPath.row])
            sortedToday.remove(at: indexPath.row)
            } else if indexPath.section == 1 {
                deleteData(item: sortedTomorrow[indexPath.row])
                sortedTomorrow.remove(at: indexPath.row)
            } else {
                deleteData(item: sortedAfterTomorrow[indexPath.row])
                sortedAfterTomorrow.remove(at: indexPath.row)
            }
        //
              } else {
                    //
                    if indexPath.section == 0 {
                        deleteData(item: tasksForToday[indexPath.row])
                        tasksForToday.remove(at: indexPath.row)
                    } else if indexPath.section == 1 {
                        deleteData(item: tasksForTomorrow[indexPath.row])
                        tasksForTomorrow.remove(at: indexPath.row)
                    } else {
                        deleteData(item: tasksForAfterTomorrow[indexPath.row])
                        tasksForAfterTomorrow.remove(at: indexPath.row)
                    }
                    //
                }
                tableView.reloadData()
                allTasksCount = tasksForToday.count + tasksForTomorrow.count + tasksForAfterTomorrow.count
               
                if allTasksCount == 0 {
                    warningLbl.text = "You don`t have task"
                } else {
                    warningLbl.text = "You have \(allTasksCount) tasks"
                }
                
               let vc = TaskVC()
                
                
            }
           
            let swipe = UISwipeActionsConfiguration(actions: [action])
            
            return swipe
        }
        
        //MARK: - UIContextMenuConfiguration -

        func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {

            let edit = UIAction(title:"Edit",attributes: .destructive) { [self] _ in
                //
                if indexPath.section == 0 {
                    sendToConvertData(data: tasksForToday, index: indexPath.row)
                } else if indexPath.section == 1 {
                    sendToConvertData(data: tasksForTomorrow, index: indexPath.row)
                } else {
                    sendToConvertData(data: tasksForAfterTomorrow, index: indexPath.row)
                }
                //
              
            }
            if !isSorted {
                return UIContextMenuConfiguration(identifier: nil,previewProvider: nil) { _ in
                    UIMenu(title:"Edit",children: [edit])
                }
            } else {
                return UIContextMenuConfiguration()
            }
           

            
        }
        
    }

//MARK: finishedDelegate

extension HomeVC: finishedDelegate {
  
    // turnOn function
    
    func turnOn(section: Int, index: Int, sort: Bool) {
        
        alert1()

        if !sort {
             //
              if section == 0 {
                  updateData(item: tasksForToday[index], bool: true)
              } else if section == 1 {
                  updateData(item: tasksForTomorrow[index], bool: true)
              } else {
                  updateData(item: tasksForAfterTomorrow[index], bool: true)
              }
              //
        } else {
            //
              if section == 0 {
                  updateData(item: sortedToday[index], bool: true)
              } else if section == 1 {
                  updateData(item: sortedTomorrow[index], bool: true)
              } else {
                  updateData(item: sortedAfterTomorrow[index], bool: true)
              }
              //
        }
    }
    
    // turnOff function

    func turnOff(section: Int, index: Int, sort: Bool) {
       
        alert2()

        if !sort {
            //
              if section == 0 {
                  updateData(item: tasksForToday[index], bool: false)
              } else if section == 1 {
                  updateData(item: tasksForTomorrow[index], bool: false)
              } else {
                  updateData(item: tasksForAfterTomorrow[index], bool: false)
              }
              //
        } else {
            //
              if section == 0 {
                  updateData(item: sortedToday[index], bool: false)
              } else if section == 1 {
                  updateData(item: sortedTomorrow[index], bool: false)
              } else {
                  updateData(item: sortedAfterTomorrow[index], bool: false)
              }
              //
        }
    }
    
}
