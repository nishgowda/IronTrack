//
//  Keyboard.swift
//  IronTrack2
//
//  Created by Nish Gowda on 2/29/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import SwiftUI

struct TextFieldTyped: UIViewRepresentable {
    let keyboardType: UIKeyboardType
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.keyboardType = self.keyboardType
        textField.delegate = context.coordinator
        
        _ = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textField)
            .compactMap {
                guard let field = $0.object as? UITextField else {
                    return nil
                }
                return field.text
            }
            .sink {
                self.text = $0
            }
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldTyped
        
        init(_ textField: TextFieldTyped) {
            self.parent = textField
        }
        
//        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            if let value = textField.text {
//                parent.text = value
//                parent.onChange?(value)
//            }
//
//            return true
//        }
    }
}
