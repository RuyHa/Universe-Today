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
    func imageFromUrl(urlString: String) {
       let url = URL(string: urlString)
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

