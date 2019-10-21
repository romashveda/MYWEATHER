//
//  BaseTVCell.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/20/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit

class BaseTVCell: UITableViewCell {
    
    // Not sure whether Cell is a right place to search for correspoding Nib file
    class var cellNib: UINib? {
        var nibName = self.description().components(separatedBy: ".").last!
        var nib = UINib(nibName: nibName, bundle: nil)
        if Bundle.main.path(forResource: nibName, ofType: "nib") == nil {
            nibName = self.description().components(separatedBy: ".").last!
            nib = UINib(nibName: nibName, bundle: nil)
            if Bundle.main.path(forResource: nibName, ofType: "nib") == nil {
                nibName = nibName + "_0"
                nib = UINib(nibName: nibName, bundle: nil)
            }
        }
        return nib
    }
    
    class var cellIdentifier: String? {
        return nil
    }
}
