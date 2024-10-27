//
//  BedrockView.swift
//  BedrockSwift
//
//  Created by Rashwan Lazkani on 2024-10-25.
//

import SwiftUI

struct BedrockView: View {
    
    @StateObject var apiService = APIService()
    @State private var prompt: String = ""
    @State private var selectedType = 0
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    VStack {
                        ForEach(apiService.messages.indices, id: \.self) { index in
                            if apiService.messages[index].isImage, let image = apiService.messages[index].image {
                                HStack {
                                    Spacer()
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 200)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .cornerRadius(10)
                                        .padding(.vertical, 5)
                                }
                            } else if let text = apiService.messages[index].text {
                                HStack {
                                    if apiService.messages[index].isUser {
                                        Spacer()
                                        Text(text)
                                            .padding(.vertical, 6)
                                            .padding(.horizontal, 12)
                                            .background(Color.blue.opacity(0.2))
                                            .cornerRadius(10)
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                    } else {
                                        Text(text)
                                            .padding(.vertical, 6)
                                            .padding(.horizontal, 12)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(10)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                .padding(.vertical, 1)
                            }
                        }
                        if isLoading {
                            ProgressView()
                                .padding(.vertical, 20)
                        }
                    }
                    .padding(.horizontal)
                    .id("BOTTOM")
                }
                .onChange(of: apiService.messages) { _ in
                    withAnimation {
                        scrollViewProxy.scrollTo("BOTTOM", anchor: .bottom)
                    }
                }
            }
            
            VStack {
                TextField("Enter prompt...", text: $prompt)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .padding(.vertical, 10)

                HStack {
                    Picker(selection: $selectedType, label: Text("Type")) {
                        Text("Text").tag(0)
                        Text("Image").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 10)

                    Button(action: {
                        if prompt.isEmpty { return }
                        apiService.addUserPrompt(prompt)
                        let type = selectedType == 0 ? "text" : "image"
                        isLoading = true
                        apiService.sendRequest(prompt: prompt, type: type) {
                            isLoading = false
                        }
                        prompt = ""
                    }) {
                        Text("Send")
                            .frame(width: 100, height: 2)
                            .padding()
                            .background(Color.primary)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BedrockView()
    }
}

