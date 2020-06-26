//
//  BaseViewController.swift
//  Survey
//
//  Created by Aakash Kumbhar on 23/06/20.
//  Copyright © 2020 Palvi. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController
{
    var loadingAlertView =  UIAlertController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func showToast(withToastMessage message : String,dismissAfter seconds: Double)
    {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        
        if presentedViewController == nil
        {
             self.present(alert, animated: true, completion: nil)
        }
        else
        {
            self.dismiss(animated: false) { () -> Void in
                   self.present(alert, animated: true, completion: nil)
              }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds)
        {
            alert.dismiss(animated: true)
        }
    }
    
    func showLoadingView()
    {
        loadingAlertView = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        loadingAlertView.view.addSubview(loadingIndicator)
        if presentedViewController == nil
        {
             self.present(loadingAlertView, animated: true, completion: nil)
        }
        else
        {
            self.dismiss(animated: false) { () -> Void in
                self.present(self.loadingAlertView, animated: true, completion: nil)
              }
        }
    }
    
    func dismissLoadingView()
    {
        loadingAlertView.dismiss(animated: false, completion: nil)
    }
    
    func setupNavigationBar(withTitle titleString: String)
    {
        self.navigationItem.title = titleString
        navigationController?.navigationBar.barStyle = .black
    }
}
