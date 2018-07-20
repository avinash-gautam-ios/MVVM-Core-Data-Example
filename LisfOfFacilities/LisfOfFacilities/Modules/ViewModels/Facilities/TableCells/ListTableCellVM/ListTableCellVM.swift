//
//  OptionsTableCellVM.swift
//  LisfOfFacilities
//
//  Created by Avinash on 18/07/18.
//  Copyright © 2018 Demansol. All rights reserved.
//

import Foundation

struct ListTableCellVM {
    let title: String
    let id: Int
    let selectedOptionId: Int
    
    var options = [OptionVM]()
    
    init(title: String, id: Int, items: [FacilityOption], selectedOptionId: Int) {
        self.title = title
        self.id = id
        self.selectedOptionId = selectedOptionId
        prepare(items: items)
    }
    
    init(title: String, id: Int, options: [OptionVM], selectedOptionId: Int) {
        self.title = title
        self.id = id
        self.selectedOptionId = selectedOptionId
        prepareOther(options: options)
    }
    

    mutating func prepare(items: [FacilityOption]) {
        for item in items {
            var selectedImage = CheckBoxImageType.unchecked.rawValue
            if (item.optionId == self.selectedOptionId) {
                selectedImage = CheckBoxImageType.checked.rawValue
            }
            let optionModel = OptionVM(optionsImage:item.iconName , optionsTitle: item.name, optionsStatusImage: selectedImage, optionId: item.optionId)
            options.append(optionModel)
        }
    }
    
    mutating func prepareOther(options: [OptionVM]) {
        for option in options {
            var selectedImage = CheckBoxImageType.unchecked.rawValue
            if (option.optionId == self.selectedOptionId) {
                selectedImage = CheckBoxImageType.checked.rawValue
            }
            let optionModel = OptionVM(optionsImage:option.optionsImage , optionsTitle: option.optionsTitle, optionsStatusImage: selectedImage, optionId: option.optionId)
            self.options.append(optionModel)
        }
    }
    
}


