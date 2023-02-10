//
//  UIImageView+.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/08.
//

import UIKit
import RxAlamofire
import RxSwift

extension UIImageView {
    //뭔지모르고씀 ㅋㅋ 추후 리팩
    public func imageFromUrl(urlString: String) {
        requestData(.get, urlString)
            .observeOn(MainScheduler.instance)
            .subscribe{ self.image = UIImage(data: $0.1)}
    }
}

