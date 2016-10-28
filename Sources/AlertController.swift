//
//  AlertController.swift
//  AlertController
//
//  Created by phimage on 28/10/16.
//  Copyright © 2016 phimage. All rights reserved.
//

import Cocoa


// A NSViewController to display an alert message to the user. This class replaces the NSAlert class. After configuring the alert controller with the actions and style you want, present it using `presentViewControllerAsSheet`.
open class AlertController: NSViewController {

    // The title of the alert.
    //open var title: String?
    // Descriptive text that provides more details about the reason for the alert.
    open var message: String?
    // The style of the alert controller.
    open var preferredStyle: AlertController.Style
  
    // Customize buttons bar
    public struct ButtonsBar {
        public var color: NSColor?
        public var trailingSpace = 20
        public var buttonSpace = 8
    }
    open var buttonsBar = ButtonsBar()
    
    // Handler to customize the main view
    open var customizeVisualEffectView: ((_ view: NSVisualEffectView) -> Void)? = nil

    // view for buttons
    @IBOutlet weak var visualEffectView: NSVisualEffectView!
    @IBOutlet weak var buttonsView: NSView!
    @IBOutlet weak var textFieldsView: NSView!
    @IBOutlet weak var textFieldsHeight: NSLayoutConstraint!
    //open var textFieldHeight: CGFloat = 20

    @IBOutlet weak var titleView: NSTextField!
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var messageView: NSTextField!
    @IBOutlet weak var logoImageView: NSImageView!

    // Creates and returns a view controller for displaying an alert to the user.
    public init(title: String?, message: String?, preferredStyle: AlertController.Style) {
        self.message = message
        self.preferredStyle = preferredStyle
        super.init(nibName: "AlertController", bundle: Bundle(for: AlertController.self))!
        self.title = title
    }

    // Do not use
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Install buttons and data
    override open func viewDidLoad() {
        super.viewDidLoad()

        customizeVisualEffectView?(visualEffectView)

        titleView.stringValue = self.title ?? ""
        messageView.stringValue = self.message ?? ""
       
        let image = preferredStyle.image
        imageView.image = image ?? NSApp.applicationIconImage
        if image != nil {
            logoImageView.image = NSApp.applicationIconImage
        }

        if actions.isEmpty {
            add(action: AlertAction.dismiss(for: self))
        }
        var views = [String: Any]()
        var index = 0
        var visualFormat = ""
        for action in actions.reversed() {
            let button = action.button
            button.translatesAutoresizingMaskIntoConstraints = false
            
            // Manage preferred action
            if action == self.preferredAction {
                button.keyEquivalent = "\r"
                if let cell = button.cell as? NSButtonCell {
                    self.view.window?.defaultButtonCell = cell
                }
            }
            
            buttonsView.addSubview(button)
            
            // Center buton vertically
            let verticalConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: buttonsView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
            NSLayoutConstraint.activate([verticalConstraint])
            
            let buttonFormat = "b\(index)"
            views[buttonFormat] = button
            if !visualFormat.isEmpty {
                visualFormat += "-(\(buttonsBar.buttonSpace))-"
            } else {
                visualFormat += "H:"
            }
            visualFormat += "[\(buttonFormat)]"
            index += 1
            
 
        }
        visualFormat += "-(\(buttonsBar.trailingSpace))-|"
        let cs = NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: [], metrics: [:], views: views)
        NSLayoutConstraint.activate(cs)

        if let color = buttonsBar.color {
            buttonsView.wantsLayer = true
            buttonsView.layer?.backgroundColor = color.cgColor
        }

       // Input?
       /* if textFields == nil {*/
            textFieldsHeight.constant = 0
       /* }
        else {
            let textFields = self.textFields ?? []
            textFieldsHeight.constant = CGFloat(textFields.count) * textFieldHeight
            for textField in textFields {
                textFieldsView.addSubview(textField)
            }
        }*/
        
    }
    
    
    // MARK: Actions
    
    // The actions that the user can take in response to the alert or action sheet.
    open var actions: [AlertAction] = []
    // The preferred action for the user to take from an alert.
    open var preferredAction: AlertAction?
    
    //  Attaches an action object to the alert or action sheet.
    open func add(action: AlertAction) {
        if actions.isEmpty {
            preferredAction = action
        }
        actions.append(action)
    }
    
    //  Create and attaches an action object to the alert or action sheet.
    open func addAction(title: String, style: AlertAction.Style = .default, handler: @escaping (_ action: AlertAction) -> Void) {
        self.add(action: AlertAction(title: title, style: style, handler: handler))
    }

    // MARK: Textfields
    
    // The array of text fields displayed by the alert.
    /*open var textFields: [NSTextField]?
    
    // Adds a text field to an alert.
    open func addTextField(configurationHandler: ((NSTextField) -> Void)? = nil) {
        let textFields = NSTextField()
        configurationHandler?(textFields)
        if self.textFields == nil {
            self.textFields = []
        }
        self.textFields?.append(textFields)
    }*/
    
}
