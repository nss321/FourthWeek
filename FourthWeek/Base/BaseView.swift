//
//  BaseView.swift
//  FourthWeek
//
//  Created by BAE on 1/16/25.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureHierarchy() {
            
    }
    
    func configureLayout() {
            
    }
    
    func configureView() {
            
    }
}
