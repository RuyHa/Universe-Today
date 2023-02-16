//
//  ApodService.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/16.
//

import Foundation

import RxRelay
import Alamofire

class ApodService {
    
    var currentApodModel = BehaviorRelay(value: ApodModel(title: "Loding...",
                                                         explanation: "",
                                                         url: "",
                                                         hdurl: "",
                                                         date: "",
                                                         copyright: "",
                                                         media_type: "",
                                                         service_version: ""))
    
    func setApod(onCompleted: @escaping (ApodModel) -> Void){
        let myURL = "https://api.nasa.gov/planetary/apod?api_key=fBAxAPBbZF0M2JffWJb5751s5Y5bln4ec2nQ0sq1"
        AF.request(myURL).responseDecodable(of: ApodModel.self){ (response) in
            switch response.result {
            case .failure(let err) :
                NSLog("setAPI Err : \(err)")
            case .success(let result) :
                self.currentApodModel.accept(result)
                onCompleted(result)
            }
        }
    }
    
    
}
