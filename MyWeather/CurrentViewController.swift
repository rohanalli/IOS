//
//  CurrentViewController.swift
//  MyWeather
//
//  Created by Rohan Alli on 30/05/17.
//  Copyright © 2017 Rohan Alli. All rights reserved.
//

import UIKit

class CurrentViewController: UIViewController {

    var CityName: String!
    @IBOutlet weak var WeatherInfo: UITextView!

    @IBOutlet weak var TemperatureInfo: UITextView!
    var rsCity : String!
    var rsCountry : String!

    @IBOutlet weak var WeatherCode: UIImageView!
    @IBOutlet weak var CityNameLabel: UILabel!
    @IBOutlet weak var LoadingCurrent: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingCurrent.startAnimating()
        WeatherRequest()

               // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    func WeatherRequest(){
        print(rsCity)
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q="+CityName+"&appid=58497e0004372bc985de66ac45308acb&cnt=15&units=metric")
        var iconid:String!
        do{
            let reqData = try Data(contentsOf: url!)

            if let jsonData : NSDictionary = try
                JSONSerialization.jsonObject(with: reqData,options: .mutableContainers) as? NSDictionary{
                if let w = jsonData["weather"] as? [[String:Any]] {
                    for _w in w {
                        let Main:String = _w["main"] as! String
                        let Description:String = _w["description"] as! String
                        iconid = _w["icon"] as! String
                        print(Main)
                        print(Description)
                        WeatherInfo.text = Main+"\n"+Description
                    }
                }
                do{
                    let codeurl = URL(string: "http://openweathermap.org/img/w/"+iconid+".png")
                         let data = try Data(contentsOf: codeurl! )
                            WeatherCode.image = UIImage(data: data)
                    


                }catch{
                    print("Image not loaded1")
                }
                let main = jsonData["main"] as? [String:Any]
                let curtemp :Double = main?["temp"] as! Double
                let temp_max:Double = main?["temp_max"] as! Double
                let temp_min:Double = main?["temp_min"] as! Double
                let humidity: Int = main?["humidity"] as! Int
                

                let wind = jsonData["wind"] as? [String:Any]
                let wind_speed:Double = wind?["speed"] as! Double
                self.rsCity = jsonData["name"] as? String
                if let rsCountry = jsonData["sys"] as? [String:Any]{
                    self.rsCountry = rsCountry["country"]! as! String
                }
                self.CityNameLabel.text = "\(self.rsCity!),\(self.rsCountry!)"
                TemperatureInfo.text = "Current Temperature : "+String(curtemp)+" C\n"
                TemperatureInfo.text.append("    Max Temperature :"+String(temp_max)+" C\n")
                TemperatureInfo.text.append("    Min Temperature : "+String(temp_min)+" C\n")
                TemperatureInfo.text.append("           Humidity : "+String(humidity)+"\n")
                TemperatureInfo.text.append("         Wind Speed : "+String(wind_speed)+" Kmph")

                }
        LoadingCurrent.stopAnimating()
        }
        catch{
            print("Error on try Expression!")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WeeklySegue"{
            let DestViewController : ViewController = segue.destination as! ViewController

            DestViewController.CityName = CityName
            DestViewController.rsCity = rsCity
            DestViewController.rsCountry = rsCountry
        }
        if segue.identifier == "MainSegue"{
            let DestViewController1 : MainViewController = segue.destination as! MainViewController

        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
