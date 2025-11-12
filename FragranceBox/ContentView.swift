import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userService: UserService
    
    var body: some View {
        MainTabView()
            .fullScreenCover(isPresented: .constant(userService.isFirstLaunch)) {
                OnboardingView {
                    userService.isFirstLaunch = false
                }
            }
    }
}

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundMain.ignoresSafeArea()
                TabView (selection: $selectedTab) {
                    FragranceView()
                        .tag(0)
                    WishlistView()
                        .tag(1)
                    LayeringLabView()
                        .tag(2)
                    StatisticsView()
                        .tag(3)
                    SettingsView()
                        .tag(4)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                VStack {
                    Spacer()
                    CustomTabBar(selectedTab: $selectedTab)
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct WishlistView: View {
    @EnvironmentObject var userService: UserService

    var wishlistFragrances: [FragranceModel] {
        userService.fragrances.filter { $0.isWishlist }
    }

    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 15) {
                    if wishlistFragrances.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "heart")
                                .font(.system(size: 60, weight: .light))
                                .foregroundStyle(.brownMain.opacity(0.5))
                            Text("No fragrances in wishlist")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.brownMain.opacity(0.7))
                            Text("Add fragrances to your wishlist to see them here")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(.brownMain.opacity(0.5))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 100)
                    } else {
                        ForEach(wishlistFragrances) { fragrance in
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
        }
        .customHeader(title: "Wishlist")
    }
}
