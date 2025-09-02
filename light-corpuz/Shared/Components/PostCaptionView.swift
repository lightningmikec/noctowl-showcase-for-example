//
//  PostCaptionView.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import SwiftUI

struct PostCaptionView: View {
    let post: Photo
    
    var body: some View {
        VStack(spacing: 8) {
            Text(post.createdAt?.toReadableDate() ?? "")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(post.description ?? "")
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading, ExamConstants.padding)
        .padding(.trailing, ExamConstants.padding)
    }
}
