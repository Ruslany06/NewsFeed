//
//  DetailViewController.swift
//  News feed
//
//  Created by Ruslan Yelguldinov on 07.06.2024.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        constraints()
        setData()
    }
    
    var imageName: UIImage?
    var name: String = ""
    var details: String = ""
    
    lazy private var posterImageView = {
        let iv = UIImageView()
        
        iv.image = imageName
        iv.contentMode = .scaleToFill
        
        return iv
    }()
    
    private let nameLabel = {
        let lbl = UILabel()
        
        lbl.text = ""
        
        return lbl
    }()
    
    private let detailsLabel = {
        let lbl = UILabel()
        
        lbl.text = "Detail info for Fox"
        lbl.numberOfLines = 12
        
        return lbl
    }()
    
    func constraints() {
        view.addSubview(posterImageView)
        view.addSubview(nameLabel)
        view.addSubview(detailsLabel)
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(120)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(10)
            make.centerX.equalTo(posterImageView)
        }
        detailsLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(24)
            make.top.equalTo(nameLabel.snp.bottom).offset(14)
            
        }
    }
    
    func setData() {
        posterImageView.image = imageName
        nameLabel.text = name
        detailsLabel.text = details
    }

}
