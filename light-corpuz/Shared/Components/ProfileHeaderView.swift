//
//  ProfileHeaderView.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import SwiftUI

struct ProfileHeaderView: View {
    let post: Photo
    
    var body: some View {
        HStack {
            profileImage(photo: post)
                .padding(.leading, ExamConstants.padding)
            Text(post.author)
                .font(.subheadline).bold()
            Spacer()
        }
    }
    
    @ViewBuilder
    func profileImage(photo: Photo) -> some View {
        if let urlString = photo.user?.profileImage?.small,
           let url = URL(string: urlString) {
            
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 30, height: 30)
                    
                case .success(let image):
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())   // optional, for round avatar style
                    
                case .failure:
                    Color.gray
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                    
                @unknown default:
                    EmptyView()
                }
            }
            
        } else {
            Color.gray
                .frame(width: 30, height: 30)
                .clipShape(Circle())
        }
    }
}

