//
//  GiphyDisplayView.swift
//  
//
//  Created by Vito Royeca on 6/20/24.
//

import SwiftUI
import GiphyUISDK

public struct GiphyDisplayView: UIViewRepresentable {
    public let giphyId: String
    
    public init(giphyId: String) {
        self.giphyId = giphyId
    }

    public func makeUIView(context: Context) -> GPHMediaView {
        let mediaView = GPHMediaView()
        
        return mediaView
    }
    
    public func updateUIView(_ uiView: GPHMediaView, context: Context) {
        GiphyCore.shared.gifByID(giphyId) { (response, error) in
            if let media = response?.data {
                DispatchQueue.main.sync {
                    uiView.media = media
                }
            }
        }
    }
}
