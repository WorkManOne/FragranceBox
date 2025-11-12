import Foundation
import SwiftUI

struct CustomToggleStyle: ToggleStyle {
    var foregroundColor: Color = .white
    var offBackgroundColor: Color = .lightBrownMain
    var onBackgroundColor: Color = .greenMain
    var leadingText: Text?
    var trailingText: Text?

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            if let leadingText = leadingText {
                leadingText
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.black)
            }
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? onBackgroundColor : offBackgroundColor)
                .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                .frame(width: 50, height: 25)
                .overlay(
                    Circle()
                        .fill(foregroundColor)
                        .frame(width: 20, height: 20)
                        .offset(x: configuration.isOn ? 12 : -12)
                        .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            if let trailingText = trailingText {
                trailingText
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.black)
            }
        }
    }
}

