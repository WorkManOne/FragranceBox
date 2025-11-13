import SwiftUI

extension View {
    func darkFramed(isBordered: Bool = false) -> some View {
        self
            .padding(15)
            .frame(maxWidth: .infinity)
            .background(.bgBrownMain)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightBrownMain, lineWidth: isBordered ? 1 : 0)
            }
    }
    
    func lightFramed(isBordered: Bool = false, padding: CGFloat = 20) -> some View {
        self
            .padding(padding)
            .frame(maxWidth: .infinity)
            .background(.lightBrownMain)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightBrownMain, lineWidth: isBordered ? 1 : 0)
            }
    }
    
    func colorFramed(color: Color, isBordered: Bool = false, borderColor: Color = .white, lineWidth: CGFloat = 1) -> some View {
        self
            .padding(15)
            .frame(maxWidth: .infinity)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor, lineWidth: isBordered ? lineWidth : 0)
            }
    }
}

