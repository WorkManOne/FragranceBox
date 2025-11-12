import SwiftUI
import UIKit

struct FragrancePreviewView: View {
    let fragrance: FragranceModel

    var body: some View {
        HStack (alignment: .top, spacing: 15) {
            ZStack {
                if let imageData = fragrance.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipped()
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 80)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.system(size: 24, weight: .light))
                                .foregroundStyle(.bgBrownMain)
                        )
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack (alignment: .leading, spacing: 8) {
                HStack {
                    VStack (alignment: .leading, spacing: 8) {
                        Text(fragrance.name)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.leading)

                        Text(fragrance.brand)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.brownMain)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("\(Int(fragrance.remainingAmount))%")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.greenMain)

                        Text("remaining")
                            .font(.system(size: 10, weight: .regular))
                            .foregroundStyle(.brownMain.opacity(0.7))
                    }
                }

                if !fragrance.topNotes.isEmpty || !fragrance.heartNotes.isEmpty || !fragrance.baseNotes.isEmpty {
                    HStack(spacing: 4) {
                        if !fragrance.topNotes.isEmpty {
                            Text(fragrance.topNotes.prefix(2).map(\.rawValue).joined(separator: ", "))
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(.brownMain.opacity(0.7))
                        }
                    }
                }
                
                HStack(spacing: 8) {
                    if fragrance.isWishlist {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.greenMain)
                    }
                    
                    Text(fragrance.season.rawValue)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.brownMain.opacity(0.7))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.bgBrownMain)
                        )
                }
                if fragrance.rating > 0 {
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { index in
                            Image(systemName: index <= fragrance.rating ? "star.fill" : "star")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundStyle(index <= fragrance.rating ? .greenMain : .lightBrownMain)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .lightFramed(isBordered: true)
    }
}

