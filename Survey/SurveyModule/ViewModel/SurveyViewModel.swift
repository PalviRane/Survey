//
//  SurveyViewModel.swift
//  Survey
//
//  Created by Palvi on 22/06/20.
//  Copyright © 2020 Palvi. All rights reserved.
//

import Foundation

protocol SurveyDelegate
{
    func reloadSurveyView(forPage pageNumber: Int)
    func showError(withMessage errorMessage: String)
}

extension SurveyDelegate
{
    func reloadSurveyView(forPage pageNumber: Int) {}
    func showError(withMessage errorMessage: String) {}
}

class SurveyViewModel: NSObject
{
    //Properties
    var surveyList: [SurveyModel]?
    var delegate : SurveyDelegate?
    var authenticationTokenViewModel: AuthenticationTokenViewModel = AuthenticationTokenViewModel()
    
    
    func getSurveyList(forPage pageNumber: Int, perPageItemCount count: Int = 10)
    {
        if !NetworkManager.isConnectedToInternet
        {
            //Show internet connectivity issue toast
            delegate?.showError(withMessage: networkErrorMessage)
            
            return
        }
        
        let urlString = WebServiceUrls().baseURL+WebServiceUrls().getSurvey
        
        let requestDictionary = [ "page": pageNumber, "per_page": count ] as Dictionary<String, AnyObject>
        
        //Fetch survey data
        WebserviceHandler().get(url: urlString, parameter: requestDictionary) { (flag, responseData) in
            DispatchQueue.main.async(execute:
                {
                    self.mapToSurveyListResult(response: responseData.data, success: flag, forPage: pageNumber, urlResponse: responseData.response)
            })
        }
    }
    
    func mapToSurveyListResult(response: Data?, success:Bool, forPage pageNumber: Int, urlResponse: HTTPURLResponse?)
    {
        if success
        {
            guard let response = response else {return}
            do{
                //If current page is 0, we need to replace fresh data
                if pageNumber == 0
                {
                    surveyList = try JSONDecoder().decode([SurveyModel].self, from: response)
                }
                else if let surveyArray = self.surveyList, surveyArray.count > 0
                {
                    //Else append new data ro existing array
                    let newSurveyList = try JSONDecoder().decode([SurveyModel].self, from: response)
                    surveyList = surveyArray + newSurveyList
                }
                
                self.delegate?.reloadSurveyView(forPage: pageNumber)
                
                
            }catch let jsonError
            {
                print(jsonError)
                //self.delegate?.showError(withMessage: "jsonError")
            }
        }
        else
        {
            //If error code is 401, fetch auth token
            if let response = urlResponse, response.statusCode == 401
            {
                authenticationTokenViewModel.getAuthenticationToken(onSuccess:
                    {
                        //After receiving token, recall survey list method
                        self.getSurveyList(forPage: pageNumber)
                }) {
                    self.delegate?.showError(withMessage: authenticationError)
                }
            }
            else
            {
                self.delegate?.showError(withMessage: commanError)
            }
        }
    }
}

