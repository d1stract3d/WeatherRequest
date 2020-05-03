//
//  WeatherTableViewController.swift
//  WeatherRequest
//
//  Created by Alex McCall on 5/1/20.
//  Copyright © 2020 Alex McCall. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBarCity: UISearchBar!
    
    var weatherController = WeatherController()
    var fList : [ForecastList] = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarCity.delegate = self
        
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
    }
    
    func fetchMatchingItems() {
        self.fList = []
        self.tableView.reloadData()
        
        let searchTerm = searchBarCity.text ?? ""
        
        if !searchTerm.isEmpty {
            
        let query:[String:String] = [
                      "q": searchTerm,
                  "units": weatherController.units,
                  "appid": weatherController.appID
            ]
            
            weatherController.fetchCurrentWeatherData(matching: query) { (forecastItems) in
                DispatchQueue.main.async {
                    if let fItems = forecastItems {
                        self.fList = fItems
                        self.tableView.reloadData()
                    } else {
                        print("Fetching data failed!")
                    }
                }
            }
        }
     }

    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {

            let item = fList[indexPath.row]
        
        cell.textLabel?.text = "\(String(item.main.temp)) ºF"
        cell.detailTextLabel?.text = item.dt_txt
        
        let weather = item.weather.first
        let icon = weather!.icon
                   let iconURL = URL(string:"https://openweathermap.org/img/w/"+icon+".png")!
                   let task = URLSession.shared.dataTask(with:iconURL) { (data, response, error) in guard let imageData = data else {return}
                       DispatchQueue.main.async {
                           let image = UIImage(data:imageData)
                           cell.imageView?.image = image
                       }
                   }
                       task.resume()
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellWeather", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }


    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            fetchMatchingItems()
            searchBarCity.resignFirstResponder()
      }
      
}
