//
//  MarketViewController.swift
//  SeSACFourthWeek
//
//  Created by Jack on 1/14/25.
//

import UIKit
import SnapKit
import Alamofire



class MarketViewController: UIViewController {
 
    let tableView = UITableView()
    
    let list = Array(1...100)
    
    var coinList: [CoinDetail] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureTableView()
        cellRequest()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.backgroundColor = .white
        tableView.rowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: MarketTableViewCell.id)
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func cellRequest() {
        let url = "https://api.upbit.com/v1/market/all"
        AF.request(url,
                   method: .get
        )
        .responseDecodable(of: [CoinDetail].self, completionHandler: { response in
            print(response.response?.statusCode)
            switch response.result {
            case .success(let value):
//                print("success", value)
                dump(value)
                self.coinList = value
            case .failure(let error):
                print(error)
            }
        })
    }

}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function, coinList.count)
        return coinList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.id, for: indexPath) as? MarketTableViewCell else { return UITableViewCell() }
        
        let data = coinList[indexPath.row]
        
        cell.nameLabel.text = """
                                market: \(data.market)
                                korean_name: \(data.korean)
                                englis_name: \(data.english)
                                """
        cell.layer.cornerRadius = cell.frame.height / 2
        return cell
    }
    
}
