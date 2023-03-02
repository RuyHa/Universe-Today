//
//  ApodService.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/16.
//

import Foundation

import RxSwift
import RxRelay
import Alamofire

class ApodService {
    
    static let shared = ApodService()
    
    var currentApodModel = BehaviorRelay<ApodModel>(value: ApodModel(title: "", explanation: "", url: "", hdurl: "", date: "", copyright: "", media_type: "", service_version: ""))
    
    var isLoadImage = PublishRelay<Bool>()
    
    func checkLoadImage() {
        self.isLoadImage.accept(true)
    }
    
    //MARK: RX를 사용했을때
    func setApod() {
        let myURL = "https://api.nasa.gov/planetary/apod?api_key=fBAxAPBbZF0M2JffWJb5751s5Y5bln4ec2nQ0sq1"
        AF.request(myURL).responseDecodable(of: ApodModel.self){ (response) in
            switch response.result {
            case .failure(let err) :
                NSLog("setAPI Err : \(err)")
            case .success(let result) :
                self.currentApodModel.accept(result)
            }
        }
    }

    func setRandomApod() {
        checkLoadImage()
        let myURL = "https://api.nasa.gov/planetary/apod?api_key=fBAxAPBbZF0M2JffWJb5751s5Y5bln4ec2nQ0sq1&count=1"
        AF.request(myURL).responseDecodable(of: Array<ApodModel>.self){ (response) in
            switch response.result {
            case .failure(let err) :
                NSLog("setAPI Err : \(err)")
            case .success(let result) :
                guard let randomApod = result.first else {
                    NSLog("Error ApodService/setRandomApod/nil ")
                    return
                }
                self.currentApodModel.accept(randomApod)
            }
        }
    }
    
    
}

/// 랜덤버튼이 눌리면 새로운 이미지를 받기 전까지 로드 이미지가 발생해야됨...
///
