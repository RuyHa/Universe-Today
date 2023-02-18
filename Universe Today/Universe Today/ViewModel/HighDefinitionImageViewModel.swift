//
//  HighDefinitionImageViewModel.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/18.
//

import UIKit

import RxRelay
import RxSwift

class HighDefinitionImageViewModel {
    let disposeBag = DisposeBag()
    
    let highDefinitionImageUrl = BehaviorRelay(value: "")
    
    let ppap = PublishRelay<String>()
    
    func setApod() {
        ApodService.shared.currentApodModel
            .subscribe{ [weak self] result in
                self?.highDefinitionImageUrl.accept(result.hdurl)
            }
            .disposed(by: disposeBag)
    }
    
}
