//
//  MainViewController.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/04.
//

import UIKit

import SnapKit
import Alamofire


class MainViewController: UIViewController {
    
    let explanationViewController = ExplanationViewController()
    let highDefinitionImageViewController = HighDefinitionImageViewController()
    
    let nextButton: UIButton = {
        let image = UIImage(systemName: "plus.viewfinder")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    let thumbnailImageView : UIImageView = {
        let imageView =  UIImageView()
        imageView.image = UIImage(named: "loadingImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setlayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showMyViewController()
        setAPI()
    }
    
}

extension MainViewController {
    
    //MARK: 함수모음
    func showMyViewController() {
        let navigationController = UINavigationController(rootViewController: explanationViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func didTapNextButton() {
        explanationViewController.nextView(vc: highDefinitionImageViewController)
    }
    
    func setAPI(){
        let myURL = "https://api.nasa.gov/planetary/apod?api_key=fBAxAPBbZF0M2JffWJb5751s5Y5bln4ec2nQ0sq1"
        AF.request(myURL).responseDecodable(of: APODType.self){ (response) in
            switch response.result {
            case .failure(let err) :
                print("오류가 발생했다. err: \(err)")
            case .success(let jsonResult) :
                print("pp : \(jsonResult)")
                self.explanationViewController.setExplanationView(model: jsonResult)
                self.thumbnailImageView.imageFromUrl(urlString: jsonResult.url)
                self.highDefinitionImageViewController.imageView.imageFromUrl(urlString: jsonResult.hdurl)
            }
        }
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
