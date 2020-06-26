//
//  SurveyViewController+CollectionView.swift
//  Survey
//
//  Created by Aakash Kumbhar on 24/06/20.
//  Copyright © 2020 Palvi. All rights reserved.
//

import UIKit

extension SurveyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if let surveyList = surveyViewModel.surveyList, surveyList.count > 0
        {
            return surveyList.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == surveyCollectionView
        {
            //If surveyCollection view, load SurveyCollectionViewCell with survey list item
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SurveyCollectionViewCellIdentifier, for: indexPath) as! SurveyCollectionViewCell
            
            if let surveyList = surveyViewModel.surveyList
            {
                let currentSurvey = surveyList[indexPath.row]
                
                cell.setupSurveyCell(withSurvey: currentSurvey)
                
                if indexPath.row >= surveyList.count - 5 && isDataFetching == false
                {
                    fetchNextPageData()
                }
            }
            
            return cell
        }
        else
        {
            //If paginationCollectionView, load SurveyPaginationCollectionViewCell and align the select index to center
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SurveyPaginationCollectionViewCellIdentifier, for: indexPath) as! SurveyPaginationCollectionViewCell
            
            if indexPath.row == selectedSurveyIndex
            {
                collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
                cell.setupPaginationCell(isSelectedCell: true)
            }
            else
            {
                cell.setupPaginationCell(isSelectedCell: false)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        // Handle survey selection on corresponding page selection
        if collectionView == paginationCollectionView
        {
            //Update selected index
            selectedSurveyIndex = indexPath.row
            
            collectionView.reloadData()
            
            scrollSurveyCollectionView(toIndex: indexPath.row, scrollWithAnimation: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == surveyCollectionView
        {
            //Set SurveyCollectionViewCell size to view frame
            let collectionViewWidth = view.bounds.width
            
            let collectionViewHeight = surveyCollectionView.bounds.height
            
            return CGSize(width: collectionViewWidth, height: collectionViewHeight)
        }
        else
        {
            //Set SurveyPaginationCollectionViewCell size
            return CGSize(width: 15.0, height: 15.0)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        //When scrolling stops in collection view, get indexpath of visible cell and set that as selectedSurveyIndex
        let visibleRect = CGRect(origin: surveyCollectionView.contentOffset, size: surveyCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = surveyCollectionView.indexPathForItem(at: visiblePoint)
        
        selectedSurveyIndex = visibleIndexPath?.row ?? 0
        
        paginationCollectionView.reloadData()
    }
    
}
