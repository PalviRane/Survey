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
    @IBOutlet weak var paginationCollectionView: UICollectionView!
    @IBOutlet weak var takeSurveyButton: UIButton!
    
    //View Model
    let surveyViewModel: SurveyViewModel = SurveyViewModel()
    
    //Properties
    var pageCount = 0
    var isDataFetching = false
    var selectedSurveyIndex = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //set delegate
        surveyViewModel.delegate = self
        
        //Setup UI Components
        setupUIComponents()
        collectionViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //If no survey data is present, prepare UI for initial data load.
        if surveyViewModel.surveyList == nil
        {
            //Hide TakeSurveyButton initially
            takeSurveyButton(true)
            
            //Show loading view before performing data fetching
            showLoadingView()
            getSurveyData()
        }
    }
    
    
    //MARK: UI Setup
    
    func setupUIComponents()
    {
        //Setup Navigation bar
        setupNavigationBar(withTitle: surveyNavigationTitle)
        
        //Add refresh button to navigation bar
        let refreshButton = UIBarButtonItem.init(image:#imageLiteral(resourceName: "Refresh") , style: .plain, target: self, action: #selector(refreshData))
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = refreshButton
    }
    
    func collectionViewSetup()
    {
        //Register Collection View Cells
        
        surveyCollectionView.register(UINib.init(nibName: SurveyCollectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: SurveyCollectionViewCellIdentifier)
        
        paginationCollectionView.register(UINib.init(nibName: SurveyPaginationCollectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: SurveyPaginationCollectionViewCellIdentifier)
    }
    
    func takeSurveyButton(_ isHidden: Bool)
    {
        //Handle Visibility of survey button
        if isHidden
        {
            takeSurveyButton.isHidden = true
        }
        else
        {
            UIView.animate(withDuration: 0.3)
            {
                self.takeSurveyButton.isHidden = false
            }
        }
    }
    
    
    //MARK: API Call
    
    func getSurveyData()
    {
        surveyViewModel.getSurveyList(forPage: pageCount)
    }
    
    func fetchNextPageData()
    {
        isDataFetching = true
        pageCount += 1
        getSurveyData()
    }
    
    
    //MARK: Button Actions
    
    @objc func refreshData()
    {
        isDataFetching = true
        pageCount = 0
        selectedSurveyIndex = 0
        showLoadingView()
        //surveyViewModel.surveyList = nil
        
        getSurveyData()
    }
    
    @IBAction func takeSurveyButtonAction(_ sender: Any)
    {
        if let surveyDetailsViewController = SurveyDetailsViewController.getSurveyDetailsViewController(withSurvey: getCurrentSurvey())
        {
            navigationController?.pushViewController(surveyDetailsViewController, animated: true)
        }
        else
        {
            showToast(withToastMessage: redirectionError, dismissAfter: 2.0)
        }
    }
    
    
    //MARK: Miscellaneous
    
    func getCurrentSurvey() -> SurveyModel
    {
        let visibleRect = CGRect(origin: surveyCollectionView.contentOffset, size: surveyCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = surveyCollectionView.indexPathForItem(at: visiblePoint)
        
        if let surveyList = surveyViewModel.surveyList, let currentIndexPath = visibleIndexPath
        {
            let currentSurvey = surveyList[currentIndexPath.row]
            
            return currentSurvey
        }
        
        return SurveyModel.init(id: "", title: notApplicable, description: notApplicable, coverImageUrl: notApplicable)
    }
    
    func scrollSurveyCollectionView(toIndex index: Int = 0, scrollWithAnimation isAnimated: Bool = false)
    {
        surveyCollectionView.setContentOffset(CGPoint(x:  0, y: index * Int(surveyCollectionView.bounds.height)), animated: isAnimated)
    }
    
    func positionPaginationCollectionViewCellsToCenter()
    {
        view.layoutIfNeeded()
        paginationCollectionView.contentInset.top = max((paginationCollectionView.frame.height - paginationCollectionView.contentSize.height) / 4, 0)
    }
    
}

extension SurveyViewController: SurveyDelegate
{
    //MARK: SurveyDelegate Methods
    
    func reloadSurveyView(forPage pageNumber: Int)
    {
        surveyCollectionView.reloadData()
        paginationCollectionView.reloadData()
        
        if pageCount == 0
        {
            scrollSurveyCollectionView(toIndex: selectedSurveyIndex)
            
            //Show TakeSurveyButton after loading data
            takeSurveyButton(false)
        }
        
        if pageNumber == pageCount
        {
            dismissLoadingView()
        }
        
        positionPaginationCollectionViewCellsToCenter()
        
        isDataFetching = false
    }
    
    func showError(withMessage errorMessage: String)
    {
        dismissLoadingView()
        showToast(withToastMessage: errorMessage, dismissAfter: 5.0)
    }
}

