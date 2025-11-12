import SwiftUI

func getSafeAreaBottom() -> CGFloat {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first else {
        return 44
    }
    return window.safeAreaInsets.bottom
}

func getSafeAreaTop() -> CGFloat {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first else {
        return 44
    }
    return window.safeAreaInsets.top
}

extension View {
    func customHeader(
        title: String,
        image: Image? = nil,
        isDismiss: Bool = false,
        showSaveButton: Bool = false,
        onSave: (() -> Void)? = nil
    ) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .navigationTitle("")
            .background(.backgroundMain)
            .overlay {
                CustomHeader(title: title, image: image, isDismiss: isDismiss, showSaveButton: showSaveButton, onSave: onSave)
            }
            .onAppear {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first,
                   let nav = window.rootViewController?.children.first as? UINavigationController {
                    nav.interactivePopGestureRecognizer?.isEnabled = true
                    nav.interactivePopGestureRecognizer?.delegate = nil
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                to: nil, from: nil, for: nil)
            }
    }
}

struct CustomHeader: View {
    var title: String
    var image: Image? = nil
    var isDismiss: Bool = false
    var showSaveButton: Bool = false
    var onSave: (() -> Void)? = nil

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if showSaveButton {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Exit")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(.brownMain)
                        }
                        Spacer()
                        Button(action: {
                            onSave?()
                            dismiss()
                        }) {
                            Text("Save")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.greenMain)
                        }
                    }
                    .padding(.horizontal, 20)
                } else {
                    HStack {
                        if isDismiss {
                            Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "arrow.left")
                                    .renderingMode(.template)
                                    .resizable()
                                    .bold()
                                    .scaledToFit()
                                    .foregroundStyle(.brownMain)
                                    .frame(width: 20, height: 20)
                            }
                        } else if let image {
                            image
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.brownMain)
                                .frame(width: 24, height: 24)
                        } else {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: 24, height: 24)
                        }
                        Spacer()
                        if let image, !isDismiss {
                            image
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.brownMain)
                                .frame(width: 24, height: 24)
                        } else {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: 24, height: 24)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                Text(title)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .padding(.top, getSafeAreaTop())
            .background(Color.lightBrownMain)
            .clipShape(
                RoundedCorners(radius: 10, corners: [.bottomLeft, .bottomRight])
            )
            Spacer()
        }
        .ignoresSafeArea(edges: .top)
    }
}

