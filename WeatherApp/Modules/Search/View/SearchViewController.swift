//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 10/04/23.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, CoordinatorBoard {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var searchTableView: UITableView!
    
    var searchedCity: [City] = []
    let searchController = UISearchController()
    
    var viewModel: SearchViewModel?
    var dispatchWorkItem: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        configureSearchBar()
        setDelegates()
    }
    
    func setDelegates() {
        self.searchBar.delegate = self
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
    }
    
    func configureSearchBar() {
        let searchIconView = searchBar.searchTextField.leftView as? UIImageView
        searchIconView?.image = searchIconView?.image?.withRenderingMode(.alwaysTemplate)
        searchIconView?.tintColor = UIColor.white
        
        self.searchBar.showsCancelButton = true
        
        let searchTextField = self.searchBar.searchTextField
        searchTextField.textColor = UIColor.white
        searchTextField.clearButtonMode = .never
        searchTextField.backgroundColor = UIColor.black
    }
    
    private func fetchLocation(searchText: String) {
        dispatchWorkItem?.cancel()
        let requestWorkItem = DispatchWorkItem {[weak self] in
            
            self?.viewModel?.searchLocation(text: searchText, onCompletion: { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        self?.searchedCity = self?.viewModel?.cities ?? []
                        self?.searchTableView.reloadData()
                    case .failure(_):
                        // Show Errorr Alert
                        print("Error")
                    }
                }
            })
        }
        dispatchWorkItem = requestWorkItem
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(500), execute: requestWorkItem)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchedCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(searchedCity[indexPath.row].name) \(searchedCity[indexPath.row].state ?? "") \( searchedCity[indexPath.row].country ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = searchedCity[indexPath.row]
        print(selectedCity)
        viewModel?.searchCoordinator?.citySelected(city: selectedCity)
        self.searchBar.searchTextField.endEditing(true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fetchLocation(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchTableView.reloadData()
    }
}

