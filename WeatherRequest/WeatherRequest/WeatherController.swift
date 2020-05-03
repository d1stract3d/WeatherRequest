//
//  WeatherController.swift
//  WeatherRequest
//
//  Created by Alex McCall on 5/1/20.
//  Copyright © 2020 Alex McCall. All rights reserved.
//

import Foundation

class WeatherController {
    let baseURLString = "https://api.openweathermap.org/data/2.5/forecast?q=Austin&appid=776946f0a9f2b844ccff24197a1b7985"
    var units = "imperial"
    let appID = "776946f0a9f2b844ccff24197a1b7985"
    
    func fetchCurrentWeatherData(matching query:[String:String],completion: @escaping([ForecastList]?)->Void){
        let baseURL = URL(string: baseURLString)
        
        guard let url = baseURL?.withQueries(query) else {
            print("Unable to build URL with supplied query.")
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        let decoder = JSONDecoder()
        
        if let data = data {
            do {
                if let list = try decoder.decode(Forecast?.self, from:data) {
                    completion(list.list) }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }

    func parseWeather(_ fList:[ForecastList],_ index:Int) -> Weather {
        return fList[index].weather[0]
    }
    func parseMain(_ fList:[ForecastList],_ index:Int)-> Main {
        return fList[index].main
    }
}
