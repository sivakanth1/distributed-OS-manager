# Distributed OS Manager

## Overview:

The Distributed OS Manager is a web application designed for real-time monitoring and management of distributed operating systems. Built with Flutter, it provides a responsive interface for centralized control over networked nodes, enabling system administrators to perform tasks like node modification, process management, and network configuration seamlessly across different devices and platforms.

## Features:

1. User Authentication
2. Real-time Node Monitoring
3. Resource Management
4. Network Configuration
5. Responsive UI for Cross-Platform Access
6. Firebase Integration for Backend Services

## Prerequisites:

Before running the project, ensure you have the following installed:

1. Flutter SDK
2. Android Studio or your preferred IDE for Flutter development
3. An active Firebase project for backend services

## Getting Started:

1. Clone the repository:

git clone https://github.com/sivakanth1/distributed-os-manager.git
cd distributed-os-manager

2. Install dependencies:
In the project directory, run:

flutter pub get

3. Firebase setup:

Set up your Firebase project and download the google-services.json file. Place it in the appropriate directory (the root of the project for web).

4. Run the application:
Ensure an emulator is running or a device is connected and run:

flutter run

## Architecture:
The application follows the Model-View-Controller (MVC) architecture pattern, ensuring a separation of concerns and easier maintainability.

## Build:

- To build the application for production, run:

flutter build web --release
