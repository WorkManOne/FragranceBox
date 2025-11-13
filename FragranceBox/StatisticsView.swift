import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var userService: UserService
    
    var averageRating: Double {
        let ratedFragrances = userService.fragrances.filter { $0.rating > 0 }
        guard !ratedFragrances.isEmpty else { return 0 }
        return Double(ratedFragrances.reduce(0) { $0 + $1.rating }) / Double(ratedFragrances.count)
    }
    
    var mostUsedSeason: Season {
        let seasons = userService.fragrances.map { $0.season }
        let counts = Dictionary(grouping: seasons, by: { $0 }).mapValues { $0.count }
        return counts.max(by: { $0.value < $1.value })?.key ?? .all
    }
    
    var mostCommonNote: NoteType {
        let allNotes = userService.fragrances.flatMap { $0.topNotes + $0.heartNotes + $0.baseNotes }
        let counts = Dictionary(grouping: allNotes, by: { $0 }).mapValues { $0.count }
        return counts.max(by: { $0.value < $1.value })?.key ?? .vanilla
    }
    
    var totalLayeringRecipes: Int {
        userService.layeringRecipes.count
    }
    
    var favoriteLayeringRecipes: Int {
        userService.layeringRecipes.filter { $0.isFavorite }.count
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Overview")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.brownMain)

                        HStack(spacing: 15) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(userService.fragrances.count)")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundStyle(.greenMain)
                                Text("Fragrances")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(.brownMain.opacity(0.7))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lightFramed()
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(userService.fragrances.filter { $0.isWishlist }.count)")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundStyle(.greenMain)
                                Text("Wishlist")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(.brownMain.opacity(0.7))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lightFramed()
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Layering Lab")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.brownMain)

                        HStack(spacing: 15) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(totalLayeringRecipes)")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundStyle(.greenMain)
                                Text("Total Blends")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(.brownMain.opacity(0.7))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lightFramed()
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(favoriteLayeringRecipes)")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundStyle(.greenMain)
                                Text("Favorites")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(.brownMain.opacity(0.7))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lightFramed()
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Preferences")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.brownMain)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Average Rating")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(.brownMain)
                            HStack(spacing: 4) {
                                Text("\(averageRating, format: .number.precision(.fractionLength(1)))")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundStyle(.greenMain)
                                ForEach(1...5, id: \.self) { index in
                                    Image(systemName: index <= Int(averageRating) ? "star.fill" : "star")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundStyle(index <= Int(averageRating) ? .greenMain : .lightBrownMain)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lightFramed()
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Favorite Season")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(.brownMain)
                            Text(mostUsedSeason.rawValue)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(.greenMain)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lightFramed()
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Most Common Note")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(.brownMain)
                            Text(mostCommonNote.rawValue)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(.greenMain)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lightFramed()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, getSafeAreaTop() + 100)
                .padding(.bottom, getSafeAreaBottom() + 120)
            }
        }
        .customHeader(title: "Statistics")
    }
}

