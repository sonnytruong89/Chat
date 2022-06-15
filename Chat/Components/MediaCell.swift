//
//  MediaCell.swift
//  Chat
//
//  Created by Alex.M on 14.06.2022.
//

import SwiftUI
import Combine
import AssetsPicker

struct MediaCell: View {
    let media: Media

    @State var url: URL?
    @State var image: UIImage?
    @State private var subscriptions = Set<AnyCancellable>()

    var body: some View {
        content
            .overlay(alignment: .topTrailing) {
                Button {
                    // TODO: Delete item from message.
                    debugPrint("TODO: Delete item from message.")
                } label: {
                    Image(systemName: "trash")
                        .padding(8)
                        .background(.red)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
                .padding(6)
            }
            .overlay {
                if media.type == .video && image != nil {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .padding()
                        .background {
                            Circle()
                                .fill(.black)
                                .opacity(0.72)
                        }
                }
            }
            .overlay {
                if image == nil {
                    ProgressView()
                        .tint(.white)
                }
            }
            .onAppear {
                media.getData()
                    .sink { data in
                        guard let data = data else { return }
                        self.image = UIImage(data: data)
                    }
                    .store(in: &subscriptions)
            }
            .onDisappear {
                subscriptions.removeAll()
            }
    }

    @ViewBuilder
    var content: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .clipped()
        } else {
            Rectangle()
                .fill(Color.black.opacity(0.33))
                .aspectRatio(1, contentMode: .fill)
        }
    }
}

struct MediaCell_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Spacer()
            MediaCell(media: .random)
            MediaCell(media: .random)
            Spacer()
        }
    }
}
