//
//  LocationTVCell.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/19/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit

final class LocationTVCell: BaseTVCell {
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // Would be nice to have this method overloaded and to make sure every UI element are "fresh and cleand" before cell will be reused 
    
//    override func prepareForReuse() {
//
//    }
}
