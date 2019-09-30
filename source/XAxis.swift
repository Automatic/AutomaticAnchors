import Foundation

// This class is almost identical to YAxis, and exists because the Xcode 10.1 swift
// compiler is too slow to type check the generic Anchor enum in long lists.
// By keeping things non-generic like this, esentially wrapping the Anchor enum
// in a non-generic class, we both satisfy the grumpy swift compiler, and avoid
// duplicating anything more than the logic shown here

public struct XAxis {
    private let anchor: Anchor<NSLayoutXAxisAnchor>

    init(_ anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>) {
        self.anchor = .anchor(anchor)
    }
    public static func == (lhs: XAxis, rhs: XAxis) -> NSLayoutConstraint {
        return lhs.anchor == rhs.anchor
    }
    public static func == (lhs: XAxis, rhs: Anchor<NSLayoutXAxisAnchor>) -> NSLayoutConstraint {
        return lhs.anchor == rhs
    }
    public static func == (lhs: Anchor<NSLayoutXAxisAnchor>, rhs: XAxis) -> NSLayoutConstraint {
        return lhs == rhs.anchor
    }
    public static func <= (lhs: XAxis, rhs: XAxis) -> NSLayoutConstraint {
        return lhs.anchor <= rhs.anchor
    }
    public static func <= (lhs: Anchor<NSLayoutXAxisAnchor>, rhs: XAxis) -> NSLayoutConstraint {
        return lhs <= rhs.anchor
    }
    public static func <= (lhs: XAxis, rhs: Anchor<NSLayoutXAxisAnchor>) -> NSLayoutConstraint {
        return lhs.anchor <= rhs
    }
    public static func >= (lhs: XAxis, rhs: XAxis) -> NSLayoutConstraint {
        return lhs.anchor >= rhs.anchor
    }
    public static func >= (lhs: Anchor<NSLayoutXAxisAnchor>, rhs: XAxis) -> NSLayoutConstraint {
        return lhs >= rhs.anchor
    }
    public static func >= (lhs: XAxis, rhs: Anchor<NSLayoutXAxisAnchor>) -> NSLayoutConstraint {
        return lhs.anchor >= rhs
    }
    public static func + (lhs: XAxis, rhs: CGFloat) -> Anchor<NSLayoutXAxisAnchor> {
        return lhs.anchor + rhs
    }
    public static func + (lhs: XAxis, rhs: Int) -> Anchor<NSLayoutXAxisAnchor> {
        return lhs.anchor + rhs
    }
    public static func + (lhs: CGFloat, rhs: XAxis) -> Anchor<NSLayoutXAxisAnchor> {
        return lhs + rhs.anchor
    }
    public static func + (lhs: Int, rhs: XAxis) -> Anchor<NSLayoutXAxisAnchor> {
        return lhs + rhs.anchor
    }
    public static func - (lhs: XAxis, rhs: CGFloat) -> Anchor<NSLayoutXAxisAnchor> {
        return lhs.anchor - rhs
    }
    public static func - (lhs: XAxis, rhs: Int) -> Anchor<NSLayoutXAxisAnchor> {
        return lhs.anchor - rhs
    }
}

