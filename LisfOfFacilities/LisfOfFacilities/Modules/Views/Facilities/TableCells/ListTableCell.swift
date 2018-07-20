//
//  ListTableCell.swift
//  LisfOfFacilities
//
//  Created by Avinash on 18/07/18.
//  Copyright © 2018 Demansol. All rights reserved.
//

import UIKit

class ListTableCell: UITableViewCell {

    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var listOptionLabel: UILabel!
    @IBOutlet weak var optionImageView: UIImageView!
    @IBOutlet weak var cellSelectionStatusImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(info: OptionVM) {
        listOptionLabel.text = info.optionsTitle
        optionImageView.image = UIImage(named: info.optionsImage)
        cellSelectionStatusImageView.image = UIImage(named: info.optionsStatusImage)
    }

}
