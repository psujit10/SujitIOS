//
//  ViewController.swift
//  SujitIOSTest
//
//  Created by Admin on 12/17/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Kingfisher


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var countryInfo = [CountryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getCountry()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.red]
        
    }
    
    
    
    //MARK: Get Country Details.
    
    func getCountry() {
        ApiManager.sharedManager.getCountryInfo(url: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json", success: { (response) in
            guard let countryResponse = response
                else {
                    return
            }
            
            self.countryInfo = [CountryModel]()
            for country in countryResponse {
                let info = CountryModel(json: country as! NSDictionary)
                if !(info.description == nil && info.title == nil && info.imageHref == nil) {
                    self.countryInfo.append(info)
                }
            }
            
            DispatchQueue.main.async {
                if let title = UserDefaults.standard.value(forKey: "TITLE") {
                    self.title = title as? String
                }
                self.tableView.reloadData()
            }
            
        }, failure: { (error) in
            print("Error while fetching user from profile:\(error.localizedDescription)")
        })
        
    }
    
    
    //    private func setupTableView() {
    //        self.tableView.delegate = self
    //        self.tableView.dataSource = self
    //        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    //        tableView.translatesAutoresizingMaskIntoConstraints = false
    //        view.addSubview(tableView)
    //
    //        NSLayoutConstraint.activate([
    //            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
    //            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
    //            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    //            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
    //            ])
    //
    //    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let countryCell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
        let countryInfo = self.countryInfo[indexPath.row]
        countryCell.countryTitleLbl.text = countryInfo.title
        countryCell.countryDescriptionLbl.text = countryInfo.description
        if let imgStr = countryInfo.imageHref {
            countryCell.countryImg.kf.setImage(with: URL(string: imgStr)) //Image download using Kingfisher library.
        } else {
                countryCell.countryImg.kf.setImage(with: URL(string: ""))
        }
        return countryCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
}

