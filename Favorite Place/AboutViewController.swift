//
//  AboutViewController.swift
//  Favorite Place
//
//  Created by Lucas Damiani on 13/11/15.
//  Copyright © 2015 Lucas Damiani. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: stackView.frame.width, height: stackView.frame.height)    }

}
