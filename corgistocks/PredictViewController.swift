//
//  PredictViewController.swift
//  corgistocks
//
//  Created by Won Woo Nam on 3/6/21.
//

import Foundation
import UIKit
import Alamofire


class PredictViewController: UIViewController {
    var company = ""
    var total = 0
    var neg = 0
    var pos = 0
    var change = ""
    var percentage = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: company, style: .plain, target: nil, action: nil)
        
        let uiView = UIView(frame: CGRect(x: 0, y: 5, width: self.view.frame.width, height: 200))
        uiView.backgroundColor = .white
        
        let uiLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width-40, height: 150))
        uiLabel.numberOfLines = 3
        uiLabel.textAlignment = .center
        uiLabel.textColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1.0)
        uiLabel.font = UIFont.systemFont(ofSize: 15.0)
        uiView.addSubview(uiLabel)
        
        uiLabel.center.x = uiView.center.x
        uiLabel.center.y = uiView.center.y
        
        let uiLabel2 = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width-40, height: 100))
        uiLabel2.text = "Our Prediction:"
        uiLabel2.textAlignment = .center
        uiLabel2.textColor = UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1.0)
        uiLabel2.font = UIFont.systemFont(ofSize: 20.0)
        uiLabel2.center.x = uiView.center.x
        //uiLabel2.center.y = uiView.center.y
        uiView.addSubview(uiLabel2)
        
        view.addSubview(uiView)
        
        let uiView2 = UIView(frame: CGRect(x: 0, y: 212, width: self.view.frame.width, height: 200))
        uiView2.backgroundColor = .white
        
        
        let uiLabel3 = UILabel(frame: CGRect(x: 0, y: 50, width: self.view.frame.width-40, height: 100))
        uiLabel3.numberOfLines = 3
        uiLabel3.textAlignment = .center
        uiLabel3.textColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1.0)
        uiLabel3.font = UIFont.systemFont(ofSize: 15.0)
        uiLabel3.center.x = uiView2.center.x
        //uiLabel3.center.y = uiView2.center.y
        uiView2.addSubview(uiLabel3)
        
        
        
        let uiLabel4 = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width-40, height: 100))
        uiLabel4.text = "Analyzed Data:"
        uiLabel4.textAlignment = .center
        uiLabel4.textColor = UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1.0)
        uiLabel4.font = UIFont.systemFont(ofSize: 20.0)
        uiLabel4.center.x = uiView2.center.x
        //uiLabel2.center.y = uiView.center.y
        uiView2.addSubview(uiLabel4)
        
        
        
        
        view.addSubview(uiView2)
        
        
        getTotalCount {
            if self.pos > self.neg{
                self.change = "increase"
                self.percentage = ((Double(self.pos) / Double(self.pos + self.neg)) * 100).rounded(toPlaces: 1)
            }else{
                self.change = "decrease"
                self.percentage = ((Double(self.neg) / Double(self.pos + self.neg)) * 100).rounded(toPlaces: 1)
               
            }
            uiLabel.text = "There's a " + String(self.percentage) + " percent chance of " + self.change + " in " + self.company + "'s stock for March 8th of 2021."
            uiLabel3.text = "We analyzed " + String(self.neg + self.pos) + " articles and confirmed that " + String(self.pos) + " articles had positive views on the company while " + String(self.neg) + " articles had negative views."
            
            
            SpeechService.shared.speak(text: uiLabel.text!){ [self] in
                
                SpeechService.shared.speak(text: "And " + uiLabel3.text!){ [self] in
                    
                    
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController!.isNavigationBarHidden = true
    }
    
    
    func getTotalCount(completionHandler:  @escaping () -> ()){
        let param = ["keyword": company]
        let url = "https://flask-fire-3dyowcvpjq-uc.a.run.app/calc"
       
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseData { (response) in
                switch response.result {
                case .success(let result):
                   
                    let responseDict = try? JSONSerialization.jsonObject(with: response.data!, options: []) as? [String:AnyObject] as NSDictionary?
                    self.neg = responseDict!["negatives"] as! Int
                    self.pos = responseDict!["positives"] as! Int
                    print(self.neg)
                    print(self.pos)

                    
                case .failure(let error):
                    print(error.localizedDescription, error)
                }
                completionHandler()
        }
    }
}
