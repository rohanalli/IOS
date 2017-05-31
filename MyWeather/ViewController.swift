//
//  ViewController.swift
//  MyWeather
//
//  Created by Rohan Alli on 30/05/17.
//  Copyright © 2017 Rohan Alli. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var CityName : String!


    var rsCity : String!
    var rsCountry : String!

    var weatherItem : [WeatherItem] = []

    @IBOutlet weak var WeeklyLoading: UIActivityIndicatorView!
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var weatherTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        WeeklyLoading.startAnimating()
        // Do any additional setup after loading the view, typically from a nib.
        currentWeatherRequest()
        WeeklyLoading.stopAnimating()

    }

    func currentWeatherRequest() {
       // print(CityName)
        let endpoint = URL(string: "http://api.openweathermap.org/data/2.5/forecast/daily?q="+CityName+"&appid=58497e0004372bc985de66ac45308acb&cnt=15&units=metric")
        do {
            let reqData = try Data(contentsOf: endpoint!)

            if let jsonData : NSDictionary = try
            JSONSerialization.jsonObject(with: reqData, options: .mutableContainers) as? NSDictionary{
                print(jsonData)
                if let weathers = jsonData["list"] as? [[String:AnyObject]] {
                    for item in weathers {


                        var _wTempDay : Double
                        var _wTempMin : Double
                        var _wTempMax : Double
                        var _wTempNight : Double
                        var _wTempEvening : Double
                        var _wTempMorning : Double
                        var _wMain : String = ""
                        var _wDescription : String = ""
                        var _wiconid :String = ""
                        let _wPressure : Double = item["pressure"] as! Double
                        let _wHumidity : Int = item["humidity"] as! Int
                        let _wSpeed : Int = item["speed"] as! Int
                        let _wDeg : Int = item["deg"] as! Int
                        let _wClouds : Int = item["clouds"] as! Int


                        let t = item["temp"] as? [String:Double]
                            _wTempDay = (t?["day"])!
                            _wTempMin = (t?["min"])!
                            _wTempMax = (t?["max"])!
                            _wTempNight = (t?["night"])!
                            _wTempEvening = (t?["eve"])!
                            _wTempMorning = (t?["morn"])!

                        if let w = item["weather"] as? [[String:Any]] {
                            for _w in w {
                                _wMain = _w["main"] as! String
                                _wDescription = _w["description"] as! String
                                _wiconid = _w["icon"] as! String
                            }
                        }


                        let itemToDisplay = WeatherItem(wDate: item["dt"] as! Int, wTempDay: _wTempDay, wTempMin: _wTempMin, wTempMax: _wTempMax, wTempNight: _wTempNight, wTempEvening: _wTempEvening, wTempMorning: _wTempMorning, wMain: _wMain, wDescription: _wDescription,wiconid:_wiconid, wPressure: _wPressure, wHumidity: _wHumidity, wSpeed: _wSpeed, wDeg: _wDeg, wClouds: _wClouds)
                        self.weatherItem.append(itemToDisplay)
                    }
                }


                labelCityName.text = "\(self.rsCity!),\(self.rsCountry!)"
                weatherTableView.reloadData()

            }

        } catch {
            print("Error on try Expression!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

            let date = NSDate(timeIntervalSince1970: TimeInterval(weatherItem[indexPath.row].wDate))
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "dd/MMM hh:mm a"
            let dateString = dayTimePeriodFormatter.string(from: date as Date)

            cell.textLabel?.text = "\(dateString): Temp: \(weatherItem[indexPath.row].wTempMin) - \(weatherItem[indexPath.row].wTempMax) C"
            cell.detailTextLabel?.text = "\(weatherItem[indexPath.row].wMain.description) : \(weatherItem[indexPath.row].wDescription.description)"

        do{
            let codeurl = URL(string: "http://openweathermap.org/img/w/"+weatherItem[indexPath.row].wiconid+".png")
            let data = try Data(contentsOf: codeurl! )
            cell.imageView?.image = UIImage(data: data)

        }catch{
            cell.imageView?.image = UIImage(named: "weather-question")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherItem.count
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController : CurrentViewController = segue.destination as! CurrentViewController

        DestViewController.CityName = CityName

    }



}
