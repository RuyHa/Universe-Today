//
//  HighDefinitionImageViewController.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/08.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class HighDefinitionImageViewController: UIViewController {
    
    let viewModel = HighDefinitionImageViewModel()
    let disposeBag = DisposeBag()
    
    lazy var imageView : UIImageView = {
        let imageView =  UIImageView()
        imageView.image = UIImage(named: "loadingImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var closeButton: UIButton = {
        let image = UIImage(systemName: "xmark")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setlayout()
        setRxSwift()
    }
    
}


extension HighDefinitionImageViewController {
    
    //MARK: RxSwfit
    func setRxSwift(){
        viewModel.setApod()
        viewModel.highDefinitionImageUrl
            .subscribe{[weak self] result in
                if result != "" {
                    self?.imageView.imageFromUrl(urlString: result)
                }
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: 함수모음
    @objc func closeView() {
        self.dismiss(animated: true)
    }
    
    //MARK: 오토레이아웃
    func setlayout(){
        view.addSubview(imageView)
        imageView.snp.makeConstraints{
            $0.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints{
            $0.leading.equalTo(view.snp.leading).offset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.width.height.equalTo(30)
        }
    }
    
}
