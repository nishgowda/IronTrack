//
//  ImageView.swift
//  IronTrack2
//
//  Created by Nish Gowda on 3/10/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import Combine
import SwiftUI
struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }
var body: some View {
    VStack {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width:250, height:300)
    }.onReceive(imageLoader.dataPublisher) { data in
        self.image = UIImage(data: data) ?? UIImage()
    }
  }
    
}
struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(withURL: "")
    }
}


