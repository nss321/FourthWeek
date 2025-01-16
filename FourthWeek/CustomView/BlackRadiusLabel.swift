//
//  BlackRadiusLabel.swift
//  FourthWeek
//
//  Created by BAE on 1/15/25.
//

import UIKit

protocol SeSAC {
    init()
}

// 상속은 아니지만, 타입을 채택했기 때문에 해당 프로토콜의 조건을 요구함.
// 여기서는 init()
class Mentor: SeSAC {
    required init() {
        print("Mentor Class")
    }
}

class Jack: Mentor {
    required init() {
        super.init()
        print("Jackjack")
    }
}

class BaseLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PointLabel: BaseLabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
}

class PointButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class BlackRadiusLabel: BaseLabel {
    
//    let a = Mentor()
    
    init(textColor: UIColor) {
        super.init(frame: .zero)
        self.text = "커스텀커스텀"
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
//        self.layer.cornerRadius = 10
        self.backgroundColor = .black
        self.font = .boldSystemFont(ofSize: 16)
        self.textColor = textColor
        self.textAlignment = .center
    }
    
    /*
     코드 베이스로 UI를 구성할 때 호출되는 초기화 구문
     슈퍼슈퍼~ 슈퍼클래스 슈퍼클래스~
     슈퍼클래스로 구현된 init
     */
//    override init(frame: CGRect) {
//        super.init(frame: frame)
////        configLabel()
//    }
//    
    /*
     스토리보드로 구성할 때 호출되는 초기화 구문
     이녀석은 슈퍼슈퍼~ 클래스가 아닌 프로토콜에 구현된 Init
     이런걸 머라한다? Required Initializer라 한다~
     
     또, 실패 가능한 이니셜라이저, Failable Initializer라고도 함.
     Storyboard를 사용한 녀석은 얘도 호출됨.
     
     만약 얘도 실행하고 싶다면,
     
     required override init
     or
     overriee required init
     으로 써주면 된다~
     */
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    func configLabel() {
        self.text = "커스텀커스텀"
        self.clipsToBounds = true
//        self.layer.cornerRadius = self.frame.height / 2
//        self.layer.cornerRadius = 10
        self.backgroundColor = .black
        self.font = .boldSystemFont(ofSize: 16)
        self.textColor = .white
        self.textAlignment = .center
    }
}
