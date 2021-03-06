//
//  DismissAnimator.swift
//  TimeStamp
//
//  Created by Jacky He on 2019-10-11.
//  Copyright © 2019 Baker Jackson. All rights reserved.
//

import UIKit

class PresentAnimator: NSObject {
    let screenWidth = UIScreen.main.bounds.width;
    let screenHeight = UIScreen.main.bounds.height;
}

extension PresentAnimator: UIViewControllerAnimatedTransitioning {
        
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
            else {return}
        
        let greyView = UIView (frame: CGRect(x: 0, y: 0, width: self.screenWidth, height: self.screenHeight));
        greyView.backgroundColor = UIColor(white: 0, alpha: 0.35);
        greyView.layer.opacity = 0;
        
        containerView.insertSubview(greyView, aboveSubview: fromVC.view);
        containerView.insertSubview(toVC.view, aboveSubview: greyView);
        
        fromVC.view.dropShadow();
        fromVC.view.frame = CGRect (x: 0, y: 0, width: self.screenWidth, height: self.screenHeight);
        
        toVC.view.frame = CGRect (x: self.screenWidth, y: 0, width: self.screenWidth, height: self.screenHeight);

        UIView.animate(withDuration: 0.3, animations: {
            fromVC.view.frame = CGRect (x: -self.screenWidth/3, y: 0, width: self.screenWidth, height: self.screenHeight)
            toVC.view.frame = CGRect (x: 0, y: 0, width: self.screenWidth, height: self.screenHeight);
            greyView.layer.opacity = 1;
        }) { (Finished) in
            if (Finished)
            {
                greyView.removeFromSuperview();
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled);
            }
        }
    }
}
