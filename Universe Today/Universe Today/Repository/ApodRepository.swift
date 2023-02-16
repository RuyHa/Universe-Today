//
//  ApodRepository.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/16.
//

import Foundation
import Alamofire

//class ApodRepository {
//        
//    func setApod(onCompleted: @escaping (ApodModel) -> Void){
//        let myURL = "https://api.nasa.gov/planetary/apod?api_key=fBAxAPBbZF0M2JffWJb5751s5Y5bln4ec2nQ0sq1"
//        AF.request(myURL).responseDecodable(of: ApodModel.self){ (response) in
//            switch response.result {
//            case .failure(let err) :
//                NSLog("setAPI Err : \(err)")
//            case .success(let result) :
//                onCompleted(result)
//                
//                //여기는 api값을 요청하고 값을 넘겨야 한다...
////                self.explanationViewController.setExplanationView(model: jsonResult)
////                self.thumbnailImageView.imageFromUrl(urlString: jsonResult.url)
////                self.highDefinitionImageViewController.imageView.imageFromUrl(urlString: jsonResult.hdurl)
//            }
//        }
//    }
//    
//}

