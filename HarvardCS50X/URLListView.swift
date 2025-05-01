//
//  URLListView.swift
//  HarvardCS50X
//
//  Created by Alaa Emam on 4/30/25.
//

//
//  URLListView.swift
//  HarvardCS50X
//
//  Created by Alaa Emam on 4/30/25.
//

import SwiftUI

struct URLListView: View {
    @ObservedObject var model = AppModel.shared
    @State private var searchText = ""
    @State private var showDeleteAlert = false
    @State private var urlToDelete: URLItem?

    var filteredURLs: [URLItem] {
        if searchText.isEmpty { return model.appData.urls }
        return model.appData.urls.filter {
            ($0.title ?? "").localizedCaseInsensitiveContains(searchText) ||
            ($0.urlString).localizedCaseInsensitiveContains(searchText) ||
            ($0.domain ?? "").localizedCaseInsensitiveContains(searchText) ||
            ($0.comment ?? "").localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                TextField("Search...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Open All") {
                    openAllURLs()
                    
                    
                }
                .buttonStyle(.automatic)
                .foregroundColor(.primary)

                Button(action: openURLFileLocation) {
                    Image(systemName: "folder.fill")
                        .foregroundColor(.primary)
                        .imageScale(.small)
                        .help("Open the folder containing the URL file")
                }
            }

            ScrollView {
                LazyVStack(spacing: 5) {
                    ForEach(filteredURLs) { item in
                        URLRowView(item: item, onDelete: {
                            urlToDelete = item
                            showDeleteAlert = true
                        })
                        .padding(.horizontal)
                    }
                }
            }
        }
        .padding()
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Delete URL?"),
                message: Text("Are you sure you want to delete this URL? Take a moment to think."),
                primaryButton: .destructive(Text("Delete")) {
                    if let toDelete = urlToDelete {
                        model.appData.urls.removeAll { $0.id == toDelete.id }
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }

    func openAllURLs() {
        for item in filteredURLs {
            if let url = URL(string: item.urlString) {
                NSWorkspace.shared.open(url)
            }
        }
    }

    func openURLFileLocation() {
        guard let fileURL = FileManagerHelper.shared.fileURL else {
            print("❌ File URL not found")
            return
        }
        NSWorkspace.shared.activateFileViewerSelecting([fileURL])
    }
}
