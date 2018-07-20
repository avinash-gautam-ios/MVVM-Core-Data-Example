//
//  FacilitiesWebService.swift
//  LisfOfFacilities
//
//  Created by Avinash on 18/07/18.
//  Copyright © 2018 Demansol. All rights reserved.
//

import Foundation

struct FacilitiesWebService {
    
    static func getFacilities(callback: @escaping ([Facility]?, [FacilityExclusion]?, Error?) -> ()) {
        HttpManager.sharedService.requestAPI(url: WebServiceConstants.facitlitiesURL, parameter: nil, httpMethodType: .GET) { (response, error) in
            if let data = response {
                let facilityList = getFacilitiesFrom(data: data)
                let exclusions = getFacilitiesExcusionsFrom(data: data)
                callback(facilityList, exclusions, nil)
            } else {
                callback(nil, nil, error)
            }
        }
    }
    
    private static func getFacilitiesFrom(data: [String: Any]) -> [Facility] {
        var facilities = [Facility]()
        if let facilityInfo = data["facilities"] as? [[String: Any]] {
            for facility in facilityInfo {
                print(facility)
                facilities.append(Facility(info: facility))
            }
        }
        return facilities
    }
    
    private static func getFacilitiesExcusionsFrom(data: [String: Any]) -> [FacilityExclusion] {
        var facilityExclusions = [FacilityExclusion]()
        if let exclusion = data["exclusions"] as? [[[String: Any]]] {
            for facility in exclusion {
                print(facility)
                facilityExclusions.append(FacilityExclusion(info: facility))
            }
        }
        return facilityExclusions
    }
    
}
