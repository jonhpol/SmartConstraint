//
//  SmartConstraint.swift
//  SmartConstraint
//
//  Created by João Paulo de Oliveira Sabino on 02/06/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

public class SmartConstraint {
    /// Item to be anchored, can be a UIView or a UILayoutGuide
    unowned var item: AnyObject
    
    /// All constraints setted to item
    var constraints: [NSLayoutConstraint] = []
    
    /// Init with View
    init(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.item = view
    }
    
    /// Init with Layout Guide
    init(layoutGuide: UILayoutGuide) {
        self.item = layoutGuide
    }
    
    /// Activate all constraints setted in constraints array
    static public func activate(_ constraints: SmartConstraint ...) {
        constraints.forEach {
            if let view = $0.item as? UIView {
                view.translatesAutoresizingMaskIntoConstraints = false
            }
            NSLayoutConstraint.activate($0.constraints)
        }
        
    }
}

public extension UIView {
    var anchor: SmartConstraint {
        return SmartConstraint(view: self)
    }
    
}

extension SmartConstraint {
    
    @discardableResult
    public func top(_ anchor: NSLayoutYAxisAnchor, padding: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal) -> SmartConstraint {
        layoutAnchor(item.topAnchor, toAnchor: anchor, relation: relation, padding: padding)
        return self
    }
    
    @discardableResult
    public func bottom(_ anchor: NSLayoutYAxisAnchor, padding: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal) -> SmartConstraint {
        layoutAnchor(item.bottomAnchor, toAnchor: anchor, relation: relation, padding: -padding)
        return self
    }
    
    @discardableResult
    public func left(_ anchor: NSLayoutXAxisAnchor, padding: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal) -> SmartConstraint {
        layoutAnchor(item.leftAnchor, toAnchor: anchor, relation: relation, padding: padding)
        return self
    }
    
    @discardableResult
    public func right(_ anchor: NSLayoutXAxisAnchor, padding: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal) -> SmartConstraint {
        layoutAnchor(item.rightAnchor, toAnchor: anchor, relation: relation, padding: -padding)
        return self
    }
    
    @discardableResult
    public func width(_ anchor: NSLayoutDimension, constant: CGFloat = 0, multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal) -> SmartConstraint {
        layoutDimension(item.widthAnchor, toDimension: anchor, relation: relation, constant: constant, multiplier: multiplier)
        return self
    }
    
    @discardableResult
    public func width(constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal) -> SmartConstraint {
        layoutDimension(item.widthAnchor, relation: relation, constant: constant)
        return self
    }
    
    @discardableResult
    public func height(_ anchor: NSLayoutDimension, constant: CGFloat = 0, multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal) -> SmartConstraint {
        layoutDimension(item.heightAnchor, toDimension: anchor, relation: relation, constant: constant, multiplier: multiplier)
        return self
    }
    
    @discardableResult
    public func height(constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal) -> SmartConstraint {
        layoutDimension(item.heightAnchor, relation: relation, constant: constant)
        return self
    }
    
    @discardableResult
    public func centerX(_ anchor: NSLayoutXAxisAnchor, padding: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal) -> SmartConstraint {
        layoutAnchor(item.centerXAnchor, toAnchor: anchor, relation: relation, padding: padding)
        return self
    }
    
    @discardableResult
    public func centerY(_ anchor: NSLayoutYAxisAnchor, padding: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal) -> SmartConstraint {
        layoutAnchor(item.centerYAnchor, toAnchor: anchor, relation: relation, padding: padding)
        return self
    }
    
    func layoutAnchor<T: AnyObject>(_ anchor: NSLayoutAnchor<T>, toAnchor: NSLayoutAnchor<T>, relation: NSLayoutConstraint.Relation, padding: CGFloat) {
        var constraint: NSLayoutConstraint?
        
        switch relation {
        case .equal:
            constraint = anchor.constraint(equalTo: toAnchor, constant: padding)
        case .greaterThanOrEqual:
            constraint = anchor.constraint(greaterThanOrEqualTo: toAnchor, constant: padding)
        case .lessThanOrEqual:
            constraint = anchor.constraint(lessThanOrEqualTo: toAnchor, constant: padding)
        default:
            fatalError()
        }
        
        if let const = constraint {
            const.isActive = true
            constraints.append(const)
        }
    }
    
    func layoutDimension(_ dimension: NSLayoutDimension, toDimension: NSLayoutDimension? = nil, relation: NSLayoutConstraint.Relation, constant: CGFloat, multiplier: CGFloat = 1) {
        var constraint: NSLayoutConstraint?
        
        switch relation {
        case .equal:
            if let dim = toDimension {
                constraint = dimension.constraint(equalTo: dim, multiplier: multiplier, constant: constant)
            } else {
                constraint = dimension.constraint(equalToConstant: constant)
            }
        case .greaterThanOrEqual:
            if let dim = toDimension {
                constraint = dimension.constraint(greaterThanOrEqualTo: dim, multiplier: multiplier, constant: constant)
            } else {
                constraint = dimension.constraint(greaterThanOrEqualToConstant: constant)
            }
        case .lessThanOrEqual:
            if let dim = toDimension {
                constraint = dimension.constraint(lessThanOrEqualTo: dim, multiplier: multiplier, constant: constant)
            } else {
                constraint = dimension.constraint(lessThanOrEqualToConstant: constant)
            }
        default:
            fatalError()
        }
        
        if let const = constraint {
            const.isActive = true
            constraints.append(const)
        }
    }
}