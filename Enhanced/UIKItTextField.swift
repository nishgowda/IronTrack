//
//  UIKItTextField.swift
//  IronTrack2
//
//  Created by Nish Gowda on 3/14/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import UIKit
import SwiftUI

class UIKitTextField: UITextField, UITextFieldDelegate {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        self.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }

}

struct UBSTextField : UIViewRepresentable {

    @Binding var myText: String
    let placeHolderText: String

    func makeCoordinator() -> UBSTextField.Coordinator {
        return Coordinator(text: $myText)
    }

    class Coordinator: NSObject {
        var textBinding: Binding<String>
        init(text: Binding<String>) {
            self.textBinding = text
        }

        @objc func textFieldEditingChanged(_ sender: UIKitTextField) {
            self.textBinding.wrappedValue = sender.text ?? ""
        }
    }

    func makeUIView(context: Context) -> UIKitTextField {

        let textField = UIKitTextField(frame: .zero)

        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldEditingChanged(_:)), for: .editingChanged)

        textField.text = self.myText
        textField.placeholder = self.placeHolderText
        textField.borderStyle = .none
        textField.keyboardType = .numbersAndPunctuation
        textField.returnKeyType = .done
        textField.autocapitalizationType = .words
        textField.clearButtonMode = .whileEditing

        return textField
    }

    func updateUIView(_ uiView: UIKitTextField,
                      context: Context) {
        uiView.text = self.myText
    }
}
