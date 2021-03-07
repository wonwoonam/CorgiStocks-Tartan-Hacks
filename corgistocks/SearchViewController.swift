//
//  SearchViewController.swift
//  corgistocks
//
//  Created by Won Woo Nam on 3/6/21.
//

import Foundation
import UIKit

class SearchView: UIView{
    
    
    let searchView: UITextField = {
        let searchV = UITextField()
        searchV.placeholder = "Search"
        return searchV
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    
    func setupViews(){
        addSubview(searchView)
        //searchView.centerInSuperview()
        //searchView.width(self.frame.width-40)
        searchView.frame = CGRect(x: 20, y: 0, width: self.frame.width-40, height: 35)
        //searchView.backgroundColor = .red
        //searchView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        //self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
