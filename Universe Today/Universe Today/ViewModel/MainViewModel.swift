//
//  MainViewModel.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/16.
//

import UIKit

import RxRelay
import RxSwift

class MainViewModel {
    
    let explanationViewController = ExplanationViewController()
    let highDefinitionImageViewController = HighDefinitionImageViewController()
    
    let imageUrl = PublishRelay<String>()
    
    let disposeBag = DisposeBag()
    
    func setApod() {
        ApodService.shared.setApod()
        ApodService.shared.currentApodModel
            .subscribe{ [weak self] result in
                self?.imageUrl.accept(result.url)
            }
            .disposed(by: disposeBag)
    }
    
    func setRandomApod() {
        ApodService.shared.setRandomApod()
    }
    
    
}
