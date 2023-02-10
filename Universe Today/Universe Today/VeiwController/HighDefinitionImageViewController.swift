//
//  HighDefinitionImageViewController.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/08.
//

import UIKit

import SnapKit

class HighDefinitionImageViewController: UIViewController {
    
    let imageView : UIImageView = {
        let imageView =  UIImageView()
        imageView.image = UIImage(named: "testImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    let closeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setlayout()
    }
    
}


extension HighDefinitionImageViewController {
    
    @objc func closeView() {
        self.dismiss(animated: true)
    }
    
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
