//
//  FacilitiesVM.swift
//  LisfOfFacilities
//
//  Created by Avinash on 18/07/18.
//  Copyright © 2018 Demansol. All rights reserved.
//

import Foundation

enum CheckBoxImageType: String {
    case unchecked = "unchecked"
    case checked = "checked"
}

class FacilitiesVM {

    // MARK: Output Events
    var reloadTable: () -> () = { }
    
    private var listCellDatasource = [ListTableCellVM]()
    private var listExclusions = [FacilityExclusion]()
    
    init() {
        getAppData()
    }
    
    private func getAppData() {
        FacilitiesWebService.getFacilities {[weak self] (facilityList, facilityExclusions, error) in
            guard let _self = self else { return }
            _self.prepareCellViewModels(facilities: facilityList, exclusions: facilityExclusions)
            _self.reloadTable()
        }
    }
    
    private func prepareCellViewModels(facilities: [Facility]?, exclusions: [FacilityExclusion]?) {
        
        guard let facilityList = facilities else { return }
        
        //clear all previous data
        listCellDatasource.removeAll()
        listExclusions.removeAll()
        
        //fetch all the saved data
        let savedData = DatastoreManager.shared.fetchAllSavedOptions()
        //check and apply facility with saved facility
        for facility in facilityList {
            let savedFacility = savedData.filter({ $0.facilityId == facility.facilityId })
            var selectedOptionId = -1
            if (savedFacility.count > 0) {
                selectedOptionId = Int(savedFacility[0].optionId)
            }
            let listCellVM = ListTableCellVM(title: facility.name, id: facility.facilityId, items: facility.facilityOptions, selectedOptionId: selectedOptionId)
            listCellDatasource.append(listCellVM)
        }
        
        guard let exclusionList = exclusions else { return }
        listExclusions.append(contentsOf: exclusionList)
        
    }
    
    //MARK: Table Methods
    func headerTitle(for index: Int) -> String {
        return listCellDatasource[index].title
    }
    
    func numberOfSections() -> Int {
        return listCellDatasource.count
    }
    
    func numberOfCells(for index: Int) -> Int {
        return listCellDatasource[index].options.count
    }
    
    func cellInfo(section: Int, for index: Int) -> OptionVM {
        return listCellDatasource[section].options[index]
    }
    
    func cellSelected(section: Int, index: Int) {
        let item = listCellDatasource[section]
        listCellDatasource[section] = ListTableCellVM(title: item.title, id: item.id, options: item.options, selectedOptionId: item.options[index].optionId)
        reloadTable()
    }
    
    //MARK: Other Actions
    func saveAppliedFacilityFilters() {
        //remove all previous saved data
        DatastoreManager.shared.deleteAllSavedData()
        //save applied filters
        for facility in listCellDatasource {
            let selectedOptions = facility.options.filter({ $0.optionId == facility.selectedOptionId })
            if (selectedOptions.count > 0) {
                DatastoreManager.shared.save(facilityId: facility.id, optionId: selectedOptions[0].optionId)
            }
        }
    }
    
    func refreshTable() {
        //configured to clear all the saved data from database
        //please chanage the logic here
        DatastoreManager.shared.deleteAllSavedData()
        //get app data
        getAppData()
    }
    
    func canFiltersBeApplied(section: Int, index: Int) {
        //apply exclusion logic here
    }
    
}
