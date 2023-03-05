import UIKit

class CellForTableView: UITableViewCell {
//MARK: Variables
    let typeView = UIView()
    let finishedBtn = UIButton(type: .system)
    let time = UILabel()
    let taskLbl = UILabel()
    var delegateFinished: finishedDelegate?
    var delegateRemind: RemindDelegate?
    var isDone = false
    var sectionCell = 0
    var indexCell = 0
    var done = false
    var isSorted = false

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "CellForTableView")
       
        addSubViews()
        initElements()

    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: updateCell
    func updateCell(data: Core2,index: Int, section: Int, sort: Bool){
        
        switch data.typeTask {
        case "personal": typeView.backgroundColor = UIColor(hex: "#FFD506")
        case "work": typeView.backgroundColor = UIColor(hex: "#5DE61A")
        case "meeting": typeView.backgroundColor = UIColor(hex: "#D10263")
        case "study": typeView.backgroundColor = UIColor(hex: "#3044F2")
        case "shopping": typeView.backgroundColor = UIColor(hex: "#F29130")
        case "party": typeView.backgroundColor =  UIColor(hex: "#5C96E5")
        default: typeView.backgroundColor = .white
        }
        
        time.text = data.chosenTime
        taskLbl.text = data.text
        indexCell = index
        sectionCell = section
        isSorted = sort
        //done
        if isDone {
            finishedBtn.backgroundColor = .green
            taskLbl.textColor = .lightGray
            finishedBtn.setImage(nil, for: .normal)
        } else {
            finishedBtn.backgroundColor = .white
            taskLbl.textColor = #colorLiteral(red: 0.3333333333, green: 0.3058823529, blue: 0.5607843137, alpha: 1)
            finishedBtn.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        
    }
    //MARK: initElements
    
    func initElements(){

        contentView.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        typeView.backgroundColor = #colorLiteral(red: 1, green: 0.8273848891, blue: 0, alpha: 1)
       
        typeView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(8)
        }
        
        typeView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        typeView.layer.cornerRadius = 10
        typeView.clipsToBounds = true
        
        finishedBtn.setImage(UIImage(systemName: "circle"), for: .normal)
        finishedBtn.layer.cornerRadius = 10
        finishedBtn.clipsToBounds = true
        finishedBtn.tintColor = .lightGray
        finishedBtn.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        finishedBtn.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.left.equalTo(typeView.snp.right).offset(14)
            make.centerY.equalToSuperview()
        }
        finishedBtn.addTarget(self, action: #selector(finishedBtnPressed(_:)), for: .touchUpInside)
        
        time.textColor = #colorLiteral(red: 0.7608423829, green: 0.7608423829, blue: 0.7608423829, alpha: 1)
        time.font = .systemFont(ofSize: 11, weight: .light )
        time.snp.makeConstraints { make in
            make.left.equalTo(finishedBtn.snp.right).offset(14)
            make.centerY.equalToSuperview()
        }
        
        taskLbl.textColor = #colorLiteral(red: 0.3333333333, green: 0.3058823529, blue: 0.5607843137, alpha: 1)
        taskLbl.text = "Go jogging with Christin"
        taskLbl.numberOfLines = 0
        taskLbl.font = .systemFont(ofSize: 14, weight: .semibold)
        taskLbl.snp.makeConstraints { make in
            make.left.equalTo(time.snp.right).offset(19)
            make.right.equalToSuperview().offset(10)
            make.centerY.equalTo(contentView.snp.centerY)
        }
                
        
        
    }
    
    //MARK: addSubViews
    
    func addSubViews(){
        contentView.addSubview(typeView)
        contentView.addSubview(finishedBtn)
        contentView.addSubview(time)
        contentView.addSubview(taskLbl)
    }
    
    //MARK: objcFunc
    
    @objc func finishedBtnPressed(_ sender: Any){
      
        if !done {
            delegateFinished?.turnOn(section: sectionCell, index: indexCell,sort: isSorted)
            done = true
        } else {
            delegateFinished?.turnOff(section: sectionCell, index: indexCell,sort: isSorted)
            done = false
        }
        
    }

}
