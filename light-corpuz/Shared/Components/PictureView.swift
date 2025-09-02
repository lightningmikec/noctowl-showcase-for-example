//
//  PictureView.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import SwiftUI

struct PictureView: View {
    let post: Photo
    
    var body: some View {
        if let urlString = post.urls?.regular,
           let url = URL(string: urlString) {

            SquareRemoteImage(url: url)

        } else {
            Color.gray.opacity(0.2)
                .frame(maxWidth: .infinity)
                .aspectRatio(1, contentMode: .fit)
        }
    }
}
