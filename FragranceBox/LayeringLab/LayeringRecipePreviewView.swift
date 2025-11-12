import SwiftUI

struct LayeringRecipePreviewView: View {
    @EnvironmentObject var userService: UserService
    let recipe: LayeringRecipeModel

    private func fragranceName(for id: UUID?) -> String {
        guard let id,
              let fragrance = userService.fragrances.first(where: { $0.id == id }) else {
            return "Select fragrance"
        }
        return fragrance.name.isEmpty ? "Untitled fragrance" : fragrance.name
    }

    private var ratioText: String {
        let basePercent = Int((1 - recipe.ratio) * 100)
        let companionPercent = Int(recipe.ratio * 100)
        return "\(basePercent)% / \(companionPercent)%"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: recipe.isFavorite ? "heart.fill" : "wand.and.stars")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(recipe.isFavorite ? .greenMain : .brownMain.opacity(0.7))
                    .frame(width: 44, height: 44)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.bgBrownMain)
                    )
                Text(recipe.title.isEmpty ? "New Layer" : recipe.title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.leading)
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text(ratioText)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.greenMain)
                    Text(recipe.ambiance.rawValue)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.brownMain.opacity(0.7))
                        .multilineTextAlignment(.trailing)
                }
            }
            Text("\(fragranceName(for: recipe.baseFragranceId)) + \(fragranceName(for: recipe.companionFragranceId))")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.brownMain.opacity(0.8))
                .multilineTextAlignment(.leading)
            if !recipe.moodTags.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(recipe.moodTags, id: \.self) { mood in
                            Text(mood.rawValue)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(.greenMain)
                                )
                        }
                    }
                    .padding(.horizontal, 20)
                }.padding(.horizontal, -20)
            }

            HStack(spacing: 12) {
                Label(recipe.projectionFocus.rawValue, systemImage: "waveform")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.brownMain.opacity(0.7))
                Label(recipe.longevityTarget.rawValue, systemImage: "hourglass")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.brownMain.opacity(0.7))
                Spacer()
                Text(recipe.applyDate.formatted(date: .abbreviated, time: .omitted))
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.brownMain.opacity(0.5))
            }
        }
        .lightFramed(isBordered: true)
    }
}
