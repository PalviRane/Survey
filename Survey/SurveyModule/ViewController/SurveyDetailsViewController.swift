//
//  SurveyDetailsViewController.swift
//  Survey
//
//  Created by Aakash Kumbhar on 24/06/20.
//  Copyright © 2020 Palvi. All rights reserved.
//

import UIKit

class SurveyDetailsViewController: BaseViewController
{
    var surveyName = "Survey Name"
    static let storyboardIdentifier = "SurveyDetailsViewController"

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(withTitle: surveyName)
    }
    
    //MARK: Initialization for redirection
    static func  getSurveyDetailsViewController(withSurveyName currentSurveyName:String) -> SurveyDetailsViewController?
    {
        let storyBoard = UIStoryboard(name: "Survey", bundle: nil)
        
        guard let surveyDetailsViewController = storyBoard.instantiateViewController(withIdentifier: SurveyDetailsViewController.storyboardIdentifier) as? SurveyDetailsViewController else { return  nil}
        
        surveyDetailsViewController.surveyName = currentSurveyName
        
        return surveyDetailsViewController
    }

}
