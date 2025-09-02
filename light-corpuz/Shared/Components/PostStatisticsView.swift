//
//  PostStatisticsView.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import SwiftUI

struct PostStatisticsView: View {
    let post: Photo
    
    var body: some View {
        HStack(spacing: 4) {
            Image(post.likedByUser == true ? .icFilledLike : .icDefaultLike)
                .resizable()
                .frame(width: 24, height: 24)
            
            if let likes = post.likes {
                Text("\(likes)")
                    .font(.subheadline)
                    .bold()
            }
            
            Spacer()
        }
        .padding(.leading, ExamConstants.padding)
        .padding(.trailing, ExamConstants.padding)
    }
}
