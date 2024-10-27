//
//  APIService.swift
//  BedrockSwift
//
//  Created by Rashwan Lazkani on 2024-10-25.
//

import UIKit

class APIService: ObservableObject {
    
    @Published var messages: [ChatMessage] = []
    
    private func getEndpointURL(for type: String) -> URL? {
        let baseURL = "" // TODO: add your baseURL to your API Gateway here
        
        switch type {
        case "text":
            return URL(string: "\(baseURL)/text")
        case "image":
            return URL(string: "\(baseURL)/image")
        default:
            return nil
        }
    }

    func addUserPrompt(_ prompt: String) {
        messages.append(ChatMessage(text: prompt, image: nil, isImage: false, isUser: true))
    }
        
    func sendRequest(prompt: String, type: String, completion: @escaping () -> Void) {
        guard let url = getEndpointURL(for: type) else {
            print("Invalid URL for type: \(type)")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String: Any] = ["prompt": prompt]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else { return }
            print(data)
            
            DispatchQueue.main.async {
                if type == "text" {
                    if let responseString = String(data: data, encoding: .utf8) {
                        let trimmedResponse = responseString.trimmingCharacters(in: .whitespacesAndNewlines)
                        self.messages.append(ChatMessage(text: trimmedResponse, image: nil, isImage: false, isUser: false))
                    }
                } else {
                    DispatchQueue.main.async {
                        if let base64String = String(data: data, encoding: .utf8),
                           let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters),
                           let image = UIImage(data: imageData) {
                            
                            DispatchQueue.main.async {
                                self.messages.append(ChatMessage(text: nil, image: image, isImage: true, isUser: false))
                            }
                        }
                    }
                }
                completion()
            }
        }.resume()
    }
}
