//
//  Coin.swift
//  FourthWeek
//
//  Created by BAE on 1/15/25.
//


/*
 서버에서 키를 바궈서 앱이 터진다! -> DecodingStrategy 디코딩을 어떻게 할 것인가
 
 - 필드를 옵셔널 처리
 - CodingKey: 서버 - 모델
 
 
 */

struct CoinDetail: Decodable {
    let market: String
    let korean: String
    let english: String
    
    // 디코딩 에러를 대비해 옵셔널로 선언, 이렇게하면 디코딩 에러를 일으켜도 일단 통신은 됨.
    // 해당 필드는 nil값 처리.
    // 서버에서 키를 바꿀 경우 앱이 터지기 때문에 이런식으로 대비
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case market
        case name
        case korean = "korean_name"
        case english = "english_name"
    }
}

