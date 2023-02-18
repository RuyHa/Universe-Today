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
    
    var currentApodModel = PublishRelay<ApodModel>()
    
    //MARK: RX를 사용했을때
    func setApod() -> Observable<ApodModel?> {
        return Observable.create{ apodModel in
            let myURL = "https://api.nasa.gov/planetary/apod?api_key=fBAxAPBbZF0M2JffWJb5751s5Y5bln4ec2nQ0sq1"
            AF.request(myURL).responseDecodable(of: ApodModel.self){ (response) in
                switch response.result {
                case .failure(let err) :
                    NSLog("setAPI Err : \(err)")
                case .success(let result) :
                    self.currentApodModel.accept(result)
                    apodModel.onNext(result)
                }
            }
            return Disposables.create()
        }
    }
    
}


//  MARK: 컴플리션을 사용했을때
//    func setApod(onCompleted: @escaping (ApodModel) -> Void){
//        let myURL = "https://api.nasa.gov/planetary/apod?api_key=fBAxAPBbZF0M2JffWJb5751s5Y5bln4ec2nQ0sq1"
//        AF.request(myURL).responseDecodable(of: ApodModel.self){ (response) in
//            switch response.result {
//            case .failure(let err) :
//                NSLog("setAPI Err : \(err)")
//            case .success(let result) :
//                self.currentApodModel.accept(result)
//                onCompleted(result)
//            }
//        }
//    }
