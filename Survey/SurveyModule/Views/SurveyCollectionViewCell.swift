//
//  SurveyCollectionViewCell.swift
//  Survey
//
//  Created by Aakash Kumbhar on 24/06/20.
//  Copyright © 2020 Palvi. All rights reserved.
//

import UIKit
import AlamofireImage

class SurveyCollectionViewCell: UICollectionViewCell
{
    //UI Elements
    @IBOutlet weak var surveyNameLabel: UILabel!
    @IBOutlet weak var surveyDescriptionLabel: UILabel!
    @IBOutlet weak var surveyImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupSurveyCell(withSurvey survey: SurveyModel)
    {
        surveyNameLabel.text = survey.title ?? notApplicable
        surveyDescriptionLabel.text = survey.description ?? ""
        
        if let image = survey.coverImageUrl, let imageUrl = URL.init(string: image.trimmingCharacters(in: .whitespacesAndNewlines))
        {
            //Get low quality Image From Url
            surveyImageView.af_setImage(withURL: imageUrl) { (imageResponse) in
                
                //After the low quality image has downloaded successfully, get high def image
                let highDefUrl = image + hdImageAppendString
                
                if let hdImageUrl = URL.init(string: highDefUrl.trimmingCharacters(in: .whitespacesAndNewlines))
                {
                    let placeHolderImage = imageResponse.result.value
                    
                    self.surveyImageView.af_setImage(withURL: hdImageUrl, placeholderImage: placeHolderImage)
                    { hdResponse in
                        
                        if let hdImage = hdResponse.result.value
                        {
                            //When we get high resolution image, replace it in cache
                            self.replaceImageInCache(forUrl: imageUrl, withHDImage: hdImage)
                        }
                    }
                }
            }
        }
    }
    
    func replaceImageInCache(forUrl url: URL, withHDImage image: Image)
    {
        //let URLRequest = url
        
        let imageDownloader = UIImageView.af_sharedImageDownloader
        
        // Update image in cache
        imageDownloader.imageCache?.add(image, for: URLRequest.init(url: url), withIdentifier: "")
    }
    
}
