//
//  PhotoViewController.swift
//  Favorite Place
//
//  Created by Lucas Damiani on 11/11/15.
//  Copyright © 2015 Lucas Damiani. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    private let numberOfPhotos = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPhotos()
    }
    
    private func setupPhotos() {
        for i in 1...numberOfPhotos {
            self.setupPhoto(i)
        }
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width * CGFloat(numberOfPhotos), self.view.frame.size.height)
    }
    
    private func setupPhoto(id: Int) {
        let xOrigin = CGFloat(CGFloat(id - 1) * self.view.frame.size.width)
        let frame = CGRectMake(xOrigin, 0, self.view.frame.size.width, self.view.frame.size.height);
        let image = UIImage(named: "image\(id).jpg")
        let imageView = ScrollableImageView(frame: frame, image: image)
        scrollView.addSubview(imageView)
        imageView.awakeFromNib()
    }
}
