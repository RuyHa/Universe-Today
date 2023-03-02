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


class MainViewController: UIViewController {
    
    let viewModel = MainViewModel()
    let disposeBag = DisposeBag()
    
    private lazy var nextButton: UIButton = {
        let image = UIImage(systemName: "plus.viewfinder")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var ramdomButton: UIButton = {
        let image = UIImage(systemName: "gift")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(didTapRandomButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var thumbnailImageView : UIImageView = {
        let imageView =  UIImageView()
        imageView.image = UIImage(named: "loadingImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setlayout()
        setRxSwift()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showMyViewController()
    }
    
}

extension MainViewController {
    
    //MARK: RxSwift
    func setRxSwift(){
        viewModel.setApod()
        viewModel.imageUrl
            .subscribe{[weak self] result in
                self?.thumbnailImageView.imageFromUrl(urlString: result)
            }
            .disposed(by: disposeBag)
        
        viewModel.isLoadImage
            .subscribe{ [weak self] result in
                self?.thumbnailImageView.image =  UIImage(named: "loadingImage")
                //버튼 비활성화 해제 코드 추가
            }
            .disposed(by: disposeBag)

        
    }
    
    //MARK: 함수모음
    func showMyViewController() {
        let navigationController = UINavigationController(rootViewController: viewModel.explanationViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func didTapNextButton() {
        viewModel.explanationViewController.nextView(vc: viewModel.highDefinitionImageViewController)
    }
    
    @objc func didTapRandomButton() {
        //버튼이 눌리고 이미지가 불러와지기 전까진 다시 눌리면 안됨
        
        thumbnailImageView.image = UIImage(named: "loadingImage")
        viewModel.setRandomApod()
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
        
        view.addSubview(ramdomButton)
        ramdomButton.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.leading).offset(16)
            $0.bottom.equalTo(thumbnailImageView.snp.bottom).offset(-16)
            $0.height.width.equalTo(40)
        }

    }
}
