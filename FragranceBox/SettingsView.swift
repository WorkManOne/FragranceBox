import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userService: UserService

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("About")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.black)
                        
                        Text("FragranceBox")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(.brownMain)
                        
                        Text("Your personal fragrance collection manager")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.brownMain.opacity(0.7))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lightFramed()
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Statistics")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.black)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(userService.fragrances.count)")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundStyle(.greenMain)
                                Text("Total Fragrances")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(.brownMain.opacity(0.7))
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 4) {
                                Text("\(userService.fragrances.filter { $0.isWishlist }.count)")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundStyle(.greenMain)
                                Text("In Wishlist")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(.brownMain.opacity(0.7))
                            }
                        }
                    }
                    .lightFramed()
                    
                    Button {
                        userService.reset()
                    } label: {
                        Text("Reset All Data")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                            .colorFramed(color: .red)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, getSafeAreaTop() + 100)
                .padding(.bottom, getSafeAreaBottom() + 40)
            }
        }
        .customHeader(title: "Settings")
    }
}

