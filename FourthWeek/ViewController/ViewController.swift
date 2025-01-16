//
//  ViewController.swift
//  FourthWeek
//
//  Created by BAE on 1/13/25.
//

import UIKit
import SnapKit
import Then

/*
 1. 스토리보드 객체 얹기
 2. 객체 레이아웃 잡기
 3. 아웃렛 연결하기
 4. 객체 속성 코드로 조절하기
 */

class ViewController: UIViewController, ViewPresenstableProtocol {

    // 1. 뷰 객체 프로퍼티 선언
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let nameTextField = UITextField()
    
    let cyanView = UIView().then {
        $0.backgroundColor = .systemCyan
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
    }
    
    let yellowView = UIView().then { $0.backgroundColor = .systemYellow }
    let grayView = UIView().then { $0.backgroundColor = .gray }
    
    lazy var button = UIButton().then {
        $0.setTitle("벝은", for: .normal)
        $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        $0.backgroundColor = .systemTeal
    }
    
    lazy var button2 = makeMyButton()
    
    lazy var button3 = {
        let btn = UIButton()
        btn.backgroundColor = .lightGray
        btn.setTitle("법튼", for: .normal)
        return btn
    }()
    
    // viewDidLoad()보다 먼저 실행
    let button4 = {
        let btn = UIButton()
        btn.backgroundColor = .lightGray
        btn.setTitle("법튼", for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        setConstraints()
//        setConstraintsUsingSnapKit()
        configButton()
    }

    func setConstraints() {
        // MARK: FrameBasedLayout
        // 2. addSubView로 뷰 추가
        view.addSubview(emailTextField)
        // 3. 뷰의 위치와 크기 설정
        emailTextField.frame = CGRect(x: 50, y: 100, width: 100, height: 44)
//        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        // 4. 뷰의 속성 조절
        emailTextField.backgroundColor = .darkGray
        
        
        
        // MARK: AutoLayout - NSConstraints, After iOS 6
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint(item: passwordTextField,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: view.safeAreaLayoutGuide,
                                     attribute: .top,
                                     multiplier: 1,
                                     constant: 200)
        let leading = NSLayoutConstraint(item: passwordTextField,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: view.safeAreaLayoutGuide,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: 100)
        
        let trailing = NSLayoutConstraint(item: passwordTextField,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: view.safeAreaLayoutGuide,
                                          attribute: .trailing,
                                          multiplier: 1,
                                          constant: -100)
        
        let height = NSLayoutConstraint(item: passwordTextField,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .height,
                                        multiplier: 1,
                                        constant: 44)
//        top.isActive = true
//        leading.isActive = true
//        trailing.isActive = true
//        height.isActive = true
        view.addConstraints([top, leading, trailing, height])
        passwordTextField.backgroundColor = .red
        
        
        // MARK: AutoLayout - NSConstraintsAnchor
        /* left/right - leading/trailing 차이점:
           left/right는 사용자 설정에 따라 바뀌지 않고 고정임.
           예를 들어, 아랍어 사용자의 경우 문자가 우->좌 순서기 때문에 의도한 바와 다르게 적용될 수 있음. (LTR, RTL)
           
           이와 다르게 leading, trailing은 모든 문자 체계에 동일하게 적용되므로, 애플은 leading, trailing 사용을 권장함.
           (자동으로 flip 해 줌!)
        */
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        nameTextField.backgroundColor = .blue
        
    }
    
    
    /// Snapkit Practice
    func setConstraintsUsingSnapKit() {
        [cyanView, grayView, /*yellowView*/].forEach { view.addSubview($0) }
        
        cyanView.addSubview(yellowView)
        
        // MARK: AutoLayout - SnapKit
//        cyanView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        
//        yellowView.snp.makeConstraints {
//            $0.size.equalTo(200)
//            $0.center.equalToSuperview()
//        }
//        
//        grayView.snp.makeConstraints {
//            $0.size.equalTo(100)
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(yellowView.snp.bottom).offset(50)
//        }
        
        cyanView.snp.makeConstraints {
            $0.size.equalTo(200)
            $0.center.equalToSuperview()
        }
        
        grayView.snp.makeConstraints {
            $0.edges.equalTo(cyanView).inset(75)
        }
        
        yellowView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(50)
        }
    
    }
    
    func configButton() {
        view.addSubview(button)
        
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(32)
            $0.height.equalTo(80)
        }
    }
    
    func makeMyButton() -> UIButton {
        let btn = UIButton()
        btn.backgroundColor = .lightGray
        btn.setTitle("법튼", for: .normal)
        return btn
    }
    
    @objc 
    func buttonTapped(_ sender: UIButton) {
        let vc = BookViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

}

