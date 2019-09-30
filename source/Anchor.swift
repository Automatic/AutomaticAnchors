import Foundation
import UIKit

public enum Anchor<AnchorType> where AnchorType: AnyObject {

    // anchor with no associated constant
    case anchor(NSLayoutAnchor<AnchorType>)

    // anchor with an associated additive constant value
    case anchorWithConstant(NSLayoutAnchor<AnchorType>,CGFloat)
}

extension Anchor {

    /*
     This '==' operator combines two Anchor enums to produce a constraint where
     the two associated anchors are equal.
     */
    public static func == (lhs: Anchor, rhs: Anchor) -> NSLayoutConstraint {
        switch (lhs, rhs) {
        case (.anchor(let anchor1),
              .anchor(let anchor2)):
            return anchor1.constraint(equalTo: anchor2)
            
        case (.anchor(let anchor1),
              .anchorWithConstant(let anchor2, let constant)):
            return anchor1.constraint(equalTo: anchor2, constant: constant)

        case (.anchorWithConstant(let anchor1, let constant),
              .anchor(let anchor2)):
            return anchor1.constraint(equalTo: anchor2, constant: -constant)

        case (.anchorWithConstant(let anchor1, let constant1),
              .anchorWithConstant(let anchor2, let constant2)):
            return anchor1.constraint(equalTo: anchor2,
                                      constant: constant2-constant1)
        }
    }

    /*
     This '<=' operator combines two Anchor enums to produce a constraint where
     the two associated anchors are less than or equal to eachother.
     */
    public static func <= (lhs: Anchor, rhs: Anchor) -> NSLayoutConstraint {
        switch (lhs, rhs) {
        case (.anchor(let anchor1),
              .anchor(let anchor2)):
            return anchor1.constraint(lessThanOrEqualTo: anchor2)
            
        case (.anchor(let anchor1),
              .anchorWithConstant(let anchor2, let constant)):
            return anchor1.constraint(lessThanOrEqualTo: anchor2, constant: constant)

        case (.anchorWithConstant(let anchor1, let constant),
              .anchor(let anchor2)):
            return anchor1.constraint(lessThanOrEqualTo: anchor2, constant: -constant)

        case (.anchorWithConstant(let anchor1, let constant1),
              .anchorWithConstant(let anchor2, let constant2)):
            return anchor1.constraint(lessThanOrEqualTo: anchor2,
                                      constant: constant2-constant1)
        }
    }

    /*
     This '>=' operator combines two Anchor enums to produce a constraint where
     the two associated anchors are greater than or equal to eachother.
     */
    public static func >= (lhs: Anchor, rhs: Anchor) -> NSLayoutConstraint {
        switch (lhs, rhs) {
        case (.anchor(let anchor1),
              .anchor(let anchor2)):
            return anchor1.constraint(greaterThanOrEqualTo: anchor2)
            
        case (.anchor(let anchor1),
              .anchorWithConstant(let anchor2, let constant)):
            return anchor1.constraint(greaterThanOrEqualTo: anchor2, constant: constant)

        case (.anchorWithConstant(let anchor1, let constant),
              .anchor(let anchor2)):
            return anchor1.constraint(greaterThanOrEqualTo: anchor2, constant: -constant)

        case (.anchorWithConstant(let anchor1, let constant1),
              .anchorWithConstant(let anchor2, let constant2)):
            return anchor1.constraint(greaterThanOrEqualTo: anchor2,
                                      constant: constant2-constant1)
        }
    }

    /*
     This '+' operator allows a Anchor enum value to be have a constant added to it.
     
     The resulting enum value can then be turned into a constraint as such:

       imageView.leading == view.leading + 20
     */
    public static func + (lhs: Anchor, rhs: CGFloat) -> Anchor {
        switch lhs {
        case .anchor(let anchor):
            return .anchorWithConstant(anchor, rhs)
            
        case .anchorWithConstant(let anchor, let constant):
            return .anchorWithConstant(anchor, constant + rhs)
        }
    }

    /*
     Convenience operator for 
       view.top + 5
     instead of 
       view.top + CGFloat(5)
     */
    public static func + (lhs: Anchor, rhs: Int) -> Anchor {
        return lhs + CGFloat(rhs)
    }

    /*
     Convenience operator for
       5 + view.top
     instead of
       view.top + 5
    */
    public static func + (lhs: CGFloat, rhs: Anchor) -> Anchor {
        return rhs + lhs
    }

    /*
     Convenience operator for
       5 + view.top
     instead of
       CGFloat(5) + view.top
    */
    public static func + (lhs: Int, rhs: Anchor) -> Anchor {
        return rhs + CGFloat(lhs)
    }

    /*
     This '-' operator allows a Anchor enum value to be have a constant subtracted from it.
     
     The resulting enum value can then be turned into a constraint as such:

       imageView.leading == view.leading - 20
     */
    public static func - (lhs: Anchor, rhs: CGFloat) -> Anchor {
        switch lhs {
        case .anchor(let anchor):
            return .anchorWithConstant(anchor, -rhs)
            
        case .anchorWithConstant(let anchor, let constant):
            return .anchorWithConstant(anchor, constant - rhs)
        }
    }    

    /*
     Convenience operator for 
       view.top - 5
     instead of 
       view.top - CGFloat(5)
     */
    public static func - (lhs: Anchor, rhs: Int) -> Anchor {
        return lhs - CGFloat(rhs)
    }
}

// This is here to make debugging strings more readable
extension Anchor: CustomStringConvertible {
    public var description: String {
        switch self {
        case .anchor(let anchor):
            return anchor.description
            
        case .anchorWithConstant(let anchor, let constant):
            return "\(anchor.description) + constant \(constant)"
        }
    }
}

