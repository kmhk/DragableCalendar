//
//  EventMenuView.swift
//  DragableCalendar
//
//  Created by com on 8/9/20.
//  Copyright © 2020 com. All rights reserved.
//

import UIKit


var _sharedMenu: EventMenuView?


class EventMenuView: UIView {
    
    var parentVC: UIViewController?
    
    var viewMenu: UIView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func initView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        viewMenu = UIView(frame: CGRect(x: 0, y: frame.maxY, width: frame.width, height: frame.height / 2))
        viewMenu!.backgroundColor = UIColor.white
        addSubview(viewMenu!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapView(_:)))
        tapGesture.delegate = self
        addGestureRecognizer(tapGesture)
    }
    
    
    func showMenu() {
        UIView.animate(withDuration: 0.2) {
            self.viewMenu!.frame = CGRect(x: 0, y: self.frame.height / 2, width: self.frame.width, height: self.frame.height / 2)
        }
    }
    
    
    func hideMenu() {
        UIView.animate(withDuration: 0.2, animations: {
            self.viewMenu!.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: self.frame.height / 2)
        }) { (flag) in
            self.removeFromSuperview()
            _sharedMenu = nil
        }
    }
    
    
    // MARK: action
    
    @objc func onTapView(_ gesture: UITapGestureRecognizer) {
        hideMenu()
    }
    
    
    // MARK: static method
    
    static func show(_ vc: UIViewController) {
        if let mnu = _sharedMenu {
            mnu.hideMenu();
            return
        }
        
        _sharedMenu = EventMenuView(frame: vc.view.bounds)
        vc.view.addSubview(_sharedMenu!)
        _sharedMenu!.showMenu()
    }

}


// MARK: - Gesture delegate

extension EventMenuView: UIGestureRecognizerDelegate {
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let gesture = gestureRecognizer as? UITapGestureRecognizer {
            let pt = gesture.location(in: self)
            return (viewMenu!.frame.contains(pt) == false)
        }
        
        return true
    }
}
