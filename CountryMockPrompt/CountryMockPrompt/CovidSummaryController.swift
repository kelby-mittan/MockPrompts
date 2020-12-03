//
//  ViewController.swift
//  CountryMockPrompt
//
//  Created by Kelby Mittan on 12/3/20.
//

import UIKit

class CovidSummaryController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private let apiClient = APIClient()
    
    private var countries = [Summary]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        getCovidData()
    }


    private func getCovidData() {
        apiClient.fetchCovidData { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let countries):
                dump(countries)
                self?.countries = countries
            }
        }
    }
    
}

extension CovidSummaryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        
        let countrySummary = countries[indexPath.row]
        cell.textLabel?.text = countrySummary.country
        cell.detailTextLabel?.text = "New Confirmed: \(countrySummary.newConfirmed)"
        return cell
    }
    
    
}
