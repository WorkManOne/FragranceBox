import SwiftUI

struct OnboardingView: View {
    var onComplete: () -> Void

    private let highlights: [OnboardingHighlight] = [
        OnboardingHighlight(icon: "sparkles", title: "Curate Signature Scents", description: "Document every perfume with notes, wear moments, and bottle status so your collection always stays organized."),
        OnboardingHighlight(icon: "calendar", title: "Track Purchase History", description: "Record prices, stores, and refill reminders to understand the story behind each fragrance."),
        OnboardingHighlight(icon: "heart", title: "Build Smart Wishlists", description: "Plan future acquisitions, compare similar aromas, and spot gaps in your wardrobe."),
        OnboardingHighlight(icon: "chart.bar", title: "Visualize Your Style", description: "Seasonal insights and note analytics highlight the accords you gravitate toward the most.")
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 30) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Welcome to FragranceBox")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(.black)
                            Text("Craft a refined perfume library tailored to your mood, moment, and memory.")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(.brownMain.opacity(0.7))
                        }
                        .lightFramed()

                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(highlights) { item in
                                HStack(alignment: .top, spacing: 16) {
                                    Image(systemName: item.icon)
                                        .font(.system(size: 28, weight: .semibold))
                                        .foregroundStyle(.greenMain)
                                        .frame(width: 44, height: 44)
                                        .background(
                                            Circle()
                                                .fill(.greenMain.opacity(0.15))
                                        )
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(item.title)
                                            .font(.system(size: 18, weight: .semibold))
                                            .foregroundStyle(.black)
                                        Text(item.description)
                                            .font(.system(size: 14, weight: .regular))
                                            .foregroundStyle(.brownMain.opacity(0.7))
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lightFramed()
                            }
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            Text("Quick Tips")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(.black)
                            VStack(alignment: .leading, spacing: 12) {
                                OnboardingTipView(title: "Use tags for wear occasions", detail: "Tap wear moments inside each fragrance to plan office, date night, or travel rotations.")
                                OnboardingTipView(title: "Monitor bottle levels", detail: "Update percentages regularly to schedule refills and avoid surprises before special events.")
                                OnboardingTipView(title: "Link similar aromas", detail: "Connect fragrances by tonal family to compare accords before your next purchase.")
                            }
                        }
                        .lightFramed()

                        Button {
                            onComplete()
                        } label: {
                            Text("Start My Collection")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.white)
                                .colorFramed(color: .greenMain)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, getSafeAreaTop() + 100)
                    .padding(.bottom, getSafeAreaBottom() + 40)
                }
            }
            .customHeader(title: "Getting Started")
        }
    }
}

private struct OnboardingHighlight: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let description: String
}

private struct OnboardingTipView: View {
    let title: String
    let detail: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.black)
            Text(detail)
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.brownMain.opacity(0.7))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .darkFramed(isBordered: true)
    }
}
