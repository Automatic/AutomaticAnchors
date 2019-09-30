import UIKit

/*
    A ConstraintMap allows specifying constraint priority as such:

    let constraintMap: ConstraintMap =
      [
        .required:
          [
            topView.top == contentView.top,
          ],
        .defaultHigh :
          [
            signalStrengthView.trailing + 10 <= contentView.trailing,
          ],
        .defaultLow:
          [
            vinLabel.leading >= ignCircle.trailing + 10,
          ]
      ]

    AutomaticAnchors.activate(constraintMap)
*/

public typealias ConstraintMap = [UILayoutPriority: ConstraintList]
public typealias ConstraintList = [NSLayoutConstraint]

public func + (lhs: ConstraintMap, rhs: ConstraintMap) -> ConstraintMap {
    var ret = lhs
    for (rhsKey, rhsList) in rhs {
        if let lhsList = ret[rhsKey] {
            let newList = rhsList + lhsList
            ret[rhsKey] = newList
        } else {
            ret[rhsKey] = rhsList
        }
    }
    return ret
}


public func activate(_ constraintMap: ConstraintMap) {
    var priorities: [UILayoutPriority] = Array(constraintMap.keys)
    // need to sort so the higher priorities are first
    priorities.sort(by: >)
    
    for priority in priorities {
        if let constraints = constraintMap[priority] {
            activate(constraints, withPriority: priority)
        }
    }
}

public func deactivate(_ constraintMap: ConstraintMap) {
    for (_, constraints) in constraintMap {
        deactivate(constraints)
    }
}

public func activate(_ constraints: ConstraintList,
                     withPriority priority: UILayoutPriority? = nil)
{
    if let priority = priority {
        for constraint in constraints {
            constraint.priority = priority
        }
    }
    NSLayoutConstraint.activate(constraints)
}

public func deactivate(_ constraints: ConstraintList) {
    NSLayoutConstraint.deactivate(constraints)
}
