//
//  SafariView.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 20.05.25.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}


#Preview {
    SafariView(url: URL(string: "https://www.apple.com")!)
}
