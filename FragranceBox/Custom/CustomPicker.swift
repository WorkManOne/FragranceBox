import SwiftUI

struct CustomPickerOption<ID: Hashable>: Identifiable, Equatable {
    let value: ID
    let title: String

    var id: ID { value }
}

struct CustomPicker<ID: Hashable>: View {
    var title: String
    var placeholder: String
    var options: [CustomPickerOption<ID>]
    @Binding var selection: ID?
    var allowsNilOption: Bool = false
    var isDisabled: Bool = false

    @State private var isExpanded = false

    private var displayText: String {
        if let selection,
           let option = options.first(where: { $0.value == selection }) {
            return option.title
        }
        return placeholder
    }

    private var displayColor: Color {
        if let selection,
           options.contains(where: { $0.value == selection }) {
            return .black
        }
        return .brownMain.opacity(0.6)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.black)

            Button {
                guard !isDisabled, !options.isEmpty else { return }
                withAnimation(.easeInOut(duration: 0.2)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text(displayText)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(displayColor)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.brownMain.opacity(0.7))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.lightBrownMain, lineWidth: 1)
                )
                .opacity(isDisabled ? 0.6 : 1)
            }
            .buttonStyle(.plain)

            if isExpanded {
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(options) { option in
                                Button {
                                    selection = option.value
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        isExpanded = false
                                    }
                                } label: {
                                    HStack {
                                        Text(option.title)
                                            .font(.system(size: 16, weight: .regular))
                                            .foregroundStyle(option.value == selection ? .greenMain : .brownMain.opacity(0.8))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        if option.value == selection {
                                            Image(systemName: "checkmark")
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundStyle(.greenMain)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 14)
                                    .background(
                                        option.value == selection ? Color.greenMain.opacity(0.08) : Color.white
                                    )
                                }
                                .buttonStyle(.plain)


                                if option != options.last {
                                    Divider()
                                        .overlay(Color.lightBrownMain.opacity(0.4))
                                }
                            }
                        }
                    }
                    .frame(maxHeight: min(CGFloat(options.count) * 54, 220))

                    if allowsNilOption {
                        Divider()
                            .overlay(Color.lightBrownMain.opacity(0.4))

                        Button {
                            selection = nil
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isExpanded = false
                            }
                        } label: {
                            HStack {
                                Text("Clear selection")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.brownMain.opacity(0.7))
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                        }
                        .buttonStyle(.plain)
                        .background(Color.white)
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(color: .brownMain.opacity(0.12), radius: 20, x: 0, y: 12)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.lightBrownMain, lineWidth: 1)
                )
                .transition(.opacity.combined(with: .move(edge: .top)))
                .padding(.top, 4)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 2)
        .onChange(of: selection) { _ in
            if isExpanded {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isExpanded = false
                }
            }
        }
    }
}
