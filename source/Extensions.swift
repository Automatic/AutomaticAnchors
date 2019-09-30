import Foundation

/*    
    Using these extensions, and their associated enums and operators, this:
    
        NSLayoutConstraint.activate(
          [
            tableView.topAnchor.constraint(equalTo: debugUIView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stateLabel.leadingAnchor.constraint(equalTo: scanBLECircle.trailingAnchor, constant: 10),
            scanLabel.widthAnchor.constraint(equalToConstant: 30),
          ]
        )
    
    can be now written as:
    
        NSLayoutConstraint.activate(
          [
            tableView.top == debugUIView.bottom,
            tableView.leading == view.leading,
            stateLabel.leading == scanBLECircle.trailing + 10,
            scanLabel.width == 30,
          ]
        )

*/

/*
 These properties, and the operators which are defined to operate on them, 
 define the public interface to this library.

 The types of these properties are less relevant than the operators which are 
 defined to operate upon them, as code using these extensions does not need to 
 reference the types they return directly. 
*/
public extension UILayoutGuide {
    var top:     YAxis { return YAxis(self.topAnchor) }
    var centerY: YAxis { return YAxis(self.centerYAnchor) }
    var bottom:  YAxis { return YAxis(self.bottomAnchor) }
    
    var leading:  XAxis { return XAxis(self.leadingAnchor) }
    var centerX:  XAxis { return XAxis(self.centerXAnchor) }
    var trailing: XAxis { return XAxis(self.trailingAnchor) }
}

public extension UIView {
    var top:           YAxis { return YAxis(self.topAnchor) }
    var centerY:       YAxis { return YAxis(self.centerYAnchor) }
    var bottom:        YAxis { return YAxis(self.bottomAnchor) }
    var lastBaseline:  YAxis { return YAxis(self.lastBaselineAnchor) }
    var firstBaseline: YAxis { return YAxis(self.firstBaselineAnchor) }

    var leading:  XAxis { return XAxis(self.leadingAnchor) }
    var centerX:  XAxis { return XAxis(self.centerXAnchor) }
    var trailing: XAxis { return XAxis(self.trailingAnchor) }
    var left:     XAxis { return XAxis(self.leftAnchor) }
    var right:    XAxis { return XAxis(self.rightAnchor) }

    var height: Dimension { return .anchor(self.heightAnchor) }
    var width:  Dimension { return .anchor(self.widthAnchor) }
}

/*

 This following set of extensions compiles, at least by itself.

 However, as of Xcode 10.1, the swift compiler barfs on type checking long list of
 constraints, even if the type of the enclosing reference is specified explicitly:

            let constraints:[NSLayoutConstraint] = 
              [
                addMaverickButton.width == addMaverickButton.height,
                addMaverickButton.width == 80,
                tableView.top == debugUIView.bottom,
                tableView.leading == view.leading,
                tableView.trailing == view.trailing,
                tableView.bottom == view.bottom,
                ...
              ]                

 If the swift compiler advances further, any existing code that uses that above
 extensions can then be recompiled using the following extensions without any code changes.  The YAxis and XAxis structs will then be redundant and can be removed.

public extension UILayoutGuide {
    var top:     Anchor<NSLayoutYAxisAnchor> { return .anchor(self.topAnchor) }
    var centerY: Anchor<NSLayoutYAxisAnchor> { return .anchor(self.centerYAnchor) }
    var bottom:  Anchor<NSLayoutYAxisAnchor> { return .anchor(self.bottomAnchor) }
    
    var leading:  Anchor<NSLayoutXAxisAnchor> { return .anchor(self.leadingAnchor) }
    var centerX:  Anchor<NSLayoutXAxisAnchor> { return .anchor(self.centerXAnchor) }
    var trailing: Anchor<NSLayoutXAxisAnchor> { return .anchor(self.trailingAnchor) }
}

public extension UIView {
    var top:           Anchor<NSLayoutYAxisAnchor> { return .anchor(self.topAnchor) }
    var centerY:       Anchor<NSLayoutYAxisAnchor> { return .anchor(self.centerYAnchor) }
    var bottom:        Anchor<NSLayoutYAxisAnchor> { return .anchor(self.bottomAnchor) }
    var lastBaseline:  Anchor<NSLayoutYAxisAnchor> { return .anchor(self.lastBaselineAnchor) }
    var firstBaseline: Anchor<NSLayoutYAxisAnchor> { return .anchor(self.firstBaselineAnchor) }

    var leading:  Anchor<NSLayoutXAxisAnchor> { return .anchor(self.leadingAnchor) }
    var centerX:  Anchor<NSLayoutXAxisAnchor> { return .anchor(self.centerXAnchor) }
    var trailing: Anchor<NSLayoutXAxisAnchor> { return .anchor(self.trailingAnchor) }
    var left:     Anchor<NSLayoutXAxisAnchor> { return .anchor(self.leftAnchor) }
    var right:    Anchor<NSLayoutXAxisAnchor> { return .anchor(self.rightAnchor) }

    var height: Dimension { return .anchor(self.heightAnchor) }
    var width:  Dimension { return .anchor(self.widthAnchor) }
}
*/
