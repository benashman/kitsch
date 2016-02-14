//
//  Helper.swift
//  Kitsch
//
//  Created by Ben Ashman on 2/13/16.
//  Copyright © 2016 Ben Ashman. All rights reserved.
//

import Foundation
import UIKit

func CGAffineTransformMakeDegreeRotation(rotation: CGFloat) -> CGAffineTransform {
    return CGAffineTransformMakeRotation(rotation * CGFloat(M_PI / 180))
}

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

func setLightStatusBar() {
    UIApplication.sharedApplication().statusBarStyle = .LightContent
}

func showNetworkActivityIndicator() {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
}

func hideNetworkActivityIndicator() {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
}

func convertValue(value: CGFloat, r1Min: CGFloat, r1Max: CGFloat, r2Min: CGFloat, r2Max: CGFloat) -> CGFloat {
    var ratio = (r2Max - r2Min) / (r1Max - r1Min)
    return value * ratio + r2Min - r1Min * ratio
}

