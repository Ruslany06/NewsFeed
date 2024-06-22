//
//  ViewController.swift
//  News feed
//
//  Created by Ruslan Yelguldinov on 31.05.2024.
//
import Foundation
import UIKit
import SnapKit

class TVController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateNews), userInfo: nil, repeats: true)
        tableView.register(TVCell.self, forCellReuseIdentifier: "TVCell")
    }
    
    private var currentIndex = 0
    
//    private var newDataArray: [(String, UIImage)] = [("Zebra", UIImage.zebra), ("Parrot", UIImage.parrot), ("Horses", UIImage.horses), ("Hedgehog", UIImage.hedgehog), ("Fox", UIImage.fox), ("Duck", UIImage.duck), ("Cat", UIImage.cat)]
    
    private var addedDataArray: [(date: TimeInterval, title: String, image: UIImage)] = []
    
    private var oldDataArray: [(date: TimeInterval, title: String, image: UIImage)] = [
        (Date().timeIntervalSince1970, "Zebra", UIImage.zebra),
        (Date().timeIntervalSince1970, "Parrot", UIImage.parrot),
        (Date().timeIntervalSince1970, "Horses", UIImage.horses),
        (Date().timeIntervalSince1970, "Hedgehog", UIImage.hedgehog),
        (Date().timeIntervalSince1970, "Fox", UIImage.fox),
        (Date().timeIntervalSince1970, "Duck", UIImage.duck),
        (Date().timeIntervalSince1970, "Cat", UIImage.cat),
        (Date().timeIntervalSince1970, "LadyBug", UIImage.ladybug)
    ]
    
    private var myDetailArray: [String] = [
        "Detail info for Zebra Detail info for Zebra Detail info for Zebra Detail info for Zebra",
        "Detail info for Parrot Detail info for Parrot Detail info for Parrot Detail info for Parrot Detail info for Parrot Detail info for Parrot",
        "Detail info for Horses Detail info for Horses Detail info for Horses Detail info for Horses Detail info for Horses Detail info for Horses Detail info for Horses Detail info for Horses",
        "Detail info for Hedgehog Detail info for Hedgehog Detail info for Hedgehog Detail info for Hedgehog",
        "Detail info for Fox Detail info for Fox Detail info for Fox Detail info for Fox Detail info for Fox Detail info for Fox Detail info for Fox",
        "Detail info for Duck Detail info for Duck Detail info for Duck Detail info for Duck  Detail info for Duck Detail info for Duck Detail info for Duck ",
        "Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat Detail info for Cat "
    ]
    
    
// MARK: TVDelegate, TVDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedDataArray.count + oldDataArray.count
//        return oldDataArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TVCell()
        let item: (date: TimeInterval, title: String, image: UIImage)
        
        if indexPath.row < addedDataArray.count {
                // Показать новые данные, которые отсортированы от нового к старому
                item = addedDataArray[indexPath.row]
            } else {
                // Показать старые данные
                item = oldDataArray[indexPath.row - addedDataArray.count]
            }
        
        let date = Date(timeIntervalSince1970: item.date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yy       HH:mm:ss"
//            dateFormatter.dateStyle = .medium
//            dateFormatter.timeStyle = .short
            let dateString = dateFormatter.string(from: date)
        
        cell.setData(date: dateString, name: item.title, image: item.image)
        
//        let item = oldDataArray[indexPath.row]
//        cell.setData(name: item.title, image: item.image)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        
        detailVC.details = myDetailArray[indexPath.row]
        
        let item = oldDataArray[indexPath.row]
        detailVC.name = item.1
        detailVC.imageName = item.2
        
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    @objc func updateNews() {
        
        let currentItem = oldDataArray[currentIndex]
        
        // Генерируем новое заголовок и изображение
        let newTitle: String = "New \(currentItem.1) - \(currentIndex + 1)"
        let newImage: UIImage = currentItem.2
        let newDate = Date().timeIntervalSince1970
        
        let newItem = (date: newDate, title: newTitle, image: newImage)
            
        addedDataArray.append(newItem)

        addedDataArray.sort { $0.date > $1.date }
        
//        var combinedDataArray = addedDataArray + oldDataArray
//        combinedDataArray.sort { $0.date > $1.date }
        
        currentIndex += 1
        
        if currentIndex >= oldDataArray.count {
            currentIndex = 0
        }
        
        tableView.reloadData()
       }

}

// MARK: TVCell Class
class TVCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private let posterImageView = {
        let iv = UIImageView()
        
        iv.image = UIImage.fox
        iv.contentMode = .scaleToFill
        
        return iv
    }()
    
    private let nameLabel = {
        let lbl = UILabel()
        
        lbl.text = "Fox"
        
        return lbl
    }()
    
    private let dateLabel = {
        let lbl = UILabel()
        
        lbl.text = "Date of addition"
        
        return lbl
    }()
    
    private func constraint() {
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        
        posterImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
            make.height.equalTo(80)
            make.width.equalTo(100)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(posterImageView.snp.right).offset(6)
            make.top.equalToSuperview().inset(20)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.equalTo(posterImageView.snp.right).offset(6)
        }
    }
    
    //MARK: Functions
    func setData(date: String, name: String, image: UIImage) {
        dateLabel.text = date
        nameLabel.text = name
        posterImageView.image = image
    }
    
}
