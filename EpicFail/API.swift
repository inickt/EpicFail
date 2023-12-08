//
//  API.swift
//  EpicFail
//
//  Created by Nick Thompson on 12/7/23.
//

import Foundation

// MARK: - Maps

typealias Maps = [Map]

struct Map: Codable, Identifiable, Hashable, Equatable {
    var id: String { mapName }

    let mapName: String
    let trails: [Trail]
    let lifts: [Lift]
    let webcams: [Webcam]
    let restaurants: [Restaurant]
    let skiPatrol: [SkiPatrol]?
    let wayNameSize: Double
    let wayNameZoomLevel: Int
    let wayWidth: Double
    let triangulation: Triangulation
    let trailZoomLevel: Int
    let imageData: ImageData
    let lumiplanMapId: String
}

struct Trail: Codable, Identifiable, Hashable, Equatable {
    var id: Int { data.id }

    struct Data: Codable, Hashable, Equatable {
        let id: Int
        let name: String
        let namePosition: Point
        let nameRotation: Int
        let paths: [Path]?
        let trailLevel: TrailLevel
        let sector: String
        let groomingStatus: GroomingStatus
        let openingStatus: TrailOpeningStatus?
        let description: String?
        let exposure: String?
        let averageSlope, arrivalAltitude: Double?
        let length: Double?
        let openingTimesTheoretic: [OpeningTimesTheoretic]?
        let guaranteedSnow: Bool?
    }

    let x: Double
    let y: Double
    let data: Data
}

struct Lift: Codable, Hashable, Equatable {
    struct Data: Codable, Hashable, Equatable {
        let id: Int
        let name: String
        let type: String
        let namePosition: Point
        let nameRotation: Int
        let paths: [Path]
        let openingTimesTheoretic: [OpeningTimesTheoretic]?
        let description: String?
        let liftType: LiftType
        let capacity: Int?
        let length: Double?
        let uphillCapacity: Int?
        let waitingMax: Int?
        let downloading: Bool
        let sector: String
        let rideTime: Int
        let openingStatus: LiftOpeningStatus
        let trailsServed: [TrailsServed]
        let waitTimeStatus: WaitTimeStatus
        let duration: Int?
        let waiting: Int?
        let arrivalAltitude: Double?
        let departureAltitude: Double?
        let speed: Double?
        let exposure: String?
    }

    let x: Double
    let y: Double
    let data: Data
}

enum LiftOpeningStatus: String, Codable, Hashable, Equatable {
    case closed = "CLOSED"
    case onHold = "ON_HOLD"
    case openingStatusOPEN = "OPEN"
    case scheduled = "SCHEDULED"
}

enum LiftType: String, Codable, Hashable, Equatable {
    case chairlift = "CHAIRLIFT"
    case detachableChairlift = "DETACHABLE_CHAIRLIFT"
    case gondola = "GONDOLA"
    case magicCarpet = "MAGIC_CARPET"
    case ropeTow = "ROPE_TOW"
    case surfaceLift = "SURFACE_LIFT"
    case tram = "TRAM"
}

enum WaitTimeStatus: String, Codable, Hashable, Equatable {
    case active = "ACTIVE"
    case calculating = "CALCULATING"
    case disabled = "DISABLED"
}

struct ImageData: Codable, Hashable, Equatable {
    let path: String
    let url: String
    let title: String
    let smartCrop: String
    let displayTitle: String
    let width: Int
    let height: Int
}

struct TrailsServed: Codable, Hashable, Equatable {
    let id: String
    let name: String
    let trailLevel: TrailLevel
    let openingStatus: TrailOpeningStatus
    let groomingStatus: GroomingStatus
    let sector: String
}

struct Point: Codable, Hashable, Equatable {
    let x: Double
    let y: Double
}

enum TrailOpeningStatus: String, Codable, Hashable, Equatable {
    case closed = "CLOSED"
    case delayed = "DELAYED"
    case forecast = "FORECAST"
    case openingStatusOPEN = "OPEN"
    case outOfPeriod = "OUT_OF_PERIOD"
    case stopped = "STOPPED"
}

struct OpeningTimesTheoretic: Codable, Hashable, Equatable {
    let beginTime: String?
    let endTime: String
}

struct Path: Codable, Hashable, Equatable {
    let points: [Point]?
}

struct Restaurant: Codable, Hashable, Equatable {
    let x: Double
    let y: Double
    let data: RestaurantData
}

struct RestaurantData: Codable, Hashable, Equatable {
    let id: String
    let title: String
    let subtitle: String
    let imageUrl: String
    let supportsMyEpicGear: Bool?
    let location: Location
    let website: String
    let links: [Link]
    let hours: [Hours]
    let phoneNumber: [PhoneNumber]
    let closedForTheSeason: Bool
    let epicMountainRewardsEligible: Bool
    let payment_options: [PaymentOption]
}

struct Hours: Codable, Hashable, Equatable {
    let closingTime: String
    let daysOfTheWeek: [DaysOfTheWeek]
    let openingTime: String

    enum CodingKeys: String, CodingKey {
        case closingTime = "closing_time"
        case daysOfTheWeek = "days_of_the_week"
        case openingTime = "opening_time"
    }
}

enum DaysOfTheWeek: String, Codable, Hashable, Equatable {
    case sunday = "Sunday"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
}

struct Link: Codable, Hashable, Equatable {
    let linkType: String
    let linkURL: String

    enum CodingKeys: String, CodingKey {
        case linkType = "link_type"
        case linkURL = "link_url"
    }
}

struct Location: Codable, Hashable, Equatable {
    let address: Address
    let latitude: Double
    let longitude: Double
}

struct Address: Codable, Hashable, Equatable {
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

struct PhoneNumber: Codable, Hashable, Equatable {
    let description, phoneNumber: String

    enum CodingKeys: String, CodingKey {
        case description
        case phoneNumber = "phone_number"
    }
}

struct SkiPatrol: Codable, Hashable, Equatable {
    let x: Double
    let y: Double
    let data: SkiPatrolData
}

struct SkiPatrolData: Codable, Hashable, Equatable {
    let id: String
    let title: String
    let subtitle: String
    let imageUrl: String
    let location: Location
    let website: String
    let phoneNumber: [PhoneNumber]
    let closedForTheSeason: Bool
}

enum GroomingStatus: String, Codable, Hashable, Equatable {
    case groomed = "GROOMED"
    case notGroomed = "NOT_GROOMED"
}

enum TrailLevel: String, Codable, Hashable, Equatable {
    case greenCircle = "GREEN_CIRCLE"
    case blueSquare = "BLUE_SQUARE"
    case blackDiamond = "BLACK_DIAMOND"
    case doubleBlackDiamond = "DOUBLE_BLACK_DIAMOND"
    case doubleBlackDiamondExtreme = "DOUBLE_BLACK_DIAMOND_EXTREM"
    case terrainParks = "TERRAIN_PARKS"
}

struct Triangulation: Codable, Hashable, Equatable {
    let triangles: [[Int]]
    let points: [Point]
}

struct GPSPoint: Codable, Hashable, Equatable {
    let x: Double
    let y: Double
    let lng: Double
    let lat: Double
}

struct Webcam: Codable, Hashable, Equatable {
    let id: Int
    let x: Double
    let y: Double
    let data: WebcamData
}

struct WebcamData: Codable, Hashable, Equatable {
    let id: Int
    let name: String
    let normalDefLink: String
    let highDefLink: String
    let lowDefLink: String
    let thumbnailDefLink: String
    let latitude: Double?
    let longitude: Double?
    let description: String?
}

enum PaymentOption: String, Codable, Hashable, Equatable {
    case applePay = "Apple Pay"
    case creditCard = "Credit Card"
    case googlePay = "Google Pay"
    case resortCharge = "Resort Charge"
}

// MARK: - Resorts

typealias Resorts = [Resort]

struct Resort: Codable, Identifiable, Hashable, Equatable {
    var id: String { resortId }

    struct Location: Codable, Hashable, Equatable {
        let city: String
        let state: String
        let latitude: String
        let longitude: String
        let elevation: String
    }

    struct BrandColor: Codable, Hashable, Equatable {
        let backgroundColor: String
        let lightText: Bool
    }

    struct PrimaryMap: Codable, Hashable, Equatable {
        let name: String
        let id: String
    }

    struct SupportDetails: Codable, Hashable, Equatable {
        struct PhoneNumber: Codable, Hashable, Equatable {
            let description: String
            let number: String
        }

        let phoneNumber: PhoneNumber
    }

    let resortId: String
    let title: String
    let displayName: String
    let logo: String
    let extendedLogo: String
    let primaryImage: String
    let location: Location
    let brandColor: BrandColor
    let waitTimesAvailable: Bool
    let primaryMap: PrimaryMap
    let supportDetails: SupportDetails
}
