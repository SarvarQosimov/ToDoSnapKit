import UIKit

class Cell: UICollectionViewCell {
    
    let img = UIImageView()
    let lblForType = UILabel()
    let lblNumberOfTasks = UILabel()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.backgroundColor = .white
        addSubViews()
        initElements()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
    }
    
    //MARK: updateCell
    
    func updateCell(name: String, number: Int){
        lblForType.text = name
        lblNumberOfTasks.text = "\(number)"
        img.image = UIImage(named: name)
        
    }
    
    //MARK: initElements
    
    func initElements(){
        contentView.layer.cornerRadius = 30
        contentView.clipsToBounds = true
        img.tintColor = .systemYellow
        img.snp.makeConstraints { make in
            make.height.width.equalTo(66)
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalToSuperview().offset(32)
        }
        
        lblForType.font = .systemFont(ofSize: 17, weight: .regular)
        lblForType.snp.makeConstraints { make in
            make.top.equalTo(img.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        lblNumberOfTasks.font = .systemFont(ofSize: 13, weight: .regular)
        lblNumberOfTasks.snp.makeConstraints { make in
            make.top.equalTo(lblForType.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
    }
    //MARK: addSubViews

    func addSubViews(){
        contentView.addSubview(img)
        contentView.addSubview(lblForType)
        contentView.addSubview(lblNumberOfTasks)
    }
}

