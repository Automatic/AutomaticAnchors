import Foundation

public enum Dimension {
    // Dimension anchor, with no associated constant
    case anchor(NSLayoutDimension)
    
    // Dimension anchor, with an associated additive constant
    case anchorWithConstant(NSLayoutDimension,CGFloat)

    // Dimension anchor, with an associated multiplicative constant
    case anchorWithMultiplier(NSLayoutDimension,CGFloat)
}

public extension Dimension {
    
    static func == (lhs: Dimension, rhs: Dimension) -> NSLayoutConstraint {
        switch (lhs, rhs) {
        case (.anchor(let anchor1),
              .anchor(let anchor2)):
            return anchor1.constraint(equalTo: anchor2)

        case (.anchor(let anchor1),
              .anchorWithMultiplier(let anchor2, let multiplier)):
            return anchor1.constraint(equalTo: anchor2, multiplier: multiplier)

        case (.anchorWithMultiplier(let anchor1, let multiplier),
              .anchor(let anchor2)):
            return anchor1.constraint(equalTo: anchor2, multiplier: 1.0/multiplier)

        case (.anchor(let anchor1),
              .anchorWithConstant(let anchor2, let constant)):
            return anchor1.constraint(equalTo: anchor2, constant: constant)

        case (.anchorWithConstant(let anchor1, let constant),
              .anchor(let anchor2)):
            return anchor1.constraint(equalTo: anchor2, constant: -constant)

        case (.anchorWithConstant(_, _), .anchorWithMultiplier(_, _)),
             (.anchorWithConstant(_, _), .anchorWithConstant(_, _)),
             (.anchorWithMultiplier(_, _), .anchorWithMultiplier(_, _)),
             (.anchorWithMultiplier(_, _), .anchorWithConstant(_, _)):
            // These aren't supported
            fail()
            abort()
        }
    }

    static func <= (lhs: Dimension, rhs: Dimension) -> NSLayoutConstraint {
        switch (lhs, rhs) {
        case (.anchor(let anchor1),
              .anchor(let anchor2)):
            return anchor1.constraint(lessThanOrEqualTo: anchor2)

        case (.anchor(let anchor1),
              .anchorWithMultiplier(let anchor2, let multiplier)):
            return anchor1.constraint(lessThanOrEqualTo: anchor2, multiplier: multiplier)

        case (.anchorWithMultiplier(let anchor1, let multiplier),
              .anchor(let anchor2)):
            return anchor1.constraint(lessThanOrEqualTo: anchor2, multiplier: 1.0/multiplier)

        case (.anchor(let anchor1),
              .anchorWithConstant(let anchor2, let constant)):
            return anchor1.constraint(lessThanOrEqualTo: anchor2, constant: constant)

        case (.anchorWithConstant(let anchor1, let constant),
              .anchor(let anchor2)):
            return anchor1.constraint(lessThanOrEqualTo: anchor2, constant: -constant)

        case (.anchorWithConstant(_, _), .anchorWithMultiplier(_, _)):
            print("constant and multipler dimensions cannot currently be combined")
            abort()

        case (.anchorWithConstant(_, _), .anchorWithConstant(_, _)):
            print("constant and multipler dimensions cannot currently be combined")
            abort()

        case (.anchorWithMultiplier(_, _), .anchorWithMultiplier(_, _)):
            print("constant and multipler dimensions cannot currently be combined")
            abort()

        case (.anchorWithMultiplier(_, _), .anchorWithConstant(_, _)):
            print("constant and multipler dimensions cannot currently be combined")
            abort()
        }
    }

    static func >= (lhs: Dimension, rhs: Dimension) -> NSLayoutConstraint {
        switch (lhs, rhs) {
        case (.anchor(let anchor1),
              .anchor(let anchor2)):
            return anchor1.constraint(greaterThanOrEqualTo: anchor2)

        case (.anchor(let anchor1),
              .anchorWithMultiplier(let anchor2, let multiplier)):
            return anchor1.constraint(greaterThanOrEqualTo: anchor2, multiplier: multiplier)

        case (.anchorWithMultiplier(let anchor1, let multiplier),
              .anchor(let anchor2)):
            return anchor1.constraint(greaterThanOrEqualTo: anchor2, multiplier: 1.0/multiplier)

        case (.anchor(let anchor1),
              .anchorWithConstant(let anchor2, let constant)):
            return anchor1.constraint(greaterThanOrEqualTo: anchor2, constant: constant)

        case (.anchorWithConstant(let anchor1, let constant),
              .anchor(let anchor2)):
            return anchor1.constraint(greaterThanOrEqualTo: anchor2, constant: -constant)

        case (.anchorWithConstant(_, _), .anchorWithMultiplier(_, _)),
             (.anchorWithConstant(_, _), .anchorWithConstant(_, _)),
             (.anchorWithMultiplier(_, _), .anchorWithMultiplier(_, _)),
             (.anchorWithMultiplier(_, _), .anchorWithConstant(_, _)):
            // These aren't supported 
            fail()
            abort()
        }
    }

    static func == (lhs: Dimension, rhs: Int) -> NSLayoutConstraint {
        return lhs == CGFloat(rhs)
    }
    
    static func == (lhs: Int, rhs: Dimension) -> NSLayoutConstraint {
        return rhs == CGFloat(lhs)
    }
    
    static func == (lhs: CGFloat, rhs: Dimension) -> NSLayoutConstraint {
        return rhs == lhs
    }
    
    static func == (lhs: Dimension, rhs: CGFloat) -> NSLayoutConstraint {
        switch (lhs) {
        case .anchor(let anchor):
            return anchor.constraint(equalToConstant: rhs)

        case .anchorWithMultiplier(let anchor, let multiplier):
            return anchor.constraint(equalToConstant: rhs/multiplier)

        case .anchorWithConstant(let anchor, let constant):
            return anchor.constraint(equalToConstant: constant-rhs)

        }
    }
    
    static func <= (lhs: Dimension, rhs: Int) -> NSLayoutConstraint {
        return lhs <= CGFloat(rhs)
    }
    
    static func <= (lhs: Dimension, rhs: CGFloat) -> NSLayoutConstraint {
        switch (lhs) {
        case .anchor(let anchor1):
            return anchor1.constraint(lessThanOrEqualToConstant: rhs)

        case .anchorWithMultiplier(let anchor, let multiplier):
            return anchor.constraint(lessThanOrEqualToConstant: rhs/multiplier)

        case .anchorWithConstant(let anchor, let constant):
            return anchor.constraint(lessThanOrEqualToConstant: constant-rhs)
        }
    }
    
    static func >= (lhs: Dimension, rhs: Int) -> NSLayoutConstraint {
        return lhs >= CGFloat(rhs)
    }
    
    static func >= (lhs: Dimension, rhs: CGFloat) -> NSLayoutConstraint {
        switch (lhs) {
        case .anchor(let anchor1):
            return anchor1.constraint(greaterThanOrEqualToConstant: rhs)

        case .anchorWithMultiplier(let anchor, let multiplier):
            return anchor.constraint(greaterThanOrEqualToConstant: rhs/multiplier)

        case .anchorWithConstant(let anchor, let constant):
            return anchor.constraint(greaterThanOrEqualToConstant: constant-rhs)
        }
    }

    static func * (lhs: Dimension, rhs: Int) -> Dimension {
        return lhs * CGFloat(rhs)
    }

    static func * (lhs: Dimension, rhs: CGFloat) -> Dimension {
        switch lhs {
        case .anchor(let anchor):
            return .anchorWithMultiplier(anchor, rhs)
            
        case .anchorWithConstant(_, _):
            fail()
            abort()

        case .anchorWithMultiplier(let anchor, let multiplier):
            return .anchorWithMultiplier(anchor,  multiplier * rhs)
        }
    }
    
    static func / (lhs: Dimension, rhs: Int) -> Dimension {
        return lhs / CGFloat(rhs)
    }

    static func / (lhs: Dimension, rhs: CGFloat) -> Dimension {
        switch lhs {
        case .anchor(let anchor):
            return .anchorWithMultiplier(anchor, 1.0/rhs)
            
        case .anchorWithConstant(_, _):
            fail()
            abort()

        case .anchorWithMultiplier(let anchor, let multiplier):
            return .anchorWithMultiplier(anchor,  multiplier / rhs)
        }
    }
    
    static func + (lhs: Dimension, rhs: Int) -> Dimension {
        return lhs + CGFloat(rhs)
    }

    static func + (lhs: Dimension, rhs: CGFloat) -> Dimension {
        switch lhs {
        case .anchor(let anchor):
            return .anchorWithConstant(anchor, rhs)
            
        case .anchorWithConstant(let anchor, let constant):
            return .anchorWithConstant(anchor, constant + rhs)

        case .anchorWithMultiplier(_, _):
            fail()
            abort()
        }
    }
    
    static func - (lhs: Dimension, rhs: Int) -> Dimension {
        return lhs - CGFloat(rhs)
    }

    static func - (lhs: Dimension, rhs: CGFloat) -> Dimension {
        switch lhs {
        case .anchor(let anchor):
            return .anchorWithConstant(anchor, -rhs)
            
        case .anchorWithConstant(let anchor, let constant):
            return .anchorWithConstant(anchor, constant - rhs)

        case .anchorWithMultiplier(_, _):
            fail()
            abort()
        }
    }    
}

extension Dimension: CustomStringConvertible {
    public var description: String {
        switch self {
        case .anchor(let dim):
            return dim.description
            
        case .anchorWithMultiplier(let dim, let multi):
            return "\(dim.description) * constant \(multi)"
            
        case .anchorWithConstant(let dim, let constant):
            return "\(dim.description) + constant \(constant)"
        }
    }
}

fileprivate func fail() {
    print("Constant and multiplier constraints cannot currently be combined")
}

