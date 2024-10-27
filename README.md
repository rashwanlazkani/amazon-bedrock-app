# AI-Powered iOS Chat App with Amazon Bedrock and Swift

This repository contains the code for a native iOS app built with Swift, leveraging Amazon Bedrock to power chat and image generation capabilities. The app provides a sleek, user-friendly interface that enables users to interact with AI-driven features through text prompts and image generation.

**Final result**:
<p align="center"><img width="300" alt="iOS app with Amazon Bedrock" src="https://github.com/user-attachments/assets/04b0ca49-d820-40a6-9e05-baac636171db"></p>


## Features

- **AI-Powered Chat**: Chat with the app to receive AI-generated responses powered by Amazon Bedrock.
- **Image Generation**: Enter a description to generate unique images using Amazon Bedrock’s image generation models.
- **Backend Integration**: The app connects to a serverless backend hosted on AWS, making use of Lambda functions for processing.

## Architecture

The app is designed to work with a serverless backend. Key components include:

- **Amazon Bedrock**: For AI chat and image generation capabilities.
- **AWS Lambda**: Serverless backend processing.
- **Amazon API Gateway**: Manages API requests between the app and the backend.

For the backend setup, visit the backend repository: [amazon-bedrock-back](https://github.com/rashwanlazkani/amazon-bedrock-back).

## Getting Started

### Prerequisites

- **Backend Deployment**: First, deploy the backend following the instructions in the [backend repository](https://github.com/rashwanlazkani/amazon-bedrock-back). Ensure you have the API endpoints after deployment.
- **Xcode**: To build and run the app on a simulator or a physical device.
- **Swift**: The app is built using Swift and requires a macOS environment to run.

### Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/rashwanlazkani/amazon-bedrock-app
   cd amazon-bedrock-app

2. **Deploy the Backend**: Follow the backend setup instructions to deploy the serverless backend on AWS. Once deployed, you will receive API endpoints.

3. Configure the App with API Endpoints:
* Open the project in Xcode by double-clicking on iOSApp.xcodeproj.
* In the APIService.swift file, update the `baseURL` with the base URL provided after backend deployment:
```swift
let baseURL = "" // TODO: add your baseURL to your API Gateway here
```

4. **Run the App**:
* Build and run the app on a simulator or a connected device in Xcode.

## Usage
* Text Prompt: Type a message into the chat interface to receive an AI-generated response.
* Image Generation: Switch to image mode, enter a prompt, and receive an AI-generated image based on your description.

## Example Prompts
* Text: "What are three interesting facts about the ocean?"
* Image: "Generate an image of a mountain landscape with a lake."

## Additional Resources
The backend code can be found in the [amazon-bedrock-back repository](https://github.com/rashwanlazkani/amazon-bedrock-back).

## Contributing
Contributions are welcome! Please submit a pull request or open an issue to discuss any changes.

## License
This project is licensed under the MIT License.
