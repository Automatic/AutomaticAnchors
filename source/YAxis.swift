import Foundation

// This class is almost identical to XAxis, and exists because the Xcode 10.1 swift
// compiler is too slow to type check the generic Anchor enum in long lists.
// By keeping things non-generic like this, esentially wrapping the Anchor enum
// in a non-generic class, we both satisfy the grumpy swift compiler, and avoid
// duplicating anything more than the logic shown here

public struct YAxis {
    private let anchor: Anchor<NSLayoutYAxisAnchor>

    init(_ anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>) {
        self.anchor = .anchor(anchor)
    }
    public static func == (lhs: YAxis, rhs: YAxis) -> NSLayoutConstraint {
        return lhs.anchor == rhs.anchor
    }
    public static func == (lhs: YAxis, rhs: Anchor<NSLayoutYAxisAnchor>) -> NSLayoutConstraint {
        return lhs.anchor == rhs
    }
    public static func == (lhs: Anchor<NSLayoutYAxisAnchor>, rhs: YAxis) -> NSLayoutConstraint {
        return lhs == rhs.anchor
    }
    public static func <= (lhs: YAxis, rhs: YAxis) -> NSLayoutConstraint {
        return lhs.anchor <= rhs.anchor
    }
    public static func <= (lhs: Anchor<NSLayoutYAxisAnchor>, rhs: YAxis) -> NSLayoutConstraint {
        return lhs <= rhs.anchor
    }
    public static func <= (lhs: YAxis, rhs: Anchor<NSLayoutYAxisAnchor>) -> NSLayoutConstraint {
        return lhs.anchor <= rhs
    }
    public static func >= (lhs: YAxis, rhs: YAxis) -> NSLayoutConstraint {
        return lhs.anchor >= rhs.anchor
    }
    public static func >= (lhs: Anchor<NSLayoutYAxisAnchor>, rhs: YAxis) -> NSLayoutConstraint {
        return lhs >= rhs.anchor
    }
    public static func >= (lhs: YAxis, rhs: Anchor<NSLayoutYAxisAnchor>) -> NSLayoutConstraint {
        return lhs.anchor >= rhs
    }
    public static func + (lhs: YAxis, rhs: CGFloat) -> Anchor<NSLayoutYAxisAnchor> {
        return lhs.anchor + rhs
    }
    public static func + (lhs: YAxis, rhs: Int) -> Anchor<NSLayoutYAxisAnchor> {
        return lhs.anchor + rhs
    }
    public static func + (lhs: CGFloat, rhs: YAxis) -> Anchor<NSLayoutYAxisAnchor> {
        return lhs + rhs.anchor
    }
    public static func + (lhs: Int, rhs: YAxis) -> Anchor<NSLayoutYAxisAnchor> {
        return lhs + rhs.anchor
    }
    public static func - (lhs: YAxis, rhs: CGFloat) -> Anchor<NSLayoutYAxisAnchor> {
        return lhs.anchor - rhs
    }
    public static func - (lhs: YAxis, rhs: Int) -> Anchor<NSLayoutYAxisAnchor> {
        return lhs.anchor - rhs
    }
}

