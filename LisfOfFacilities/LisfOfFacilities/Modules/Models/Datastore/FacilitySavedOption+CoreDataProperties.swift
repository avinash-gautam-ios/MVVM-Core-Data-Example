//
//  FacilitySavedOption+CoreDataProperties.swift
//  LisfOfFacilities
//
//  Created by Avinash on 20/07/18.
//  Copyright © 2018 Demansol. All rights reserved.
//
//

import Foundation
import CoreData

extension FacilitySavedOption {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FacilitySavedOption> {
        return NSFetchRequest<FacilitySavedOption>(entityName: "FacilitySavedOption")
    }

    @NSManaged public var facilityId: Int64
    @NSManaged public var optionId: Int64

}
