//
//  ExplanationViewController.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/05.
//

import UIKit

import SnapKit

class ExplanationViewController: UIViewController {
    
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    
    let scrollView : UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .black
        return view
    }()
    
    let ExplanationLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .lightGray
        return label
    }()
    
    let CopyrightLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .lightGray
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
    }
    
    func nextView(vc : UIViewController){
        let nextVC = vc
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
    }
    
    func setExplanationView(model:APODType){
        self.title = model.title
        self.ExplanationLabel.text = " " + model.explanation.addNewline()
        self.CopyrightLabel.text = "Copyright : " + model.copyright
        print(model.explanation)
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
        
        scrollView.addSubview(ExplanationLabel)
        ExplanationLabel.snp.makeConstraints{
            $0.leading.equalTo(view).offset(16)
            $0.trailing.equalTo(view).offset(-16)
            $0.top.equalTo(scrollView)
        }
        
        scrollView.addSubview(CopyrightLabel)
        CopyrightLabel.snp.makeConstraints{
            $0.centerX.equalTo(scrollView)
            $0.width.equalTo(view.snp.width).offset(-32)
            $0.top.equalTo(ExplanationLabel.snp.bottom).offset(32)
            $0.bottom.equalTo(scrollView)
        }
        
    }
    
    
}

