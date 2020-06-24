//
//  SurveyViewController.swift
//  Survey
//
//  Created by Palvi on 22/06/20.
//  Copyright © 2020 Palvi. All rights reserved.
//

import UIKit

class SurveyViewController: BaseViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        self.setupUIComponents()
    }
    
    //MARK: UI Setup
    
    func setupUIComponents()
    {
        self.setupNavigationBar(withTitle: "Survey")
        
        //Add refresh button to navigation bar
        let newBtn = UIBarButtonItem.init(image: UIImage.init(named: "Refresh"), style: .plain, target: self, action: #selector(reloadData))
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItem = newBtn
    }
    
    //MARK: Button Actions
    
    @objc func reloadData()
    {
        
    }

}

