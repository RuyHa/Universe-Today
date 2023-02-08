//
//  ExplanationViewController.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/05.
//

import UIKit

import SnapKit

class ExplanationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        title = "ExplanationViewController"
        setSheetView()
    }
    
    func nextView(){
        let nextVC = highDefinitionImageViewController()
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
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
        }
    }
    

    
}

