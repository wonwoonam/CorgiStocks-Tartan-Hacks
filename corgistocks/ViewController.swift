//
//  ViewController.swift
//  corgistocks
//
//  Created by Won Woo Nam on 3/6/21.
//

import UIKit
import Alamofire
import AVFoundation
import googleapis

let SAMPLE_RATE = 16000

class InitViewController: UIViewController, UITextFieldDelegate, AudioControllerDelegate {
    var audioData: NSMutableData!
    var searchV : SearchView?
    var companyName = ""
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    var speechText = ""
    var numberOfChoice = 0
    
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController!.isNavigationBarHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: companyName, style: .plain, target: nil, action: nil)
        //let backItem = UIBarButtonItem()
        //backItem.title = companyName
        //self.navigationController?.navigationItem.backBarButtonItem = backItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        searchV = SearchView(frame: CGRect(x: 30, y:50, width: view.frame.width-60, height: 35))
        view.addSubview(searchV!)
        //searchV?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchV?.backgroundColor = .white
        searchV?.layer.cornerRadius = 15
        searchV?.layer.shadowOpacity = 0.2
        searchV?.layer.shadowRadius = 2
        searchV?.layer.shadowOffset = CGSize(width: 0, height: 2)

        searchV?.searchView.delegate = self
        searchV?.searchView.clearButtonMode = .whileEditing
        
        AudioController.sharedInstance.delegate = self
        
        let initLabel = setupLabel()
        view.addSubview(initLabel)
        
        SpeechService.shared.speak(text: "Hello, this is corgi-stocks. Which stocks would you like us to analyze today?"){ [self] in
            
            
            self.recordAudio()
            let delayInSeconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {

                // here code perfomed with delay
                self.stopAudio()
                self.searchV?.searchView.text = self.speechText
                textFieldShouldReturn(self.searchV!.searchView)
                self.speakChoices()
            }
           
            
        }

        
    }
    
    func speakChoices(){
        SpeechService.shared.speak(text: "Say 1 if you want to find out about yesterday's stock change. And 2 if you want us to predict tomorrow's change in stock for " + speechText){ [self] in
            
            self.recordAudio()
            let delayInSeconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {

                // here code perfomed with delay
                self.stopAudio()
                
                if self.speechText == "1" || self.speechText == "one"{
                    self.moveToPredict1()
                }else{
                    self.moveToPredict2()
                }
            }
            
            
            
        }
    }
    
    func processSampleData(_ data: Data) -> Void {
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
    
    
    func setupLabel() -> UILabel{
        let introLabel = UILabel(frame: CGRect(x: view.frame.width/2, y: view.frame.height/2 - 50, width: 200, height: 100))
        introLabel.center = view.center
        introLabel.numberOfLines = 2
        introLabel.textAlignment = .center
        introLabel.text = "Which company do you want us to analyze?"
        introLabel.textColor = UIColor(red: 159/255, green: 159/255, blue: 159/255, alpha: 1.0)
        return introLabel
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
        if textField.text != ""{
            companyName = textField.text!
            
            for eachView in view.subviews{
                if eachView.isKind(of: UILabel.self){
                    eachView.removeFromSuperview()
                }
            }
            displayPredictChoices()
        }else{
            let initLabel = setupLabel()
            view.addSubview(initLabel)
        }
        self.view.endEditing(true)
        //displayPredictChoices()
        return true
    }
    
    func displayPredictChoices(){
        let predictionChoices = UILabel()
        predictionChoices.text = "Prediction Choices"
        predictionChoices.textColor = UIColor(red: 167/255, green: 167/255, blue: 167/255, alpha: 1.0)
        predictionChoices.frame = CGRect(x: 0, y: 120, width: 150, height: 50)
        predictionChoices.center.x = view.center.x
        view.addSubview(predictionChoices)
        
        
        
        let firstPredictCh = UIButton()
        firstPredictCh.addTarget(self, action: #selector(choiceOnePressed(_:)), for: .touchUpInside)
        firstPredictCh.frame = CGRect(x:30, y: 200, width: view.frame.width-60, height: 120)
        firstPredictCh.backgroundColor = .white
        firstPredictCh.layer.cornerRadius = 15
        firstPredictCh.layer.shadowOpacity = 0.2
        firstPredictCh.layer.shadowRadius = 2
        firstPredictCh.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        let firstLabel = UILabel(frame: CGRect(x: 20, y: 10, width: firstPredictCh.frame.width-40, height: 50))
        firstLabel.text = "Past Dataset"
        firstLabel.textColor = UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1.0)
        firstLabel.font = UIFont.systemFont(ofSize: 20.0)
        firstPredictCh.addSubview(firstLabel)
        
        let secondLabel = UILabel(frame: CGRect(x: 20, y: 50, width: firstPredictCh.frame.width-40, height: 50))
        secondLabel.text = "We offer the latest dataset that you need to predict the ongoing change of stocks."
        secondLabel.textColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1.0)
        secondLabel.numberOfLines = 3
        secondLabel.font = UIFont.systemFont(ofSize: 13.0)
        firstPredictCh.addSubview(secondLabel)
        
        view.addSubview(firstPredictCh)
        

        
        let secondPredictCh = UIButton()
        secondPredictCh.addTarget(self, action: #selector(choiceTwoPressed(_:)), for: .touchUpInside)
        secondPredictCh.frame = CGRect(x: 30, y: 350, width: view.frame.width-60, height: 120)
        secondPredictCh.backgroundColor = .white
        secondPredictCh.layer.cornerRadius = 15
        secondPredictCh.layer.shadowOpacity = 0.2
        secondPredictCh.layer.shadowRadius = 2
        secondPredictCh.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        let thirdLabel = UILabel(frame: CGRect(x: 20, y: 10, width: firstPredictCh.frame.width-40, height: 50))
        thirdLabel.text = "News-based Prediction"
        thirdLabel.textColor = UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1.0)
        thirdLabel.font = UIFont.systemFont(ofSize: 20.0)
        secondPredictCh.addSubview(thirdLabel)
        
        let fourthLabel = UILabel(frame: CGRect(x: 20, y: 50, width: firstPredictCh.frame.width-40, height: 50))
        fourthLabel.text = "We analyze hundreds of articles to predict increase and fall of the stock."
        fourthLabel.textColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1.0)
        fourthLabel.numberOfLines = 3
        fourthLabel.font = UIFont.systemFont(ofSize: 13.0)
        secondPredictCh.addSubview(fourthLabel)
        
        
        view.addSubview(secondPredictCh)
        
        
    }
    
    @objc func choiceOnePressed(_ sender: UIButton!) {
        moveToPredict1()
    }
    @objc func choiceTwoPressed(_ sender: UIButton!) {
        moveToPredict2()
      
      
    }
    
    
    func moveToPredict2(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainTabC = storyboard.instantiateViewController(withIdentifier: "PredictViewController") as! PredictViewController
        mainTabC.company = companyName
        //self.isNavigationBarHidden = true
        //self.navigationBar.isTranslucent = false
        self.navigationController!.pushViewController(mainTabC, animated: true)
        
    }
    
    func moveToPredict1(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainTabC = storyboard.instantiateViewController(withIdentifier: "YesterdaysMarket") as! YesterdaysMarketController
        mainTabC.company = companyName
        //self.isNavigationBarHidden = true
        //self.navigationBar.isTranslucent = false
        self.navigationController!.pushViewController(mainTabC, animated: true)
        
    }
    
    
    


}

