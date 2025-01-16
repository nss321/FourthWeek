//
//  MarketTableViewCell.swift
//  SeSACFourthWeek
//
//  Created by Jack on 1/14/25.
//

import UIKit
import SnapKit

class MarketTableViewCell: BaseTableViewCell {
    
    static let id = "MarketTableViewCell"
    
    let nameLabel = BlackRadiusLabel(textColor: .white)
    
    override func configureHierarchy() {
        contentView.addSubview(nameLabel)
    }
    
    override func configureLayout() {
        nameLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureView() {
        //        nameLabel.textColor = .brown
        //        nameLabel.font = .boldSystemFont(ofSize: 12)
        //        nameLabel.numberOfLines = 0
    }
    
}
