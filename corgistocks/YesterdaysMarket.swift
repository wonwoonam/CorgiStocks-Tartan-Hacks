//
//  YesterdaysMarket.swift
//  corgistocks
//
//  Created by Won Woo Nam on 3/7/21.
//

import UIKit
import Alamofire
import AVFoundation
import googleapis


class YesterdaysMarketController: UIViewController, AudioControllerDelegate {
    var audioData: NSMutableData!
    var speechText = ""
    
    var company = ""
    var openPrice = ""
    var closePrice = ""
    var change = ""
    var constant = ""
    var currDate = ""
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        AudioController.sharedInstance.delegate = self
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
        uiLabel2.text = "Past Data"
        uiLabel2.textAlignment = .center
        uiLabel2.textColor = UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1.0)
        uiLabel2.font = UIFont.systemFont(ofSize: 20.0)
        uiLabel2.center.x = uiView.center.x
        //uiLabel2.center.y = uiView.center.y
        uiView.addSubview(uiLabel2)
        
        
        view.addSubview(uiView)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: company, style: .plain, target: nil, action: nil)
        
        getData { [self] in
            var diff = Double(self.closePrice)! - Double(self.openPrice)!
            if diff > 0 {
                self.change = "increase"
                
            }else{
                self.change = "decrease"
                
            }
            self.constant = String(abs((diff/Double(self.openPrice)!) * 100).rounded(toPlaces: 2))
            
            uiLabel.text = "There was a " + self.constant + " percent " + self.change + " in the stocks for " + self.company + " in March 5th of 2021"
            
            SpeechService.shared.speak(text: "There was a " + self.constant + " percent " + self.change + " in the stocks for " + self.company + " in March 5th of 2021."){ [self] in
                
                sleep(3)
                SpeechService.shared.speak(text: "Would you like us to predict stock change of " + company + " for tomorrow?"){ [self] in
                    self.recordAudio()
                    let delayInSeconds = 2.0
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {

                        // here code perfomed with delay
                        self.stopAudio()
                        if self.speechText == "yes" || self.speechText == "Yes"{
                            moveToPredict2()
                        }
                    }
                    
                }

            }
            
            
            
            
        }
    }
    
    
    func moveToPredict2(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainTabC = storyboard.instantiateViewController(withIdentifier: "PredictViewController") as! PredictViewController
        mainTabC.company = company
        //self.isNavigationBarHidden = true
        //self.navigationBar.isTranslucent = false
        self.navigationController!.pushViewController(mainTabC, animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController!.isNavigationBarHidden = true
    }
    
    func getData(completionHandler:  @escaping () -> ()){
        let jsonUrlStringPrice = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=TSLA&outputsize=1&apikey="+"AIOG7263S8YMMVNI"
        AF.request(jsonUrlStringPrice, method: .get, parameters: nil)
            .responseData { (response) in
                switch response.result {
                case .success(let result):
                    
                    let overallData = try? JSONSerialization.jsonObject(with: response.data!, options: []) as? [String:AnyObject] as NSDictionary?
                    let usefulData = overallData!["Time Series (Daily)"] as! NSDictionary
                    var yes = Date.yesterday
                    var ddate = self.removeTimeStamp(fromDate: Date.yesterday)
                    while true{
                        if let val = usefulData[ddate]{
                            break
                        }
                        yes = yes.dayBefore
                        ddate = self.removeTimeStamp(fromDate: yes)
                        print(ddate)
                    }
                    let realD = usefulData[ddate] as! NSDictionary
                    self.openPrice = realD["1. open"] as! String
                    self.closePrice = realD["4. close"] as! String
                    print(self.openPrice)
                    print(self.closePrice)
                        
                    
                case .failure(let error):
                    print(error.localizedDescription, error)
                }
                completionHandler()
        }
    }
    
    
    func processSampleData(_ data: Data) {
        audioData.append(data)
            // We recommend sending samples in 100ms chunks
        let chunkSize : Int /* bytes/chunk */ = Int(0.1 /* seconds/chunk */
          * Double(SAMPLE_RATE) /* samples/second */
          * 2 /* bytes/sample */);

        if (audioData.length > chunkSize) {
          SpeechRecognitionService.sharedInstance.streamAudioData(audioData,
                                                                  completion:
            { [weak self] (response, error) in
                guard let strongSelf = self else {
                    return
                }
                
                if let error = error {
                    strongSelf.speechText = error.localizedDescription
                    print(error)
                } else if let response = response {
                    var finished = false
                    
                    for result in response.resultsArray! {
                        if let result = result as? StreamingRecognitionResult {
                            if result.isFinal {
                                finished = true
                            }
                        }
                    }
            
                    let tmpBestResult = (response.resultsArray.firstObject as! StreamingRecognitionResult)
                    let tmpBestAlternativeOfResult = tmpBestResult.alternativesArray.firstObject as! SpeechRecognitionAlternative
                    let bestTranscript = tmpBestAlternativeOfResult.transcript
                    strongSelf.speechText = bestTranscript!
                }
          })
          self.audioData = NSMutableData()
        }
          
    }
    
    func removeTimeStamp(fromDate: Date) -> String {
        let date = fromDate
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateFromString = date
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let datenew = dateFormatter.string(from: dateFromString)
        return datenew
    }
    
    func recordAudio() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
        } catch {

        }
        audioData = NSMutableData()
        _ = AudioController.sharedInstance.prepare(specifiedSampleRate: SAMPLE_RATE)
        SpeechRecognitionService.sharedInstance.sampleRate = SAMPLE_RATE
        _ = AudioController.sharedInstance.start()
      }
    
    func stopAudio() {
        _ = AudioController.sharedInstance.stop()
        SpeechRecognitionService.sharedInstance.stopStreaming()
        print(123)
        print(speechText)
      }
}
