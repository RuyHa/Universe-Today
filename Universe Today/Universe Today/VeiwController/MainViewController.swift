//
//  MainViewController.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/04.
//

import UIKit

import SnapKit

class MainViewController: UIViewController {
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("테스트버튼", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
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
        let navigationController = UINavigationController(rootViewController: ExplanationViewController())
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func didTapNextButton() {
        print("테스트버튼이 클릭됨")
    }
    
    
    //MARK: 오토레이아웃 영역
    func setlayout(){
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
