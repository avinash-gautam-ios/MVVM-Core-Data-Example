//
//  FacilityExclusion.swift
//  LisfOfFacilities
//
//  Created by Avinash on 20/07/18.
//  Copyright © 2018 Demansol. All rights reserved.
//

import Foundation

struct FacilityExclusion {
    var facilityExclusions = [FacilityOptionExclusions]()
    
    init(info: [[String: Any]]) {
        for exclusion in info {
            if let facility_id = exclusion["facility_id"] as? String, let options_id = exclusion["options_id"] as? String {
                let facilityId = Int(facility_id)!
                let optionId = Int(options_id)!
                facilityExclusions.append(FacilityOptionExclusions(facility_id: facilityId, options_id: optionId))
            }
        }
    }
}

struct FacilityOptionExclusions {
    let facility_id: Int
    let options_id: Int
}
