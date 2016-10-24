//
//  ViewScroll.swift
//  MotorShop
//
//  Created by iOS Student on 10/20/16.
//  Copyright © 2016 Duong. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var frontScrollView: [UIScrollView] = []
    var pageImages: [String] = []
    var pageViews: [UIImageView?] = []
    var currentImgView = 0
    var first = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageController.currentPage = currentImgView
        pageController.numberOfPages = pageImages.count
        
        
        scrollView.isPagingEnabled = true
    }

    //Chay phuong thuc nay set vi tri frame cua scrollview cho dung
    //Moi lan thay doi layout thi no se goi phuong thuc nay nen can bien first de chay 1 lan duy nhat
    override func viewDidLayoutSubviews() {
        if (!first) {
            first = true
            
            let pagesScrollViewSize = scrollView.frame.size
            scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count), height: 0)
            
            for i in 0 ..< pageImages.count
            {
                let imgView = UIImageView(image: UIImage(named:pageImages[i]+".jpg"))
                imgView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
                imgView.contentMode = .scaleAspectFit
                imgView.isUserInteractionEnabled = true
                imgView.isMultipleTouchEnabled = true
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapImg(_:)))
                tap.numberOfTapsRequired = 1
                imgView.addGestureRecognizer(tap)
                let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTabImg(_:)))
                doubleTap.numberOfTapsRequired = 2
                imgView.addGestureRecognizer(doubleTap)
                tap.require(toFail: doubleTap)
                pageViews.append(imgView)
                
                
                let frontScrollView1 = UIScrollView(frame: CGRect( x: CGFloat(i) * scrollView.frame.size.width, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
                
                frontScrollView1.minimumZoomScale = 1
                frontScrollView1.maximumZoomScale = 2
                
                frontScrollView1.delegate = self
                
                frontScrollView1.contentSize = imgView.bounds.size
                frontScrollView1.addSubview(imgView)
                frontScrollView.append(frontScrollView1)
                self.scrollView.addSubview(frontScrollView1)
            }
            scrollView.contentOffset = CGPoint(x: CGFloat(currentImgView) * scrollView.frame.size.width, y: 0)
        }
    }
    
    func tapImg(_ gesture: UITapGestureRecognizer)
    {
        let position = gesture.location(in: pageViews[pageController.currentPage])
        zoomRectForScale(scrollView.zoomScale * 1.5, center: position)
    }
    func doubleTabImg(_ gesture: UITapGestureRecognizer)
    {
        let position = gesture.location(in: pageViews[pageController.currentPage])
        zoomRectForScale(scrollView.zoomScale * 0.5, center: position)
    }
    func zoomRectForScale(_ scale: CGFloat, center: CGPoint)
    {
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        frontScrollView[pageController.currentPage].zoom(to: zoomRect, animated: true)
    }
  
    //Zoom tai vi tri anh hien tai
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return pageViews[pageController.currentPage]
    }

    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      
        let page = Int((self.scrollView.contentOffset.x ) / self.scrollView.frame.size.width )
        
        if (pageController.currentPage != page)
        {
            frontScrollView[pageController.currentPage].zoomScale = 1
            pageController.currentPage = page
        }
    }


    @IBAction func onChange(_ sender: AnyObject) {
    scrollView.contentOffset = CGPoint(x: CGFloat(pageController.currentPage)*scrollView.frame.size.width, y: 0)
    }
    
    
}
