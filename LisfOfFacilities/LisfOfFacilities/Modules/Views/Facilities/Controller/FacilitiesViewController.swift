//
//  FacilitiesView.swift
//  LisfOfFacilities
//
//  Created by Avinash on 18/07/18.
//  Copyright © 2018 Demansol. All rights reserved.
//

import UIKit

class FacilitiesViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    private var viewModel = FacilitiesVM()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Clear All")
        refreshControl.tintColor = UIColor.black
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpOuputObservables()
    }
    
    func setUp() {
        //start refreshing as soon as it is available
        refreshControl.beginRefreshing()
        
        listTableView.addSubview(refreshControl)
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.refreshTable()
    }
    
    func setUpOuputObservables() {
        viewModel.reloadTable = {[weak self] in
            guard let _self = self else { return }
            DispatchQueue.main.async {
                if (_self.refreshControl.isRefreshing) {
                    _self.refreshControl.endRefreshing()
                }
                _self.listTableView.reloadData()
            }
        }
    }
    
    private func cellForListTableAt(indexPath: IndexPath, section: Int) -> ListTableCell {
        let cell: ListTableCell = listTableView.dequeueReusableCell(withIdentifier: "facilityOptionCell", for: indexPath) as! ListTableCell
        cell.configure(info: viewModel.cellInfo(section: section, for: indexPath.row))
        return cell
    }
    
    @IBAction func applyButtonAction(_ sender: Any) {
        viewModel.saveAppliedFacilityFilters()
    }
    
}

extension FacilitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells(for: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForListTableAt(indexPath: indexPath, section: indexPath.section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellSelected(section: indexPath.section, index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.headerTitle(for: section)
    }

}
