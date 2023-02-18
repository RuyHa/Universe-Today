//
//  ExplanationViewController.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/05.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class ExplanationViewController: UIViewController {
    
    let viewModel = ExplanationViewModel()
    let disposeBag = DisposeBag()
    
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    
    let scrollView : UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .black
        return view
    }()
    
    let explanationLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .lightGray
        return label
    }()
    
    let copyrightLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .lightGray
        return label
    }()
    
    let apiLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .lightGray
        label.text = "API : NASA Open APIs APOD"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Loading..."
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = UIColor.black
        
        setSheetView()
        setlayout()
        
        viewModel.setApod()
        viewModel.title
            .bind(to: self.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.explanation
            .bind(to: explanationLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.copyright
            .bind(to: copyrightLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func nextView(vc : UIViewController){
        let nextVC = vc
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
    }
    
}

extension ExplanationViewController {
    
    //MARK: 함수모음
    private func setSheetView(){
        isModalInPresentation = true
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium(),.large()]
            sheet.selectedDetentIdentifier = .medium
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
    }
    
    func setlayout(){
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(explanationLabel)
        explanationLabel.snp.makeConstraints{
            $0.leading.equalTo(view).offset(16)
            $0.trailing.equalTo(view).offset(-16)
            $0.top.equalTo(scrollView)
        }
        
        scrollView.addSubview(copyrightLabel)
        copyrightLabel.snp.makeConstraints{
            $0.centerX.equalTo(scrollView)
            $0.width.equalTo(view.snp.width).offset(-32)
            $0.top.equalTo(explanationLabel.snp.bottom).offset(32)
        }
        
        scrollView.addSubview(apiLabel)
        apiLabel.snp.makeConstraints{
            $0.leading.trailing.width.equalTo(copyrightLabel)
            $0.top.equalTo(copyrightLabel.snp.bottom).offset(16)
            $0.bottom.equalTo(scrollView)
        }
        
    }
    
    
}

