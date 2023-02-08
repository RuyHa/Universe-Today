//
//  MainViewController.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/04.
//

import UIKit

import SnapKit

class MainViewController: UIViewController {
    
    let explanationViewController = ExplanationViewController()
    
    //버튼의 이름, 타이틀, 이미지 수정 필요
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("테스트버튼", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    let thumbnailImageView : UIImageView = {
        let imageView =  UIImageView()
        imageView.image = UIImage(named: "testImage")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        title = "dd"
        setlayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showMyViewController()
    }
    
}

extension MainViewController {
    
    //MARK: 함수모음
    func showMyViewController() {
        let navigationController = UINavigationController(rootViewController: explanationViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func didTapNextButton() {
        print("테스트버튼이 클릭됨")
        explanationViewController.nextView()
    }
    
    
    //MARK: 오토레이아웃 영역
    func setlayout(){
        view.addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(340) //임시 값
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.trailing.equalTo(thumbnailImageView.snp.trailing).offset(-16)
            $0.bottom.equalTo(thumbnailImageView.snp.bottom).offset(-16)
        }
        
    }
    
}
