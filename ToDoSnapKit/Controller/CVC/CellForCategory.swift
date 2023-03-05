import UIKit

class CellForCategory: UICollectionViewCell {
   
    let categoryColorView = UIView()
    let name = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        initElements()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: initElements
    
    func initElements(){
       
        categoryColorView.layer.cornerRadius = 10
        categoryColorView.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        name.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5568627451, alpha: 1)
        name.font = .systemFont(ofSize: 20, weight: .semibold)
        name.snp.makeConstraints { make in
            make.left.equalTo(categoryColorView.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
    }
    
    //MARK: addSubViews
    
    func addSubViews(){
        contentView.addSubview(categoryColorView)
        contentView.addSubview(name)
    }
    
    //MARK: updataCell
    
    func updataCell(data: CategoryDM){
        contentView.backgroundColor = data.backgraundColor
        name.text = data.name
        
        switch data.name {
        case "Personal": categoryColorView.backgroundColor = .systemYellow
        case "Work": categoryColorView.backgroundColor = .green
        case "Meeting": categoryColorView.backgroundColor = .red
        case "Study":categoryColorView.backgroundColor = .blue
        case "Shopping":categoryColorView.backgroundColor = .orange
        default:categoryColorView.backgroundColor = .lightGray
            
        }
        
    }
        
}
