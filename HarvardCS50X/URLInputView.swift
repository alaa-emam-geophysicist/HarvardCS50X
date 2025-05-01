//
//  URLInputView.swift
//  HarvardCS50X
//
//  Created by Alaa Emam on 4/30/25.
//

import SwiftUI

struct URLInputView: View {
    @Binding var urls: [URLItem]

    @State private var urlText: String = ""
    @State private var commentText: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text("Add a New Resource")
                .font(.headline)
                
            
            TextField("Enter URL...", text: $urlText)
                .background(Color.clear.opacity(0.5)) // 50% transparent white
                    .cornerRadius(8)
                    .onSubmit { handleAdd() }
            
            TextField("Comment (optional)...", text: $commentText)
                .background(Color.clear.opacity(0.5)) // 50% transparent white
                    .cornerRadius(8)
                    .onSubmit { handleAdd() }


            
            Button("Add URL") {
                handleAdd()
            }
//            .buttonStyle(.borderedProminent)
            .buttonStyle(.automatic)
            .foregroundColor(.primary)
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))

    }

    func handleAdd() {
        // Ensure the URL starts with a valid scheme
        var formattedURLText = urlText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !formattedURLText.hasPrefix("http://") && !formattedURLText.hasPrefix("https://") {
            formattedURLText = "https://" + formattedURLText
        }

        guard let url = URL(string: formattedURLText), url.host != nil else {
            print("❌ Invalid URL format")
            return
        }

        Task {
            let title = await fetchPageTitle(from: url)
            let domain = url.host

            let newItem = URLItem(
                urlString: formattedURLText,
                title: title ?? formattedURLText,
                domain: domain,
                comment: commentText.isEmpty ? nil : commentText
            )


            DispatchQueue.main.async {
                urls.append(newItem)
                AppModel.shared.appData.urls = urls
                urlText = ""
                commentText = ""
            }
        }
    }

    func fetchPageTitle(from url: URL) async -> String? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("⚠️ HTTP response error")
                return nil
            }

            if let html = String(data: data, encoding: .utf8),
               let titleStart = html.range(of: "<title>", options: .caseInsensitive),
               let titleEnd = html.range(of: "</title>", options: .caseInsensitive) {
                return String(html[titleStart.upperBound..<titleEnd.lowerBound])
                    .trimmingCharacters(in: .whitespacesAndNewlines)
            } else {
                print("⚠️ Title tag not found in HTML")
            }
        } catch {
            print("❌ Error fetching title:", error.localizedDescription)
        }
        return nil
    }

}
