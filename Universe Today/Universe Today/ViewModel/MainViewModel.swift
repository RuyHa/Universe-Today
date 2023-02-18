//
//  MainViewModel.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/16.
//

import Foundation

import RxRelay
import RxSwift
import UIKit

class MainViewModel {
    
    let explanationViewController = ExplanationViewController()
    let highDefinitionImageViewController = HighDefinitionImageViewController()
    
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
                self?.apodData.accept(model)
            }.disposed(by: disposeBag)
   
        apodData
            .subscribe(onNext: { [weak self] result in
                self?.explanationViewController.setExplanationView(model: result)
                self?.highDefinitionImageViewController.imageView.imageFromUrl(urlString: result.hdurl)
            })
            .disposed(by: disposeBag)

    }
    
    
    
    func setRandomApod() {
        service.setRandomApod()
            .subscribe{ [weak self] model in
                guard let model else{
                    NSLog("RError: MainViewModel/setApod/model nil")
                    return
                }
                self?.apodData.accept(model)
            }.disposed(by: disposeBag)
    }
    
}
