//
//  RoverImageModel.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 17.12.2022.
//

import Foundation

// MARK: - RoverImageModel
struct RoverImageModel: Codable, Hashable {
    var photos: [Photo]
}


// MARK: - Photo
struct Photo: Codable, Hashable {
    var id: Int?
    var sol: Int?
    var camera: Camera?
    var imgSrc: String?
    var earthDate: String?
    var rover: Rover?
}


// MARK: - Camera
struct Camera: Codable, Hashable {
    var id: Int?
    var name: String?
    var roverID: Int?
    var fullName: String?
}


// MARK: - Rover
struct Rover: Codable, Hashable {
    var id: Int?
    var name: String?
    var landingDate: String?
    var launchDate: String?
    var status: String?
}


