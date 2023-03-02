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
    
    let setLoadingImage = PublishRelay<Bool>()
    
    func setApod() {
        
        ApodService.shared.setLoadingImage
            .subscribe{ [weak self] result in
                self?.setLoadingImage.accept(result)
            }
            .disposed(by: disposeBag)
        
        ApodService.shared.currentApodModel
            .subscribe{ [weak self] result in
                self?.highDefinitionImageUrl.accept(result.hdurl)
            }
            .disposed(by: disposeBag)
    }
    
}
