//
//  ViewController.swift
//  InfiniteScrollView
//
//  Created by Vincent on 03/12/2018.
//  Copyright © 2018 Kodappy. All rights reserved.
//

import UIKit
import EasyPeasy

class ViewController: UIViewController {
    
    var items = ["item 1", "item 2", "item 3", "item 4", "item 5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let lastItem = items.last, let firstItem = items.first else {
            return
        }
        items.insert(lastItem, at: 0)
        items.append(firstItem)
        
        print(items)
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.setContentOffset(CGPoint(x: 320, y: 0), animated: false)
    }
    
    // - UI Elements
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .red
        sv.bounces = false
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.clipsToBounds = true
        sv.contentInsetAdjustmentBehavior = .never
        sv.isPagingEnabled = true
        sv.delegate = self
        return sv
    }()
    
    lazy var pageControl: UIPageControl = {
        return UIPageControl()
    }()
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.easy.layout(Edges(), Width().like(self.view), Height().like(self.view))
        generateViews(forIndex: items.count)
        
        pageControl.numberOfPages = items.count - 2
        pageControl.currentPage = 0
        view.addSubview(pageControl)
        pageControl.easy.layout(Bottom(30), CenterX())
    }
    
    private func generateViews(forIndex index: Int) {
        var previous: UIView?
        let width = self.scrollView.frame.width
        let height = self.scrollView.frame.height

        for i in 0...index - 1 {
            let isLast = i == index - 1
            let label = UILabel()
            label.text = items[i]

            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            view.backgroundColor = .blue
            view.addSubview(label)
            label.easy.layout(CenterX(), CenterY())
            
            scrollView.addSubview(view)
            view.easy.layout(
                Top(),
                Bottom(),
                Left().to(previous ?? scrollView),
                Width().like(scrollView),
                Height().like(scrollView)
            )
            
            if isLast {
                view.easy.layout(Right())
            }
            
            previous = view
        }
    }

}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        if index == 0 {
            scrollView.scrollTo(horizontalPage: items.count - 2, animated: false)
            pageControl.currentPage = items.count - 3
        } else if index == items.count - 1 {
            scrollView.scrollTo(horizontalPage: 1, animated: false)
            pageControl.currentPage = 0
        } else {
            pageControl.currentPage = index - 1
        }
    }
    
}

