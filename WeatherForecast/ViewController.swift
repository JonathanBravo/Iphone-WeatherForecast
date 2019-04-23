//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Jonathan Flowers on 2/3/19.
//  Copyright © 2019 Jonathan Flowers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    func cityModifier(input: String) -> String{
        
        let newString = input.replacingOccurrences(of: " ", with: "-")
        
        return newString
    }
   
    func findWeather(input: NSString) -> String{
        var str2 = "Please input a valid city"
        let strBound1 = "Weather Today </h2>(1&ndash;3 days)</span><p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
        let strBound2 = "</span></p></td><td class=\"b-forecast__table-description-cell--js\" colspan=\"9\"><span class=\"b-forecast__table-description-title\"><h2>"
        if input.contains(strBound1)&&input.contains(strBound2){
        var array = input.components(separatedBy: strBound1)
        let str1 = String(array[1])
        let nsStr1 = NSString(string: str1)
        array = nsStr1.components(separatedBy: strBound2)
        str2 = String(array[0])
        }
        return str2
    }
    
    
    
    @IBOutlet weak var outputWeather: UILabel!
    @IBOutlet weak var inputCity: UITextField!
    
    @IBAction func searchForCity(_ sender: Any) {
        var citySearch = "San Francisco"
        if let city = inputCity.text{
            citySearch = cityModifier(input: city)
        }
        
        let urlString = "https://www.weather-forecast.com/locations/" + citySearch + "/forecasts/latest"
        
        if let url = URL(string: urlString) {
            
            let request = NSMutableURLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                if error != nil {
                    
                    print("Come on now")
                    
                } else {
                    
                    if let unwrappedData = data {
                        
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        
                        print(dataString!)
                        
                        DispatchQueue.main.sync(execute: {
                            
                            self.outputWeather.text = self.findWeather(input: dataString!)
                            
                            
                        })
                        
                        
                    }
                    
                    
                }
                
                
            }
            
            task.resume()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

    
    
    /*
    var inputURL = ""
    
    let inputString = "https://www.weather-forecast.com/locations/" + inputURL + "/forecasts/latest"
 */
}

