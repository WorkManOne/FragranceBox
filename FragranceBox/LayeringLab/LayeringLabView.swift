import SwiftUI

struct LayeringLabView: View {
    @EnvironmentObject var userService: UserService
    @State private var showFavoritesOnly = false

    private var filteredRecipes: [LayeringRecipeModel] {
        if showFavoritesOnly {
            return userService.layeringRecipes.filter { $0.isFavorite }
        }
        return userService.layeringRecipes
    }

    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 15) {
                    HStack(spacing: 12) {
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showFavoritesOnly = false
                            }
                        } label: {
                            Text("All Blends")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(showFavoritesOnly ? .brownMain.opacity(0.6) : .white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(showFavoritesOnly ? Color.lightBrownMain : Color.greenMain)
                                )
                        }

                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showFavoritesOnly = true
                            }
                        } label: {
                            Text("Favorites")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(showFavoritesOnly ? .white : .brownMain.opacity(0.6))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(showFavoritesOnly ? Color.greenMain : Color.lightBrownMain)
                                )
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    if userService.fragrances.count < 2 {
                        VStack(spacing: 16) {
                            Image(systemName: "cube.box")
                                .font(.system(size: 52, weight: .light))
                                .foregroundStyle(.brownMain.opacity(0.5))
                            Text("Add at least 2 fragrances first")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.brownMain.opacity(0.8))
                            Text("Layering recipes require at least two fragrances in your collection.")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(.brownMain.opacity(0.6))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 120)
                    } else if filteredRecipes.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "square.stack.3d.up")
                                .font(.system(size: 52, weight: .light))
                                .foregroundStyle(.brownMain.opacity(0.5))
                            Text(showFavoritesOnly ? "No favorite blends yet" : "No layering recipes yet")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.brownMain.opacity(0.8))
                            Text("Tap the button below to compose your first aromatic harmony.")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(.brownMain.opacity(0.6))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 120)
                    } else {
                        ForEach(filteredRecipes) { recipe in
                            NavigationLink {
                                EditLayeringRecipeView(recipe: recipe)
                            } label: {
                                LayeringRecipePreviewView(recipe: recipe)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, getSafeAreaTop() + 100)
                .padding(.bottom, getSafeAreaBottom() + 200)
            }

            if userService.fragrances.count >= 2 {
                NavigationLink {
                    EditLayeringRecipeView()
                } label: {
                    Text("+ Compose Blend")
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
        }
        .customHeader(title: "Layering Lab")
    }
}
