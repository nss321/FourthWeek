//
//  BookView.swift
//  FourthWeek
//
//  Created by BAE on 1/16/25.
//

import UIKit
import SnapKit
import Then

class BookView: BaseView {
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    )
        
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(50, 50)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        backgroundColor = .white
        collectionView.do {
            $0.backgroundColor = .tertiarySystemBackground
            $0.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        }
    }
}
