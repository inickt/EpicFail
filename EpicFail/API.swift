//
//  API.swift
//  EpicFail
//
//  Created by Nick Thompson on 12/7/23.
//

import Foundation

typealias Maps = [Map]

struct Map: Codable {
    let mapName: String
    let trails: [Trail]
    let lifts: [Lift]
    let webcams: [Webcam]
    let restaurants: [Restaurant]
    let skiPatrol: [SkiPatrol]
    let wayNameSize: Double
    let wayNameZoomLevel: Int
    let wayWidth: Double
    let triangulation: Triangulation
    let trailZoomLevel: Int
    let imageData: ImageData
}

struct Trail: Codable, Identifiable {
    var id: Int { data.id }

    struct Data: Codable {
        let id: Int
        let name: String
        let namePosition: Point
        let nameRotation: Int
        let paths: [Path]?
        let trailLevel: TrailLevel
        let sector: String
        let groomingStatus: GroomingStatus
        let openingStatus: OpeningStatus
        let description: String?
        let exposure: String?
    }

    let x: Double
    let y: Double
    let data: Data
}

struct Lift: Codable {
    struct Data: Codable {
        let id: Int
        let name: String
        let type: String
        let namePosition: Point
        let nameRotation: Int
        let paths: [Path]
        let openingTimesTheoretic: [OpeningTimesTheoretic]?
        let description: String?
        let liftType: String
        let capacity: Int?
        let length: Double?
        let uphillCapacity: Int?
        let waitingMax: Int
        let downloading: Bool
        let sector: String
        let rideTime: Int
        let openingStatus: OpeningStatus
        let trailsServed: [TrailsServed]
        let waitTimeStatus: WaitTimeStatus
        let duration: Int?
        let waiting: Int?
    }

    let x: Double
    let y: Double
    let data: Data
}

enum WaitTimeStatus: String, Codable {
    case active = "ACTIVE"
    case disabled = "DISABLED"
}

struct ImageData: Codable {
    let path: String
    let url: String
    let title: String
    let smartCrop: String
    let displayTitle: String
    let width: Int
    let height: Int
}

struct TrailsServed: Codable {
    let id: String
    let name: String
    let trailLevel: TrailLevel
    let openingStatus: OpeningStatus
    let groomingStatus: GroomingStatus
    let sector: String
}

struct Point: Codable {
    let x: Double
    let y: Double
}

enum OpeningStatus: String, Codable {
    case closed = "CLOSED"
    case open = "OPEN"
    case scheduled = "SCHEDULED"
}

struct OpeningTimesTheoretic: Codable {
    let beginTime: String
    let endTime: String
}

struct Path: Codable {
    let points: [Point]
}

struct Restaurant: Codable {
    let x: Double
    let y: Double
    let data: RestaurantData
}

struct RestaurantData: Codable {
    let id: String
    let title: String
    let subtitle: String
    let imageUrl: String
    let supportsMyEpicGear: Bool
    let location: Location
    let website: String
    let links: [Link]
    let hours: [Hours]
    let phoneNumber: [PhoneNumber]
    let closedForTheSeason: Bool
    let epicMountainRewardsEligible: Bool
    let payment_options: [PaymentOption]
}

struct Hours: Codable {
    let closingTime: String
    let daysOfTheWeek: [DaysOfTheWeek]
    let openingTime: String

    enum CodingKeys: String, CodingKey {
        case closingTime = "closing_time"
        case daysOfTheWeek = "days_of_the_week"
        case openingTime = "opening_time"
    }
}

enum DaysOfTheWeek: String, Codable {
    case sunday = "Sunday"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
}

struct Link: Codable {
    let linkType: String
    let linkURL: String

    enum CodingKeys: String, CodingKey {
        case linkType = "link_type"
        case linkURL = "link_url"
    }
}

struct Location: Codable {
    let address: Address
    let latitude: Double
    let longitude: Double
}

struct Address: Codable {
    let street: String
    let city: String
    let stateProvince: String
    let postalCode: String
    let country: String

    enum CodingKeys: String, CodingKey {
        case street, city
        case stateProvince = "state_province"
        case postalCode, country
    }
}

struct PhoneNumber: Codable {
    let description, phoneNumber: String

    enum CodingKeys: String, CodingKey {
        case description
        case phoneNumber = "phone_number"
    }
}

struct SkiPatrol: Codable {
    let x: Double
    let y: Double
    let data: SkiPatrolData
}

struct SkiPatrolData: Codable {
    let id, title, subtitle: String
    let imageUrl: String
    let location: Location
    let website: String
    let phoneNumber: [PhoneNumber]
    let closedForTheSeason: Bool
}

enum GroomingStatus: String, Codable {
    case groomed = "GROOMED"
    case notGroomed = "NOT_GROOMED"
}

enum TrailLevel: String, Codable {
    case greenCircle = "GREEN_CIRCLE"
    case blueSquare = "BLUE_SQUARE"
    case blackDiamond = "BLACK_DIAMOND"
    case doubleBlackDiamond = "DOUBLE_BLACK_DIAMOND"
    case terrainParks = "TERRAIN_PARKS"
}

struct Triangulation: Codable {
    let triangles: [[Int]]
    let points: [Point]
}

struct GPSPoint: Codable {
    let x: Double
    let y: Double
    let lng: Double
    let lat: Double
}

struct Webcam: Codable {
    let id: Int
    let x: Double
    let y: Double
    let data: WebcamData
}

struct WebcamData: Codable {
    let id: Int
    let name: String
    let type: String
    let normalDefLink: String
    let highDefLink: String
    let lowDefLink: String
    let thumbnailDefLink: String
    let latitude: Double?
    let longitude: Double?
}

enum PaymentOption: String, Codable {
    case applePay = "Apple Pay"
    case creditCard = "Credit Card"
    case googlePay = "Google Pay"
    case resortCharge = "Resort Charge"
}
