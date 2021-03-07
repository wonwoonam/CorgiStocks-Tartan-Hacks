//
//  Navigation Controller.swift
//  corgistocks
//
//  Created by Won Woo Nam on 3/6/21.
//

import Foundation
import UIKit

class InitNavigationController: UINavigationController{
   
    
    
    override func viewDidLoad() {
 
       
        
        //self.navigationBar.backIndicatorImage = UIImage(named: "backButtonIcon")
        //self.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButtonIcon")
        //self.navigationBar.tintColor = .black
    
        //print(defaults.string(forKey: "user_id"))
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainTabC = storyboard.instantiateViewController(withIdentifier: "InitViewController") as! InitViewController
        self.isNavigationBarHidden = true
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = UIColor.black
        self.pushViewController(mainTabC, animated: true)
        
    }
}
