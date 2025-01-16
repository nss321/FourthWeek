//
//  BaseTableViewCell.swift
//  FourthWeek
//
//  Created by BAE on 1/16/25.
//

import UIKit
import SnapKit
import Then

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
            
    }
    
    func configureLayout() {
            
    }
    
    func configureView() {
            
    }
    
}
