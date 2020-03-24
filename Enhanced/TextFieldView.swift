//
//  TextFieldView.swift
//  IronTrack2
//
//  Created by Nish Gowda on 3/14/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//
import SwiftUI

// The SwiftUI view, wrapping the UITextField
struct TextFieldView: View {
    
    var text: Binding<String>
    var onDismissKeyboard: (() -> Void)?
    
    var body: some View {
        TextFieldRepresentable(
            text: self.text
            , dismissKeyboardCallback: self.onDismissKeyboard
        )
    }
}

// The UIViewControllerRepresentable, feeding and controlling the UIViewController
struct TextFieldRepresentable
    : UIViewControllerRepresentable {
    
    // the callback
    let dismissKeyboardCallback: (() -> Void)?

    // created in the previous file/gist
    let viewController: TextFieldViewController
    
    init (
        text: Binding<String>
        , dismissKeyboardCallback: (() -> Void)?) {
        
        self.dismissKeyboardCallback = dismissKeyboardCallback
        self.viewController = TextFieldViewController(
            text: text
            , onDismiss: dismissKeyboardCallback
        )
    }
    
    // UIViewControllerRepresentable
    func makeUIViewController(context: Context) -> UIViewController {
        
        return viewController
    }
      
    // UIViewControllerRepresentable
    func updateUIViewController(_ viewController: UIViewController, context: Context) {
    }
    
}
