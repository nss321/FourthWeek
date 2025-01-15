//
//  KakaoBookSearchViewController.swift
//  SeSACFourthWeek
//
//  Created by Jack on 1/14/25.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class KakaoBookSearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    let list = Array(1...100)
    
//    var _bookList: [BookDetail] = []
//    
//    var bookList: [BookDetail] {
//        get {
//            _bookList
//        }
//        set {
//            _bookList = newValue
//        }
//    }

    var bookList: [BookDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureSearchBar()
        configureTableView()
        
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func configureSearchBar() {
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        searchBar.delegate = self
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
        
        tableView.keyboardDismissMode = .onDrag
        tableView.rowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(KakaoBookSearchTableViewCell.self, forCellReuseIdentifier: KakaoBookSearchTableViewCell.id)

    }
    
    
    // TODO: 검색 기능 구현 - 같은 키워드면 호출 x
    func callRequest() {
        // 09가 대체 왜,,, 들어감,,?
        let url = "https://dapi.kakao.com/v3/search/book?query="
        let headers: HTTPHeaders = [
            "Authorization" : APIKey.kakao,
        ]
        AF.request("\(url)코스모스",
                   method: .get,
                   headers: headers
        ).responseDecodable(of: Book.self, completionHandler: { response in
            
            switch response.result {
            case .success(let value):
//                self.bookList = value.documents
                print("Success")
                dump(value.documents)
                
                self.bookList = value.documents
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
//                print(url)
            }
        })
        
//        .responseString { value in
//            print(value)
//        }
    }
    


}

extension KakaoBookSearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        // 스위프트 쿼리를 통해 카카오 책 API 호출
        callRequest()
    }
    
}


extension KakaoBookSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KakaoBookSearchTableViewCell.id, for: indexPath) as? KakaoBookSearchTableViewCell else { return UITableViewCell() }
        
        let data = bookList[indexPath.row]
        
        cell.titleLabel.text = data.title
        cell.overviewLabel.text = data.contents
        cell.thumbnailImageView.backgroundColor = .brown
        cell.thumbnailImageView.kf.setImage(with: URL(string: data.thumbnail))
        
        return cell
    }
    
}

