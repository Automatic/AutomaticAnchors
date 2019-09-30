import UIKit
import AutomaticAnchors

class LogTableViewCell: UITableViewCell {

    let logEntry: LogEntry
    let dateLabelView = UIView(frame: .zero)
    let dateLabel = UILabel(frame: .zero)
    let typeLabel = UILabel(frame: .zero)
    let valueLabel = UILabel(frame: .zero)

    init(with logEntry: LogEntry) {
        self.logEntry = logEntry
        
        super.init(style: .`default`, reuseIdentifier: nil)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateLabel.text = dateFormatter.string(from: logEntry.date)

        contentView.addSubview(dateLabelView)
        dateLabelView.translatesAutoresizingMaskIntoConstraints = false
        dateLabelView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(typeLabel)
        contentView.addSubview(valueLabel)

        // generate the constraints with AutomaticAnchors,
        // or using the underyling NSLayoutAnchor classes.
        var useAutomaticConstraints = true

        if useAutomaticConstraints {
            // use the AutomaticAnchors wrapper syntax 
            applyAutomaticAnchorConstraints()
        } else {
            // use the underlying NSLayoutAnchor syntax directly
            applyNSLayoutAnchorConstraints()
        }
    }

    // here is the same set of constraints written using AutomaticAnchors
    func applyAutomaticAnchorConstraints() {

        // current swift compilers can get confused about the type of long constraint
        // lists, requiring an explicit [NSLayoutConstraint] type here to disambiguate.
        let constraints: [NSLayoutConstraint] =
          [
            dateLabelView.leading == contentView.leading,
            dateLabelView.top == contentView.top,
            dateLabelView.bottom == contentView.bottom,
            dateLabelView.width == 80,

            dateLabel.centerY == dateLabelView.centerY,
            dateLabel.centerX == dateLabelView.centerX,
            
            typeLabel.top == contentView.top,
            typeLabel.leading == dateLabelView.trailing + 10,
            typeLabel.trailing == contentView.trailing + 10,
            typeLabel.bottom == valueLabel.top,

            typeLabel.height == valueLabel.height,
            
            valueLabel.leading == dateLabelView.trailing + 10,
            contentView.trailing == valueLabel.trailing + 10,
            valueLabel.bottom == contentView.bottom,
          ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // here is the set of constraints written using layout anchors directly
    func applyNSLayoutAnchorConstraints() {
        NSLayoutConstraint.activate(
           [
            dateLabelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabelView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateLabelView.widthAnchor.constraint(equalToConstant: 80),
 
            dateLabel.centerYAnchor.constraint(equalTo: dateLabelView.centerYAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: dateLabelView.centerXAnchor),
             
            typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            typeLabel.leadingAnchor.constraint(equalTo: dateLabelView.trailingAnchor, constant: 10),
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            typeLabel.bottomAnchor.constraint(equalTo: valueLabel.topAnchor),
 
            typeLabel.heightAnchor.constraint(equalTo: valueLabel.heightAnchor),
            
            valueLabel.leadingAnchor.constraint(equalTo: dateLabelView.trailingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor, constant: 10),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
           ]
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
