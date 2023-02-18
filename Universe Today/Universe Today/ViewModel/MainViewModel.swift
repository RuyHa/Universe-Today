//
//  MainViewModel.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/16.
//

import Foundation

import RxRelay
import RxSwift

class MainViewModel {
    
    let apodData = PublishRelay<ApodModel>()
    
    let service = ApodService()
    
    let disposeBag = DisposeBag()
    
    func setApod() {
        service.setApod()
            .subscribe{ [weak self] model in
                guard let model else{
                    NSLog("RError: MainViewModel/setApod/model nil")
                    return
                }
                self?.apodData.accept(model )
            }.disposed(by: disposeBag)
    }
    
}
