//
//  WeatherItem.swift
//  MyWeather
//
//  Created by Rohan Alli on 30/05/17.
//  Copyright © 2017 Rohan Alli. All rights reserved.
//

import UIKit

class WeatherItem: NSObject {

    var wDate : Int

    var wTempDay : Double
    var wTempMin : Double
    var wTempMax : Double
    var wTempNight : Double
    var wTempEvening : Double
    var wTempMorning : Double

    var wMain : String
    var wDescription : String
    var wiconid : String

    var wPressure : Double
    var wHumidity : Int
    var wSpeed : Int
    var wDeg : Int
    var wClouds : Int

    init(wDate : Int, wTempDay : Double, wTempMin : Double, wTempMax : Double, wTempNight : Double, wTempEvening : Double, wTempMorning : Double, wMain : String, wDescription : String,wiconid : String,wPressure : Double, wHumidity : Int, wSpeed : Int, wDeg : Int, wClouds : Int) {

        self.wDate = wDate
        self.wTempDay = wTempDay
        self.wTempMin = wTempMin
        self.wTempMax = wTempMax
        self.wTempNight = wTempNight
        self.wTempEvening = wTempEvening
        self.wTempMorning = wTempMorning
        self.wMain = wMain
        self.wDescription = wDescription
        self.wiconid = wiconid
        self.wPressure = wPressure
        self.wHumidity = wHumidity
        self.wSpeed = wSpeed
        self.wDeg = wDeg
        self.wClouds = wClouds

    }

}
