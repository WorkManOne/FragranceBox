import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack (alignment: .top) {
            Spacer()
            TabBarButton(icon: Image(systemName: "sparkles"), title: "Collection", index: 0, selectedTab: $selectedTab)
            Spacer()
            TabBarButton(icon: Image(systemName: "heart"), title: "Wishlist", index: 1, selectedTab: $selectedTab)
            Spacer()
            TabBarButton(icon: Image(systemName: "wand.and.stars"), title: "Layering", index: 2, selectedTab: $selectedTab)
            Spacer()
            TabBarButton(icon: Image(systemName: "chart.bar"), title: "Stats", index: 3, selectedTab: $selectedTab)
            Spacer()
            TabBarButton(icon: Image(systemName: "gearshape"), title: "Settings", index: 4, selectedTab: $selectedTab)
            Spacer()
        }
        .padding(.vertical, 20)
        .padding(.bottom, getSafeAreaBottom())
        .background(
            ZStack (alignment: .top) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                Rectangle()
                    .fill(.lightBrownMain)
                    .frame(height: 1)
            }
        )
    }
}

struct TabBarButton: View {
    let icon: Image
    let title: String
    let index: Int
    @Binding var selectedTab: Int

    var body: some View {
        Button(action: {
            selectedTab = index
        }) {
            VStack(spacing: 4) {
                icon
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .padding(10)
                    .foregroundStyle(selectedTab == index ? .greenMain : .brownMain.opacity(0.7))
                Text(title)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(selectedTab == index ? .greenMain : .brownMain.opacity(0.7))
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)
            }
            .padding(.horizontal, 10)
        }
    }
}

