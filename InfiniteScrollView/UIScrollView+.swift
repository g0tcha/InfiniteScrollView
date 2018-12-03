//
//  UIScrollView+.swift
//  InfiniteScrollView
//
//  Created by Vincent on 03/12/2018.
//  Copyright © 2018 Kodappy. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func scrollTo(horizontalPage: Int? = 0, verticalPage: Int? = 0, animated: Bool? = true) {
        var frame: CGRect = self.bounds
        frame.origin.x = frame.size.width * CGFloat(horizontalPage ?? 0)
        frame.origin.y = frame.size.width * CGFloat(verticalPage ?? 0)
        self.scrollRectToVisible(frame, animated: animated ?? true)
    }
    
}
