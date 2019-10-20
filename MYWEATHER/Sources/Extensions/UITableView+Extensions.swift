//
//  UITableView+Extensions.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/20/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: BaseTVCell>(cellType: T.Type) {
        let identifier = "\(cellType)"
        if let nib = T.cellNib {
            self.register(nib, forCellReuseIdentifier: identifier)
        } else {
            self.register(cellType, forCellReuseIdentifier: identifier)
        }
    }
    
    func cell<T: BaseTVCell>(cellType: T.Type) -> T? {
        let identifier = "\(cellType)"
        guard let cell = self.dequeueReusableCell(withIdentifier: "\(identifier)") as? T else {
            return nil
        }
        return cell
    }
}
