//
//  URLRowView.swift
//  HarvardCS50X
//
//  Created by Alaa Emam on 4/30/25.
//

import SwiftUI

struct URLRowView: View {
    var item: URLItem
    var onDelete: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title ?? item.urlString)
                    .font(.headline)
                    .lineLimit(1)

                if let domain = item.domain {
                    Text(domain)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                if let comment = item.comment {
                    Text(comment)
                        .font(.footnote)
                        .italic()
                        .foregroundColor(.gray)
                }
            }

            Spacer()

            Button {
                if let url = URL(string: item.urlString) {
                    NSWorkspace.shared.open(url)
                }
            } label: {
                Image(systemName: "arrow.up.right.square")
            }
            .buttonStyle(.plain)
            .help("Open in browser")

            Button {
                onDelete()
            } label: {
                Image(systemName: "trash")
            }
            .buttonStyle(.plain)
            .foregroundColor(.red)
            .help("Delete URL")
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.05)))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
        .onHover { hovering in
            NSCursor.pointingHand.set()
        }
    }
}
