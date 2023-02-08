//
//  APODTypeModel.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/08.
//

import Foundation

struct APODType: Decodable {
    let title : String // 제목
    let explanation : String // 설명
    
    let url : String // 썸네일 이미지
    let hdurl : String // 고화질 이미지
    
    let date : String // 날짜
    let copyright : String //저작권
    
    let media_type : String // 미디어 타입
    let service_version : String // 버전
}

