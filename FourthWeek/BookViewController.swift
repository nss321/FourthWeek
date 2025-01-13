//
//  BookViewController.swift
//  FourthWeek
//
//  Created by BAE on 1/13/25.
//

import UIKit

final class BookViewController: UIViewController {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .tertiarySystemBackground
        $0.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        $0.dataSource = self
        $0.delegate = self
    }
    
    let list = ["Hi", "Bye", "It's time to go to home!", "Hair cutcut", "Sir. Sean Jeonghoon Bae."]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configCollectionView()
    }
}


// MARK: CollectionView DataSource
extension BookViewController: UICollectionViewDataSource {
    func configCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let row = list[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
        cell.config(row: row)
        return cell
    }
}


// MARK: CollectionView DelegateFlowLayout
extension BookViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, list[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(#function, list[indexPath.row])
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    
}


// MARK: CollectionView Cell
fileprivate class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MyCollectionViewCell"
    
    private let label = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .systemYellow
        $0.backgroundColor = .black
        $0.textAlignment = .center
    }
    
    // viewDidLoad, awakeFromNib
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // ㄷㄷ 여태까지 이거 빼먹고 했는데 ㄷㄷ
        // 이럿개 하는개 아니엇단 마리야? ㄷㄷ
        // 허걱슨 혹시 이것 때무네 didSelect가 안댓던건가
        contentView.addSubview(label)
        
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // TODO: 이거 외 쓰는지 아라보기.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(row: String) {
        label.text = row
    }
}
