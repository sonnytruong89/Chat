//
//  GiphyPicker.swift
//  
//
//  Created by Vito Royeca on 6/20/24.
//

import SwiftUI
import GiphyUISDK

struct GiphyPickerView: UIViewControllerRepresentable {
    let apiKey: String
    @ObservedObject var inputViewModel: InputViewModel
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<GiphyPickerView>) -> GiphyViewController {
        let giphy = GiphyViewController()
        GiphyViewController.trayHeightMultiplier = 1.0
        giphy.swiftUIEnabled = true
        giphy.shouldLocalizeSearch = true
        giphy.dimBackground = true
        giphy.modalPresentationStyle = .pageSheet
        giphy.showConfirmationScreen = true
        giphy.delegate = context.coordinator
        return giphy
    }
    
    func updateUIViewController(_ uiViewController: GiphyViewController,
                                context: UIViewControllerRepresentableContext<GiphyPickerView>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, GiphyDelegate {
        var parent: GiphyPickerView

        init(_ parent: GiphyPickerView) {
            self.parent = parent
        }
        
       func didSelectMedia(giphyViewController: GiphyViewController, media: GPHMedia)   {
           parent.inputViewModel.attachments.giphyId = media.id
           parent.inputViewModel.state = .hasGiphy
           parent.inputViewModel.send()
           giphyViewController.dismiss(animated: true, completion: nil)
       }

       func didDismiss(controller: GiphyViewController?) {
           // your user dismissed the controller without selecting a GIF.
           parent.inputViewModel.attachments.giphyId = nil
           parent.inputViewModel.state = .empty
       }
    }
}
