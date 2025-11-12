import SwiftUI

struct FragranceView: View {
    @EnvironmentObject var userService: UserService

    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 15) {
                    if userService.fragrances.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 60, weight: .light))
                                .foregroundStyle(.brownMain.opacity(0.5))
                            Text("No fragrances yet")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.brownMain.opacity(0.7))
                            Text("Tap the button below to add your first fragrance")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(.brownMain.opacity(0.5))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 100)
                    } else {
                        ForEach(userService.fragrances) { fragrance in
                            NavigationLink {
                                EditFragranceView(fragrance: fragrance)
                            } label: {
                                FragrancePreviewView(fragrance: fragrance)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, getSafeAreaTop() + 100)
                .padding(.bottom, getSafeAreaBottom() + 200)
            }
            
            NavigationLink {
                EditFragranceView()
            } label: {
                Text("+ Add Fragrance")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.greenMain)
                    )
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, getSafeAreaBottom() + 120)
        }
        .customHeader(title: "My Collection")
    }
}

