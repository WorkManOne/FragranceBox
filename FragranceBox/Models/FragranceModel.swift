import Foundation
import SwiftUI

struct FragranceModel: Identifiable, Hashable, Codable, Equatable {
    var id: UUID = UUID()
    var name: String = ""
    var brand: String = ""
    var imageData: Data?
    var description: String = ""
    var topNotes: [NoteType] = []
    var heartNotes: [NoteType] = []
    var baseNotes: [NoteType] = []
    var whenToWear: [WearTime] = []
    var whereToWear: [WearPlace] = []
    var season: Season = .all
    var remainingAmount: Double = 100.0
    var bottleSize: Double = 100.0
    var isWishlist: Bool = false
    var similarFragrances: [UUID] = []
    var rating: Int = 0
    var dateAdded: Date = Date()
}

struct LayeringRecipeModel: Identifiable, Hashable, Codable, Equatable {
    var id: UUID = UUID()
    var title: String = ""
    var baseFragranceId: UUID?
    var companionFragranceId: UUID?
    var ratio: Double = 0.5
    var applyDate: Date = Date()
    var ambiance: LayeringAmbiance = .daytimeElegance
    var projectionFocus: ProjectionFocus = .balanced
    var longevityTarget: LongevityTarget = .allDay
    var moodTags: [LayeringMood] = []
    var isFavorite: Bool = false
    var notes: String = ""
}

enum NoteType: String, Codable, CaseIterable {
    case bergamot = "Bergamot"
    case lemon = "Lemon"
    case orange = "Orange"
    case grapefruit = "Grapefruit"
    case lavender = "Lavender"
    case rose = "Rose"
    case jasmine = "Jasmine"
    case lily = "Lily"
    case vanilla = "Vanilla"
    case sandalwood = "Sandalwood"
    case cedar = "Cedar"
    case patchouli = "Patchouli"
    case musk = "Musk"
    case amber = "Amber"
    case tonka = "Tonka Bean"
    case vetiver = "Vetiver"
    case oud = "Oud"
    case leather = "Leather"
    case tobacco = "Tobacco"
    case pepper = "Pepper"
    case cinnamon = "Cinnamon"
    case cardamom = "Cardamom"
}

enum WearTime: String, Codable, CaseIterable {
    case morning = "Morning"
    case afternoon = "Afternoon"
    case evening = "Evening"
    case night = "Night"
}

enum WearPlace: String, Codable, CaseIterable {
    case work = "Work"
    case casual = "Casual"
    case formal = "Formal"
    case date = "Date"
    case party = "Party"
    case sport = "Sport"
    case home = "Home"
}

enum Season: String, Codable, CaseIterable {
    case spring = "Spring"
    case summer = "Summer"
    case autumn = "Autumn"
    case winter = "Winter"
    case all = "All Seasons"
}

enum Currency: String, Codable, CaseIterable {
    case usd = "USD"
    case eur = "EUR"
    case gbp = "GBP"
    case rub = "RUB"
}

enum LayeringAmbiance: String, Codable, CaseIterable {
    case daytimeElegance = "Daytime Elegance"
    case intimateSoiree = "Intimate Soirée"
    case weekendBrunch = "Weekend Brunch"
    case creativeStudio = "Creative Studio"
    case twilightEvent = "Twilight Event"
}

enum ProjectionFocus: String, Codable, CaseIterable {
    case subtle = "Subtle"
    case balanced = "Balanced"
    case bold = "Bold"
}

enum LongevityTarget: String, Codable, CaseIterable {
    case shortBurst = "2-4h"
    case workday = "6-8h"
    case allDay = "10-12h"
    case allNight = "12h+"
}

enum LayeringMood: String, Codable, CaseIterable {
    case romantic = "Romantic"
    case energizing = "Energizing"
    case sophisticated = "Sophisticated"
    case cozy = "Cozy"
    case adventurous = "Adventurous"
    case playful = "Playful"
}

