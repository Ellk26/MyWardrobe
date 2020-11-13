//
//  WeatherModel.swift
//  MyWardrobe
//
//  Created by elliott kung on 2020-10-27.
//

import Foundation

/*
    1. create a URL object
    2. create URLSession task to retreieve the data
    3. map the data response to structs that use the JSON namings
        for nested JSON create other structs with the same key-pairs and map to the main struct 
 
 */


class WeatherModel{
    
    struct WeatherData: Codable{
        let name: String
        let main: Main
        let weather: [Weather]
    }

    struct Main: Codable{
        var temp: Double
    }

    struct Weather: Codable{
        let description: String
        let icon: String
    }
    
    var temperature = 0
    var summary = ""
    var icon = ""
    
    func getWeatherData(location: String, completion: @escaping(WeatherData) -> Void){
    
        guard let url = URL(string: "\(MyConstants.WEATHER_URL)\(location),CA&units=\(MyConstants.UNITS)&appid=\(MyConstants.API_KEY)") else { return }
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async{
                if let error = error{
                    print(error)
                    return
                }
                
                guard let data = data else { return }
                
                do{
                    let decoder = JSONDecoder()
                    let weatherObj = try decoder.decode(WeatherData.self, from: data)
                    self.temperature = Int(weatherObj.main.temp.rounded())
                    self.summary = weatherObj.weather[0].description
                    self.icon = weatherObj.weather[0].icon
                    completion(weatherObj)
                }catch let jsonErr{
                    print(jsonErr)
                }
            }
        }
        task.resume()
        
    }
    
}
