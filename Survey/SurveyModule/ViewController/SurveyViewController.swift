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
    //UI Components
    @IBOutlet weak var surveyCollectionView: UICollectionView!
    
    //View Model
    
    
    //Properties
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
         self.collectionViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.setupUIComponents()
    }
    
     override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
     {
        self.surveyCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    //MARK: UI Setup
    
    func setupUIComponents()
    {
        self.setupNavigationBar(withTitle: surveyNavigationTitle)
        
        //Add refresh button to navigation bar
        let newBtn = UIBarButtonItem.init(image:#imageLiteral(resourceName: "Refresh") , style: .plain, target: self, action: #selector(reloadData))
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItem = newBtn
    }
    
    func collectionViewSetup()
    {
        self.surveyCollectionView.register(UINib.init(nibName: "SurveyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SurveyCollectionViewCell")
    }
    
    //MARK: Button Actions
    
    @objc func reloadData()
    {
        showToast(withToastMessage: "Reload Success", dismissAfter: 3.0)
    }

}

