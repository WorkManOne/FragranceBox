import Foundation
import SwiftUI

class UserService: ObservableObject {
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true

    @Published var fragrances: [FragranceModel] {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(fragrances), forKey: "fragrances")
        }
    }

    @Published var layeringRecipes: [LayeringRecipeModel] {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(layeringRecipes), forKey: "layeringRecipes")
        }
    }

    init() {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.data(forKey: "fragrances"),
           let decoded = try? JSONDecoder().decode([FragranceModel].self, from: data) {
            fragrances = decoded
        } else {
            fragrances = []
        }
        if let data = userDefaults.data(forKey: "layeringRecipes"),
           let decoded = try? JSONDecoder().decode([LayeringRecipeModel].self, from: data) {
            layeringRecipes = decoded
        } else {
            layeringRecipes = []
        }
    }

    func reset() {
        isFirstLaunch = true
        fragrances = []
        layeringRecipes = []
    }
}

