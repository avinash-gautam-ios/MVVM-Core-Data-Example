//
//  Facility.swift
//  LisfOfFacilities
//
//  Created by Avinash on 18/07/18.
//  Copyright © 2018 Demansol. All rights reserved.
//

import Foundation

struct Facility {
    let name: String
    let facilityId: Int
    var facilityOptions = [FacilityOption]()
    
    init(info: [String:Any]) {
        if let name = info["name"] as? String, let facility_id = info["facility_id"] as? String, let options = info["options"] as? [[String:Any]] {
            let facilityId = Int(facility_id)!
            self.name = name
            self.facilityId = facilityId
            print(options)
            for option in options {
                if let name = option["name"] as? String, let iconName = option["icon"] as? String, let optionId = option["id"] as? String {
                    let option_id = Int(optionId)!
                    facilityOptions.append(FacilityOption(name: name, iconName: iconName, optionId: option_id))
                }
            }
        } else {
            self.name = ""
            self.facilityId = -1
        }
    }
}

struct FacilityOption {
    let name: String
    let iconName: String
    let optionId: Int
}
