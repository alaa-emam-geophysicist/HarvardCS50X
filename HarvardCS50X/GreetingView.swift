//
//  GreetingView.swift
//  HarvardCS50X
//
//  Created by Alaa Emam on 4/30/25.
//

import SwiftUI

struct GreetingView: View {
    @ObservedObject var model = AppModel.shared
    @State private var show = true
    @State private var opacity = 0.0

    var body: some View {
        if show {
            ZStack {
                VisualEffectView(material: .menu, blendingMode: .withinWindow)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    if let image = model.profileImage {
                        Image(nsImage: image)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 120, height: 120)
                            .shadow(radius: 10)
                    }

                    Text("Welcome, \(model.appData.userName ?? "Friend")!")
                        .font(.largeTitle)
                        .bold()
                        .transition(.opacity)

                    Text("Let's crush Harvard CS50X 💻")
                        .font(.title2)
                        .opacity(0.8)

                    Text("Loading...")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.ultraThinMaterial)
                        .shadow(radius: 5)
                )
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1)) {
                        opacity = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                        withAnimation {
                            show = false
                        }
                    }
                }
            }
        }
    }
}
