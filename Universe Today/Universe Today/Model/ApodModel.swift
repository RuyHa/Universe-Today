//
//  ApodModel.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/08.
//

import Foundation

struct ApodModel: Decodable {
    let title : String // 제목
    let explanation : String // 설명
    
    let url : String // 썸네일 이미지
    let hdurl : String // 고화질 이미지
    
    let date : String // 날짜
    let copyright : String? //저작권
    
    let media_type : String // 미디어 타입
    let service_version : String // 버전
}

/*
 무조건 모든 값이 다 들어 있는 줄 알았는데 방금 보니 데이터를 믿으면 안될 것 같다.
 방금의 경우 copyright가 빠진 값이 와서 문제가 발생했었다...
 */

