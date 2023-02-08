//
//  highDefinitionImageViewController.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/08.
//

import UIKit

import SnapKit

class highDefinitionImageViewController: UIViewController {

    let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("닫기버튼", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setlayout()
    }
    
}

extension highDefinitionImageViewController {
    
    @objc func closeView() {
        self.dismiss(animated: true)
    }
    
    func setlayout(){
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints{
            $0.leading.equalTo(view.snp.leading).offset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
