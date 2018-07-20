//
//  DatastoreManager.swift
//  LisfOfFacilities
//
//  Created by Avinash on 20/07/18.
//  Copyright © 2018 Demansol. All rights reserved.
//

import Foundation
import CoreData

class DatastoreManager {
    
    public static var shared: DatastoreManager! = nil
    
    var managedContext: NSManagedObjectContext
    
    private init(context: NSManagedObjectContext) {
        self.managedContext = context
    }
    
    public class func shared(context: NSManagedObjectContext) {
        if (self.shared == nil) {
            self.shared = DatastoreManager(context: context)
            self.shared.managedContext = context
        }
    }
    
    public func save(facilityId: Int, optionId: Int) {
        // Create Entity
        let entity = NSEntityDescription.entity(forEntityName: "FacilitySavedOption", in: managedContext)
        
        // Initialize Record
        let record = FacilitySavedOption(entity: entity!, insertInto: managedContext)
        record.facilityId = Int64(facilityId)
        record.optionId = Int64(optionId)
        
        managedContext.performAndWait {
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("could not save, managedobject \(error), \(error.userInfo)")
            }
        }
    }
    
    public func fetchAllSavedOptions() -> [FacilitySavedOption] {
        let request: NSFetchRequest<FacilitySavedOption> = FacilitySavedOption.fetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(request)
            for data in result {
                print(data)
            }
            return result
        } catch {
            print("fetch request failed, managedobject")
            return [FacilitySavedOption]()
        }
    }
    
    public func deleteAllSavedData() {
        let savedItems = fetchAllSavedOptions()
        for savedItem in savedItems {
            managedContext.performAndWait {
                managedContext.delete(savedItem)
            }
        }
    }
    
}
