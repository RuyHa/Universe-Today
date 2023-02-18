//
//  MainViewController.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/04.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa
import Alamofire


class MainViewController: UIViewController {
    
//    let explanationViewController = ExplanationViewController()
//    let highDefinitionImageViewController = HighDefinitionImageViewController()
    
    private lazy var nextButton: UIButton = {
        let image = UIImage(systemName: "plus.viewfinder")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var thumbnailImageView : UIImageView = {
        let imageView =  UIImageView()
        imageView.image = UIImage(named: "loadingImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let viewModel = MainViewModel()
    let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setlayout()
        
        viewModel.setApod()
        viewModel.apodData
            .subscribe(onNext: { [weak self] result in
                print("..? \(result.url)")
                self?.thumbnailImageView.imageFromUrl(urlString: result.url)
            })
            .disposed(by: disposedBag)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showMyViewController()
    }
}

extension MainViewController {
    
    //MARK: 함수모음
    func showMyViewController() {
        let navigationController = UINavigationController(rootViewController: viewModel.explanationViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func didTapNextButton() {
//        viewModel.setRandomApod()

        viewModel.explanationViewController.nextView(vc: viewModel.highDefinitionImageViewController)
    }
    
}

//MARK: 오토레이아웃 영역
extension MainViewController {
    func setlayout(){
        view.addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view.frame.height/2.5)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.trailing.equalTo(thumbnailImageView.snp.trailing).offset(-16)
            $0.bottom.equalTo(thumbnailImageView.snp.bottom).offset(-16)
            $0.height.width.equalTo(40)
        }
    }
}
