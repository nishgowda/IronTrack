//
//  MulitTextField.swift
//  IronTrack2
//
//  Created by Nish Gowda on 3/1/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import SwiftUI


struct MultilineTextView: UIViewRepresentable {
    @State var workItems = WorkItemView(workItem: WorkItem())
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = workItems.notes
    }
}


