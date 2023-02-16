//
//  MainViewModel.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/16.
//

import Foundation

import RxRelay


class MainViewModel {
    let apodData = BehaviorRelay(value: ApodModel(title: "Loding...",
                                                  explanation: "",
                                                  url: "",
                                                  hdurl: "",
                                                  date: "",
                                                  copyright: "",
                                                  media_type: "",
                                                  service_version: ""))
    
    let service = ApodService()
    
    func setApod(){
        service.setApod { [weak self] model in
            self?.apodData.accept(model)
            print("MainViewModel/apodDate")
        }
    }
}
