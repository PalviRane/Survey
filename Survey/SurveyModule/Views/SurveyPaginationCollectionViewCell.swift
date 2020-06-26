//
//  SurveyPaginationCollectionViewCell.swift
//  Survey
//
//  Created by Aakash Kumbhar on 24/06/20.
//  Copyright © 2020 Palvi. All rights reserved.
//

import UIKit

class SurveyPaginationCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var pageImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupPaginationCell(isSelectedCell isSelected: Bool)
    {
        if isSelected
        {
            pageImageView.image = UIImage.init(named: filledCircleImage)
        }
        else
        {
            pageImageView.image = UIImage.init(named: emptyCircleImage)
        }
    }

}
