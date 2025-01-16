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


/*
 페이지네이션
 1. 스크롤이 끝날 쯤 다음 페이지를 요청(page += 1후 callRequest)
 2. 이전 내용도 확인해야 해서 bookList.append로 수정

 - 고쳐야 할 부분?
 1. 다른거 검색 시 테이블 뷰 초기화(리스트도)
 2. 취소 버튼 클릭시 테이블 뷰 초기화
 3. 다른 검색어 입력 시 -> 배열 초기화, 페이지 1로 초기화, 최상단으로 스크롤
 4. 마지막 페이지인 경우 더이상 호출 X
 
 현재 상태에서는 빈칸 검색 시 앱 터짐( indexPath를 못 찾아서 ) -> api 호출 후 page가 1임을 확인함과 동시에 응답 배열이 빈 배열이 아닌지 확인해서 해결
 
 
 */
class KakaoBookSearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    let list = Array(1...100)
    
    var page = 1
    var isEnd = false
    
    var _bookList: [BookDetail] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var bookList: [BookDetail] {
        get {
            _bookList
        }
        set {
            _bookList = newValue
        }
    }

//    var bookList: [BookDetail] = []
    
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
        tableView.prefetchDataSource = self
        tableView.register(KakaoBookSearchTableViewCell.self, forCellReuseIdentifier: KakaoBookSearchTableViewCell.id)

    }
    
    
    // MARK: 검색 API 호출
    func callRequest(keyword: String) {
        // 09가 대체 왜,,, 들어감,,?
        let url = "https://dapi.kakao.com/v3/search/book?query="
        let headers: HTTPHeaders = [
            "Authorization" : APIKey.kakao,
        ]
        
        print(#function, url)
        AF.request("\(url)\(keyword)&size=20&page=\(String(page))",
                   method: .get,
                   headers: headers
        )
        .validate(statusCode: 200..<300) // 알라모파이어는 기본적으로 200번대만을 success로 지정함.
        .responseDecodable(of: Book.self, completionHandler: { response in
            
            print(response.response?.statusCode)
            
            // 에러가 나는데 진짜 원인을 잘 모르겠으면 responseString으로 로그를 찍어보아라.
            switch response.result {
            case .success(let value):
//                self.bookList = value.documents
                print("Success")
//                dump(value.documents)
                self.isEnd = value.meta.isEnd
                
                if self.page == 1 && !value.documents.isEmpty {
                    self.bookList = value.documents
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                } else {
                    self.bookList.append(contentsOf: value.documents)
                }
                
            case .failure(let error):
                print(error)
            }
        })
        
    }

}

// MARK: UISearchBar Delegate
extension KakaoBookSearchViewController: UISearchBarDelegate {

    /*
     검색 버튼 클릭시 무조건 통신하는게 아니라,
     빈캄 , 최소 1자 이상, 동일한 검색어에 대한 처리 필요
     */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        page = 1
        
        // 스위프트 쿼리를 통해 카카오 책 API 호출
        callRequest(keyword: searchBar.searchTextField.text!)
        tableView.scrollsToTop = true
    }
    
    
    // MARK: 왜 안됨?
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        page = 1
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.isEmpty {
            page = 1
            bookList.removeAll()
        }
    }
}


extension KakaoBookSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print(#function)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KakaoBookSearchTableViewCell.id, for: indexPath) as? KakaoBookSearchTableViewCell else { return UITableViewCell() }
        
        let data = bookList[indexPath.row]
        
        cell.titleLabel.text = data.title
        cell.overviewLabel.text = data.contents
        cell.thumbnailImageView.backgroundColor = .brown
        cell.thumbnailImageView.kf.setImage(with: URL(string: data.thumbnail))
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        print(#function)
//    }
    
    // UIScrollViewDelegate의 메서드임.
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(#function, scrollView.contentSize.height, scrollView.contentOffset.y)
//        if scrollView.bounces {
//            print("bounces!")
//        }
//    }
    
    
}

extension KakaoBookSearchViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
    }
    
    // size 20개, indexPath 0, 19
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
        
        for item in indexPaths {
            // 인덱스는 0부터 시작이다 애송이.
            // 사용자의 마지막 스크롤 시점 보다 조금 빠르게 처리. 기본적으로는 1을 뻄
            if bookList.count - 2 == item.row && !isEnd{
                page += 1
                callRequest(keyword: searchBar.text!)
            }
        }
    }
}
