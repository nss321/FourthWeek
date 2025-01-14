//
//  RandomViewController.swift
//  FourthWeek
//
//  Created by BAE on 1/14/25.
//

import UIKit
import SnapKit
import Alamofire

struct Dog: Decodable {
    let message: String
    let status: String
}

struct Lotto: Decodable {
    let drwNoDate: String
    let firstWinamnt: Int
}

struct User: Decodable {
    let results: [UserDetail]
//    let info
}
        
struct UserDetail: Decodable {
    let gender: String
    let name: UserName
    let email: String
    
}

struct UserName: Decodable {
    let title: String
    let first: String
    let last: String
}

protocol ViewConfiguration: AnyObject {
    func configHierarchy() // addSubView
    func configLayout() // snapkit
    func configView() // property
}

class RandomViewController: UIViewController, ViewConfiguration {

    let dogImageView = UIImageView()
    let nameLabel = UILabel()
    @objc let randomButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configHierarchy()
        configLayout()
        configView()
      
    }
    
    func configHierarchy() {
        view.addSubview(dogImageView)
        view.addSubview(nameLabel)
        view.addSubview(randomButton)
    }
    
    func configLayout() {
        dogImageView.snp.makeConstraints {
            $0.size.equalTo(300)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        nameLabel.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(dogImageView.snp.bottom).offset(20)
        }
        
        randomButton.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
    }
    
    func configView() {
        dogImageView.backgroundColor = .brown
        nameLabel.backgroundColor = .systemGreen
        configButton()
    }
    
    func configButton() {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("랜덤으로돌리라이")
        attributedTitle.font = .boldSystemFont(ofSize: 24)
        attributedTitle.foregroundColor = UIColor.white
        config.background.backgroundColor = .brown
        config.attributedTitle = attributedTitle
        config.imagePadding = 10
        
        var symbolConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 18, weight: .heavy))
        config.image = UIImage(
            systemName: "arrow.trianglehead.counterclockwise",
            withConfiguration: symbolConfig
        )?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        let handler: UIButton.ConfigurationUpdateHandler = { button in
            switch self.randomButton.state {
            case [.selected, .highlighted]:
                self.randomButton.configuration?.title = "Highlighted Selected"
            case .selected:
                self.randomButton.configuration?.title = "Selected"
            case .highlighted:
                attributedTitle.foregroundColor = UIColor.gray
                self.randomButton.configuration?.attributedTitle = attributedTitle
                self.randomButton.configuration?.image = UIImage(
                    systemName: "arrow.trianglehead.counterclockwise",
                    withConfiguration: symbolConfig
                )?.withTintColor(.gray, renderingMode: .alwaysOriginal)
            case .disabled:
                self.randomButton.configuration?.title = "Disabled"
            default:
                attributedTitle.foregroundColor = UIColor.white
                self.randomButton.configuration?.attributedTitle = attributedTitle
                self.randomButton.configuration?.image = UIImage(
                    systemName: "arrow.trianglehead.counterclockwise",
                    withConfiguration: symbolConfig
                )?.withTintColor(.white, renderingMode: .alwaysOriginal)
                
            }
        }
        
        randomButton.configuration = config
        randomButton.configurationUpdateHandler = handler
        randomButton.addTarget(self, action: #selector(userButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func randomButtonTapped() {
        // 1
        print("point 1")

//        print(#function)
        // 버튼 누르면 request 요청
        let url = "https://dog.ceo/api/breeds/image/random"
        
        
        /*
         
         responseDecodable 응답이 잘못된것도 실패, 식판에 안담겨도 실패 아임미까!
         
         그럴땐?
        
         당장 responseString 찍어.
         
         에러 로그는 찍히는데 뭔지 몰겟슴 -> 일단 스트링으로 찍어보렴.
         
         */
        
        AF.request(url, method: .get).responseDecodable(of: Dog.self) { response in
            
            // 2
            print("point 2")

//            print(response.result)
            
            switch response.result {
            case .success(let value):
//                self.nameLabel.text = value.message
                print(value.message)
                print(value.status)
                
            case .failure(let error):
                print(error)
            }
            
            print("point 3")
        }
        
        print("point 4")
    }
    

    @objc
    func lottoButtonTapped() {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(Int.random(in: 800...1154))"
        
        AF.request(url, method: .get).responseString { value in
            print(value)
        }
        
        AF.request(url, method: .get).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                self.nameLabel.text = value.drwNoDate + value.firstWinamnt.formatted()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    @objc
    func userButtonTapped() {
        let url = "https://randomuser.me/api/?results=50"
        
//        AF.request(url, method: .get).responseString { value in
//            print(value)
//        }
        
        AF.request(url, method: .get).responseDecodable(of: User.self) { response in
            switch response.result {
            case .success(let value):
                self.nameLabel.text = value.results[0].name.first
            case .failure(let error):
                print(error)
            }
        }
        
    }
    

}
