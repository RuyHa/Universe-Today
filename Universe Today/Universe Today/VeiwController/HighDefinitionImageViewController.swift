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
    
    private lazy var viewModel = HighDefinitionImageViewModel()
    private lazy var disposeBag = DisposeBag()
    
    private lazy var imageView : UIImageView = {
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
    
    private lazy var imageSaveButton: UIButton = {
        let image = UIImage(systemName: "square.and.arrow.down")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
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
    private func setRxSwift(){
        viewModel.setApod()
        
        viewModel.setLoadingImage
            .subscribe{ [weak self] result in
                self?.imageView.image = UIImage(named: "loadingImage")
            }
            .disposed(by: disposeBag)
        
        viewModel.hDImage
            .subscribe{ [weak self] result in
                self?.imageView.image = result
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: 함수모음
    @objc func closeView() {
        self.dismiss(animated: true)
    }
    
    @objc
    func saveImage() {
        //저장 관련 UI추가필요
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(imageSaveCallback(_:_:_:)), nil)
    }
    
    
    @objc
    func imageSaveCallback(_ image: UIImage, _ error: NSError?, _ contextInfo: UnsafeRawPointer) {
        if let error = error {
            // 실패 했을때 분기 처리
            NSLog("HighDefinitionImageViewController_imageSaveCallback_Error : \(error)")
            //               Toast(message: error.localizedDescription).show()
            return
        }
        
        print("저장성공")
    }
    
    
    //MARK: 오토레이아웃
    private func setlayout(){
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
        
        view.addSubview(imageSaveButton)
        imageSaveButton.snp.makeConstraints{
            $0.trailing.equalTo(view.snp.trailing).offset(-16)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.width.height.equalTo(30)
        }
    }
    
}
