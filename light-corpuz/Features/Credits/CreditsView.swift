//
//  CreditsView.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import SwiftUI

struct CreditsView: View {
    
    private var photoURL: URL {
        URL(string: "https://instagram.fcrk3-4.fna.fbcdn.net/v/t51.2885-19/500674874_17861434215409545_6463173187167169470_n.jpg?efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLmRqYW5nby4xMDgwLmMyIn0&_nc_ht=instagram.fcrk3-4.fna.fbcdn.net&_nc_cat=109&_nc_oc=Q6cZ2QFSu2IBm5B4H5DvH51hwYP4ct4pyXDvJqVY_5HcyKNk3HEW39Xaj0CczFpfvC3qQUw&_nc_ohc=_MSSrM8XVJUQ7kNvwEGJ-Fe&_nc_gid=M0qyB14f8yVFM-ONb9vSIQ&edm=AP4sbd4BAAAA&ccb=7-5&oh=00_AfXkcFEoiZjVBgiha3-j2m4_nDr84Pet05sLlF8NdN9X0g&oe=68BD0183&_nc_sid=7a9f4b")!
    }
    
    let photoHeight: CGFloat = 220
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                AsyncImage(url: photoURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: photoHeight, height: photoHeight)

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: photoHeight, height: photoHeight)
                            .clipped()
                            .clipShape(Circle())

                    case .failure:
                        Image(systemName: "photo")
                            .frame(width: photoHeight, height: photoHeight)

                    @unknown default:
                        EmptyView()
                    }
                }
                
                Text("Michael Allan \"Light\" Corpuz")
                    .font(.title).bold()
                Text("@lightningowltech x @hojichaboi")
                    .foregroundStyle(.secondary)

                Divider()

                LegacyCollectionViewDemo()
                    .frame(height: 300)
            }
        }
        .padding(.leading, ExamConstants.padding)
        .padding(.trailing, ExamConstants.padding)
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

import UIKit

struct LegacyCollectionViewDemo: UIViewRepresentable {
    func makeUIView(context: Context) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 24, height: 50)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = context.coordinator
        return collectionView
    }

    func updateUIView(_ uiView: UICollectionView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    final class Coordinator: NSObject, UICollectionViewDataSource {
        let words = ["In", "case", "you", "didn't", "know", "this", "is", "also", "a", "UICollectionView", "🫡"]

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            words.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            
            let label = UILabel()
            label.text = words[indexPath.item]
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false

            cell.contentView.subviews.forEach { $0.removeFromSuperview() } // cleanup
            cell.contentView.addSubview(label)
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
            ])

            cell.contentView.backgroundColor = .systemBlue
            cell.layer.cornerRadius = 8
            return cell
        }
    }
}

#Preview {
    CreditsView()
}
