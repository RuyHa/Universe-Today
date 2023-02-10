//
//  ExplanationViewController.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/05.
//

import UIKit

import SnapKit

class ExplanationViewController: UIViewController {
    
    let scrollView : UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .red
        return view
    }()
    
    let ExplanationLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let CopyrightLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.backgroundColor = .white
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        title = "ExplanationViewController"
        setSheetView()
        setlayout()
    }
    
    func nextView(){
        let nextVC = highDefinitionImageViewController()
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
        //모달이 특정 최소값 이상으로 작아지지 않음
        isModalInPresentation = true
        if let sheet = sheetPresentationController {
            //시트뷰가 고정되는 높이
            sheet.detents = [.medium(),.large()]

            //시트가 최초 올라 왔을때 보여질 기본값(높이)
            sheet.selectedDetentIdentifier = .medium
            //시트 손잡이
            sheet.prefersGrabberVisible = true
            //시트가 튀어나와 있어도 뒤에 있는 화면 클릭이 가능함
            sheet.largestUndimmedDetentIdentifier = .medium
            //내부스크롤 혀용
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
            $0.top.equalTo(ExplanationLabel.snp.bottom).offset(32)//임시값
            $0.bottom.equalTo(scrollView)
        }
        
    }
    
    
}

