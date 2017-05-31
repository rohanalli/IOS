//
//  MainViewController.swift
//  MyWeather
//
//  Created by Rohan Alli on 30/05/17.
//  Copyright © 2017 Rohan Alli. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var CityName: UITextField!
   // let nameofcity = CityName.text
    @IBAction func GoButton(_ sender: Any) {
        if (CityName.text?.isEmpty)!{
            var myAlert = UIAlertController(title:"Alert",message:"Enter the City Name!",preferredStyle:.actionSheet)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in

            })
            myAlert.addAction(action)
            self.present(myAlert, animated: true, completion: nil)
            return
        }


    }
    override func viewDidLoad() {
        super.viewDidLoad()
        CityName.text = ""
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController : CurrentViewController = segue.destination as! CurrentViewController

        DestViewController.CityName = CityName.text

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
