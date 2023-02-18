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
    
    func setRandomApod() -> Observable<ApodModel?> {
        return Observable.create{ apodModel in
            let myURL = "https://api.nasa.gov/planetary/apod?api_key=fBAxAPBbZF0M2JffWJb5751s5Y5bln4ec2nQ0sq1&count=1"
            AF.request(myURL).responseDecodable(of: Array<ApodModel>.self){ (response) in
                switch response.result {
                case .failure(let err) :
                    NSLog("setAPI Err : \(err)")
                case .success(let result) :
                    apodModel.onNext(result.first)
                }
            }
            return Disposables.create()
        }
    }
    
    
}
