//
//  Extension.swift
//  Ricky
//
//  Created by Apple on 10/06/23.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views:UIView...){
        views.forEach { view in
            addSubview(view)
        }
    }
}
