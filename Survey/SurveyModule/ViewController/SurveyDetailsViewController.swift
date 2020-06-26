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
    var currentSurvey: SurveyModel?
    static let storyboardIdentifier = "SurveyDetailsViewController"

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if let survey = currentSurvey, let surveyTitle = survey.title
        {
            setupNavigationBar(withTitle: surveyTitle)
        }
    }
    
    
    //MARK: Initialization for redirection
    
    static func  getSurveyDetailsViewController(withSurvey survey: SurveyModel) -> SurveyDetailsViewController?
    {
        //Getting SurveyDetailsViewController instance.
        let storyBoard = UIStoryboard(name: SurveyStoryboard, bundle: nil)
        
        guard let surveyDetailsViewController = storyBoard.instantiateViewController(withIdentifier: SurveyDetailsViewController.storyboardIdentifier) as? SurveyDetailsViewController else { return  nil}
        
        surveyDetailsViewController.currentSurvey = survey
        
        return surveyDetailsViewController
    }

}
