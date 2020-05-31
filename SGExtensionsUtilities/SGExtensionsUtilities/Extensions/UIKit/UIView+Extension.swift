//
//  UIView+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import UIKit

// MARK:- Variables
public extension UIView {
    
    private var dashedLine: String { return "_dashedLine_" }
    private var dashedBorder: String { return "_dashedBorder_" }
}

public extension UIView {
    
    // MARK:- Layout Constraints
    func addConstraint(height: CGFloat? = nil, width: CGFloat? = nil) {
        if let h = height {
            self.heightAnchor.constraint(equalToConstant: h).isActive = true
        }
        if let w = width {
            self.widthAnchor.constraint(equalToConstant: w).isActive = true
        }
    }
    
    func layoutConstraints(superView: UIView, topConstant: CGFloat? = nil, leadingConstant: CGFloat? = nil, bottomConstant: CGFloat? = nil, trailingConstant: CGFloat? = nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let topConstant = topConstant {
            self.topAnchor.constraint(equalTo: superView.topAnchor, constant: topConstant).isActive = true
        }
        if let leadingConstant = leadingConstant {
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: leadingConstant).isActive = true
        }
        if let bottomConstant = bottomConstant {
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottomConstant).isActive = true
        }
        if let trailingConstant = trailingConstant {
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -trailingConstant).isActive = true
        }
    }
    
    func layoutAllConstraints(parentView: UIView, topConstant: CGFloat = 0.0, bottomConstant: CGFloat = 0.0, leadingConstant: CGFloat = 0.0, trailingConstant: CGFloat = 0.0, constraintsToSuperView: Bool = true, viewController: UIViewController? = nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: leadingConstant).isActive = true
        self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: trailingConstant).isActive = true
        
        if constraintsToSuperView {
            self.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 0.0).isActive = true
            self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 0.0).isActive = true
        }
            
        else if let vc = viewController {
            self.topAnchor.constraint(equalTo: vc.topLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
            self.bottomAnchor.constraint(equalTo: vc.bottomLayoutGuide.topAnchor, constant: 0.0).isActive = true
        }
    }
    
    // MARK:- Gradient
    func gradientBackground(colors: [Any], startPoint: CGPoint? = CGPoint.zero, endPoint: CGPoint? = CGPoint(x: 1.0, y: 0.0)) {
        if let sublayers = self.layer.sublayers, sublayers.count > 1 {
            self.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        }
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = colors
        //gradient.locations = [0.0 , 1.0]
        if let startPoint = startPoint {
            gradient.startPoint = startPoint
        }
        if let endPoint = endPoint {
            gradient.endPoint = endPoint
        }
        gradient.frame.size = self.frame.size
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    // MARK:- Add - Remove views
    func addChildViewController(childViewController: UIViewController, parentViewController: UIViewController) {
        // Add Child View Controller
        parentViewController.addChild(childViewController)
        
        // Add Child View as Subview
        self.addSubview(childViewController.view)
        
        // Configure Child View
        childViewController.view.frame = self.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        childViewController.didMove(toParent: parentViewController)
    }
    
    func removeChildViewController(childViewController: UIViewController) {
        // Notify Child View Controller
        childViewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        childViewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        childViewController.removeFromParent()
    }
    
    func removeAllSubviewsWithTag(tag: Int) {
        for subview in self.subviews {
            if subview.tag == tag {
                subview.removeFromSuperview()
            }
        }
    }
}

// MARK:- Animation
public extension UIView {
    
    //func to perform spring animation on imageview
    func performWiggleAnimation() {
        let transformAnim  = CAKeyframeAnimation(keyPath:"transform")
        transformAnim.values  = [NSValue(caTransform3D: CATransform3DMakeRotation(0.5, 0.0, 0.0, 1)),
                                 NSValue(caTransform3D: CATransform3DMakeRotation(-0.5 , 0, 0, 1))]
        transformAnim.autoreverses = true
        transformAnim.duration  =  0.5
        transformAnim.repeatCount = 1
        //transformAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        layer.add(transformAnim, forKey: "transform")
    }
    
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 0.0
        }) { (completed) in
            self.isHidden = true
            completion(true)
        }
    }
    
    func fadeTransition(duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.moveIn
        animation.subtype = .fromTop
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.moveIn.rawValue)
    }
    
    enum Direction: Int {
        case topToBottom = 0
        case bottomToTop
        case leftToRight
        case rightToLeft
    }
    
    func startShimmeringAnimation(animationSpeed: Float = 1.4, direction: Direction = .leftToRight, repeatCount: Float = .infinity) {
        let lightColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1).cgColor
        let blackColor = UIColor.black.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [blackColor, lightColor, blackColor]
        gradientLayer.frame = CGRect(x: -self.bounds.size.width, y: -self.bounds.size.height, width: 3 * self.bounds.size.width, height: 3 * self.bounds.size.height)
        
        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }
        
        gradientLayer.locations =  [0.35, 0.50, 0.65]
        self.layer.mask = gradientLayer
        
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = CFTimeInterval(animationSpeed)
        animation.repeatCount = repeatCount
        CATransaction.setCompletionBlock { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.layer.mask = nil
        }
        gradientLayer.add(animation, forKey: "shimmerAnimation")
        CATransaction.commit()
    }
    
    func stopShimmeringAnimation() {
        self.layer.mask = nil
    }
    
    func rotate(toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(animation, forKey: nil)
    }
}

// MARK:- XIB NIB
public extension UIView {
    
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(nibName: nibNamed, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        if let nibName = type(of: self).description().components(separatedBy: ".").last {
            let nib = UINib(nibName: nibName, bundle: bundle)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        }
        return nil
    }
    
    func loadViewFromNibFile() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let views = nib.instantiate(withOwner: self, options: nil)
        guard views.count > 0, let view = views[0] as? UIView else { return UIView(frame: CGRect.zero) }
        return view
    }
    
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            // xib not loaded, or it's top view is of the wrong type
            return nil
        }
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        return contentView
    }
}

// MARK:- Shadow
public extension UIView {
    
    func dropShadow(color: UIColor = .black, viewCornerRadius: CGFloat? = nil, shadowFadeRadius: CGFloat = 0, shadowOffset: CGSize = CGSize.zero,  opacity: Float = 0.15) {
        self.layer.masksToBounds = false
        if let value = viewCornerRadius {
            self.layer.cornerRadius = value
        }
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowFadeRadius
        
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: self.layer.cornerRadius, height: 0.5)).cgPath
        self.layer.shouldRasterize = true
        
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func dropShadow(radius: CGFloat = 1.5, shadowOffset: CGSize = CGSize(width: 0, height: 0.5), shadowOpacity: Float = 0.2) {
        self.layer.cornerRadius = radius
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: 0.5)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func dropShadow(shadowOffset: CGSize = CGSize(width: 3.0, height: 2.0), shadowOpacity: Float = 0.7, shadowRadius: CGFloat = 3.0, shadowColor: UIColor, cornerRadius: CGFloat = 2.0) {
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.cornerRadius = cornerRadius
    }
    
    func removeShadow() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0
        self.layer.shadowRadius = 0
    }
}

// MARK:- Border
public extension UIView {
    
    // MARK:- Private
    @discardableResult private func getRoundedMask(corner: UIRectCorner, cornerRadius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }
    
    private func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
    
    // MARK:- Public
    func roundedCornerBorder(corner: UIRectCorner, cornerRadius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = getRoundedMask(corner: corner, cornerRadius: cornerRadius)
        addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
    }
    
    func removeBorder() {
        removeAllSubviewsWithTag(tag: 1001)
    }
    
    @discardableResult func addBorder(edges: UIRectEdge, color: UIColor = .black, thickness: CGFloat = 1.0) -> [UIView] {
        
        removeBorder()
        
        var borders = [UIView]()
        
        func border() -> UIView {
            let border = UIView(frame: CGRect.zero)
            border.tag = 1001
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            return border
        }
        
        if edges.contains(.top) || edges.contains(.all) {
            let top = border()
            addSubview(top)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[top(==thickness)]",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["top": top]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[top]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["top": top]))
            borders.append(top)
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            let left = border()
            addSubview(left)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[left(==thickness)]",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["left": left]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[left]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["left": left]))
            borders.append(left)
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            let right = border()
            addSubview(right)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:[right(==thickness)]-(0)-|",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["right": right]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[right]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["right": right]))
            borders.append(right)
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            let bottom = border()
            addSubview(bottom)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:[bottom(==thickness)]-(0)-|",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["bottom": bottom]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[bottom]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["bottom": bottom]))
            borders.append(bottom)
        }
        
        return borders
    }
    
    func addBorder(color: UIColor = UIColor.black, size: CGFloat = 1, cornerRadius: CGFloat = 0) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = size
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    func topBorder() {
        let border = CALayer()
        let borderWidth = CGFloat(0.5)
        border.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y: 0), size: CGSize(width: self.frame.size.width, height: 0.5))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func rightBorder(borderColor: UIColor, borderWidth: CGFloat) {
        let border = CALayer()
        border.backgroundColor = borderColor.cgColor
        border.frame = CGRect(x: self.frame.size.width - borderWidth,y: 0, width:borderWidth, height:self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func leftBorder(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:0, width:width, height:self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func bottomBorder(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:self.frame.size.height, width:self.frame.size.width, height:1)
        self.layer.addSublayer(border)
    }
    
    func bottomBorder(color: UIColor, width: CGFloat, padding : CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:padding, y:self.frame.size.height, width:(self.frame.size.width - 2*padding), height:1)
        self.layer.addSublayer(border)
    }
}

// MARK:- Corner
public extension UIView {
    
    func roundedView() {
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.size.width/2
    }
    
    func resetRoundedView() {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 0.0
    }
    
    func roundedCorner(corner: UIRectCorner, cornerRadius: CGFloat) {
        self.layoutIfNeeded()
        getRoundedMask(corner: corner, cornerRadius: cornerRadius)
        self.clipsToBounds = true
    }
    
    func roundedCorners(cornerRadius: CGFloat = 2, borderWidth: CGFloat = 0) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
    
    func removeRoundedCorners() {
        self.layer.cornerRadius = 0.0
        self.layer.borderWidth = 0
        self.clipsToBounds = true
    }
}

// MARK:- Dashed
public extension UIView {
    func addDashedLine(startPoint: CGPoint, endPoint: CGPoint, lineWidth: CGFloat = 1, cornerRadius: CGFloat = 0, dashPattern: [NSNumber]? = [3,2], color: UIColor = UIColor.black) {
        
        removeDashedLine()
        
        let lineLayer = CAShapeLayer()
        lineLayer.strokeColor = color.cgColor
        lineLayer.lineWidth = lineWidth
        lineLayer.lineDashPattern = dashPattern
        
        let path = CGMutablePath()
        path.addLines(between: [startPoint, endPoint])
        lineLayer.path = path
        
        self.layer.addSublayer(lineLayer)
    }
    
    func removeDashedLine() {
        layer.sublayers?.removeAll(where: { $0.name == dashedLine })
    }
    
    func addDashedBorder(frameWidth: CGFloat? = nil, frameHeight: CGFloat? = nil, borderWidth: CGFloat = 1, cornerRadius: CGFloat = 0, dashPattern: [NSNumber]? = [3,2], color: UIColor = UIColor.black, fillColor: UIColor = UIColor.clear) {
        
        removeDashedBorder()
        
        let width: CGFloat = frameWidth ?? frame.width
        let height: CGFloat = frameHeight ?? frame.height
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = dashedBorder
        
        let shapeRect = CGRect(x: 0, y: 0, width: width, height: height)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: width/2, y: height/2)
        
        shapeLayer.lineWidth = borderWidth
        shapeLayer.lineDashPattern = dashPattern
        
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: cornerRadius).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func removeDashedBorder() {
        layer.sublayers?.removeAll(where: { $0.name == dashedBorder })
    }
}
