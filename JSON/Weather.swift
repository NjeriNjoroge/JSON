//
//  Weather.swift
//  JSON
//
//  Created by Grace on 23/03/2018.
//  Copyright © 2018 Grace. All rights reserved.
//

import Foundation

struct Weather {
    let summary: String
    let icon: String
    let temparature: Double
    
    //to know what kind of errors we have
    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json:[String:Any]) throws {
        guard let summary = json["summary"] as? String else { throw SerializationError.missing("summary is missing") }
        guard let icon = json["icon"] as? String else { throw SerializationError.missing("icon is missing") }
        guard let temparature = json["temperatureMax"] as? Double else { throw SerializationError.missing("temp is missing") }
        
        self.summary = summary
        self.icon = icon
        self.temparature = temparature
    }
    
    //defining a basePath for my url
    static let basePath = "https://api.darksky.net/forecast/put key/"
    
    static func forecast (withLocation location:String, completion: @escaping ([Weather]) -> ()) {
        
        let url = basePath + location
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var forecastArray:[Weather] = []
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let dailyForecasts = json["daily"] as? [String:Any] {
                            if let dailyData = dailyForecasts["data"] as? [[String:Any]] {
                                for dataPoint in dailyData {
                                    if let weatherObject = try? Weather(json: dataPoint) {
                                        forecastArray.append(weatherObject)
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
                completion(forecastArray)
            }
            
        }
        task.resume()
    }
}
