//
//  AlertAction.swift
//  AlertController
//
//  Created by phimage on 28/10/16.
//  Copyright © 2016 phimage. All rights reserved.
//

import Foundation
import AppKit

// An AlertAction object represents an action that can be taken when tapping a button in an alert. You use this class to configure information about a single action, including the title to display in the button, any styling information, and a handler to execute when the user taps the button. After creating an alert action object, add it to a AlertController object before displaying the corresponding alert to the user.
@MainActor
@objc open class AlertAction: NSObject {

    // The title of the action’s button.
    open var title: String {
        get { return button.title }
        set { button.title = newValue }
    }

    // Styles to apply to action buttons in an alert.
    open var style: AlertAction.Style {
        get { return button.bezelStyle }
        set { button.bezelStyle = newValue }
    }
    
    // The toolTip of the action’s button.
    open var toolTip: String? {
        get { return button.toolTip }
        set { button.toolTip = newValue }
    }
    
    // Action code
	public let handler: (_ action: AlertAction) -> Void

    // A Boolean value indicating whether the action is currently enabled.
    open var isEnabled: Bool {
        get { return button.isEnabled }
        set { button.isEnabled = newValue }
    }
    
    // Internal button
    let button = NSButton()
 
    // Create and return an action with the specified title and behavior.
    public init(title: String, style: AlertAction.Style = .default, handler: @escaping (_ action: AlertAction) -> Void) {
        self.handler = handler
        super.init()
        // updateButton
        button.action = #selector(AlertAction.perform as (AlertAction) -> () -> ())
        button.target = self
        button.identifier = NSUserInterfaceItemIdentifier(title)
        self.title = title
        self.style = style
    }
    
    // Perform the action
    @objc dynamic open func perform() {
        handler(self)
    }
}

extension AlertAction {
    // Styles to apply to action buttons in an alert.
	public typealias Style = NSButton.BezelStyle

    // TODO allow align button right or left
    enum Align {
        case left
        case right
        public static let `default` = right
    }
}

extension AlertAction.Style {
	public static let `default` = NSButton.BezelStyle.rounded
}


// MARK: factory
extension AlertAction {
    
	public static func dismiss(for vC: NSViewController, title: String = "OK") -> AlertAction {
        return AlertAction(title: title, style: .default) { (action) in
            vC.dismiss(action.button)
        }
    }
    
}
