//
//  ScrollableImageView.swift
//  Favorite Place
//
//  Created by Lucas Damiani on 12/11/15.
//  Copyright © 2015 Lucas Damiani. All rights reserved.
//

import UIKit

@IBDesignable
class ScrollableImageView: UIScrollView, UIScrollViewDelegate {

    private var imageView = UIImageView()
    private var zoomScaleReady = false
    @IBInspectable var image: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, image: UIImage?) {
        self.init(frame: frame)
        self.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.delegate = self
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        self.addGestureRecognizer(doubleTapRecognizer)

        self.addSubview(imageView)        
        resetImageView()
    }
    
    override func layoutSubviews() {
        if zoomScaleReady || image == nil {
            return
        }
        
        // We need to calculate the zoom scale in the first call to layoutSubviews, to have the correct measures for frame and bounds.
        let screenWidth = self.frame.size.width
        let scaleWidth = screenWidth / self.contentSize.width
        let screenHeight = self.frame.size.height
        let scaleHeight = screenHeight / self.contentSize.height
        let minScale = min(scaleWidth, scaleHeight);
        self.minimumZoomScale = minScale;
    
        self.maximumZoomScale = 2.0
        self.zoomScale = minScale;
        
        centerScrollViewContents()
        zoomScaleReady = true
    }
    
    func resetImageView() {
        guard let scrollableImage = image else {
            return
        }
        
        imageView.image = scrollableImage
        imageView.frame = CGRect(origin: CGPointMake(0, 0), size: scrollableImage.size)
        imageView.contentMode = .ScaleAspectFit
        
        self.contentSize = scrollableImage.size
        zoomScaleReady = false
    }
    
    func centerScrollViewContents() {
        let boundsSize = self.bounds.size
        var contentsFrame = imageView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        imageView.frame = contentsFrame
    }
    
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        // 1
        let pointInView = recognizer.locationInView(imageView)
        
        // 2
        var newZoomScale = self.zoomScale * 1.5
        newZoomScale = min(newZoomScale, self.maximumZoomScale)
        
        // 3
        let scrollViewSize = self.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRectMake(x, y, w, h);
        
        // 4
        self.zoomToRect(rectToZoomTo, animated: true)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    }

}
