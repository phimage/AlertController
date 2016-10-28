//
//  ViewController.swift
//  Demo
//
//  Created by phimage on 28/10/16.
//  Copyright © 2016 phimage. All rights reserved.
//

import Cocoa
import AlertController

class ViewController: NSViewController {
    
    var buttonsBarColor = NSColor.clear
    var preferredStyle = AlertController.Style.informational

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.window?.appearance =  NSAppearance(named: NSAppearanceNameVibrantDark)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func showAlert(_ sender: AnyObject) {
        let controller = AlertController(title: "My title", message: "an alert message", preferredStyle: .warning)
        
        controller.add(action: AlertAction.dismiss(for: controller, title: "Ok"))
    
        controller.add(action: AlertAction(title: "Report...", style: .default) { action in
            NSWorkspace.shared().open(URL(string: "https://github.com/phimage/AlertController/issues")!)
        })
        
        controller.addAction(title: "", style: .helpButton) { action in
            NSWorkspace.shared().open(URL(string: "https://github.com/phimage/AlertController")!)
        }
        
        controller.buttonsBar.color = buttonsBarColor
        controller.preferredStyle = preferredStyle

        controller.customizeVisualEffectView = { view in
            view.material = NSVisualEffectMaterial.appearanceBased
            print(view.interiorBackgroundStyle)
        }
        
        self.presentViewControllerAsSheet(controller)

        buttonsBarColor = buttonsBarColor == NSColor.red ? NSColor.clear : NSColor.red
        preferredStyle = preferredStyle == AlertController.Style.critical ? .informational : .critical
    }

}

/*
extension NSViewController {
    open override func presentError(_ error: Error) -> Bool {
        return true
    }
    open override func presentError(_ error: Error, modalFor window: NSWindow, delegate: Any?, didPresent didPresentSelector: Selector?, contextInfo: UnsafeMutableRawPointer?) {
        
    }
}
*/

extension NSBackgroundStyle: CustomStringConvertible {
    public var description: String {
        switch (self) {
        case .light: return "light"
        case .dark: return "dark"
        case .raised: return "raised"
        case .lowered: return "lowered"
        }
    }
}
