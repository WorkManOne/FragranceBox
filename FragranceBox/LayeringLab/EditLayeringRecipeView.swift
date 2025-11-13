import SwiftUI

struct EditLayeringRecipeView: View {
    let isEditing: Bool
    @State private var recipe: LayeringRecipeModel
    @State private var showingDatePicker: Bool = false
    @EnvironmentObject var userService: UserService
    @Environment(\.dismiss) var dismiss

    init(recipe: LayeringRecipeModel? = nil) {
        if let recipe {
            _recipe = State(initialValue: recipe)
            isEditing = true
        } else {
            _recipe = State(initialValue: LayeringRecipeModel())
            isEditing = false
        }
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    if userService.fragrances.count < 2 {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("More fragrances needed")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.brownMain)
                            Text("Add at least two fragrances to compose a layering blend.")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(.brownMain.opacity(0.7))
                        }
                        .lightFramed()
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Blend Title")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.brownMain)
                        TextField("", text: $recipe.title, prompt: Text("Name your recipe").foregroundColor(.brownMain.opacity(0.5)))
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.brownMain)
                            .darkFramed()
                    }

                    VStack(alignment: .leading, spacing: 20) {
                        Text("Select Fragrances")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.brownMain)

                        VStack(spacing: 16) {
                            CustomPicker(
                                title: "Base Layer",
                                placeholder: "Choose base fragrance",
                                options: fragranceOptions,
                                selection: $recipe.baseFragranceId,
                                allowsNilOption: true,
                                isDisabled: fragranceOptions.isEmpty
                            )

                            CustomPicker(
                                title: "Companion Layer",
                                placeholder: "Choose companion fragrance",
                                options: fragranceOptions,
                                selection: $recipe.companionFragranceId,
                                allowsNilOption: true,
                                isDisabled: fragranceOptions.count < 2
                            )
                        }
                    }

                    VStack(alignment: .leading, spacing: 20) {
                        Text("Blend Ratio")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.brownMain)
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Base \(Int((1 - recipe.ratio) * 100))%")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.brownMain.opacity(0.8))
                                Spacer()
                                Text("Companion \(Int(recipe.ratio * 100))%")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.brownMain.opacity(0.8))
                            }
                            Slider(value: $recipe.ratio, in: 0...1, step: 0.05)
                                .tint(.greenMain)
                        }
                        .lightFramed()
                    }

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Aroma Goals")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.brownMain)

                        CustomPicker(
                            title: "Ambiance Setting",
                            placeholder: "Select ambiance",
                            options: ambianceOptions,
                            selection: Binding<LayeringAmbiance?>(
                                get: { recipe.ambiance },
                                set: { newValue in
                                    if let newValue {
                                        recipe.ambiance = newValue
                                    }
                                }
                            ),
                            allowsNilOption: false
                        )

                        CustomPicker(
                            title: "Projection Focus",
                            placeholder: "Select projection",
                            options: projectionOptions,
                            selection: Binding<ProjectionFocus?>(
                                get: { recipe.projectionFocus },
                                set: { newValue in
                                    if let newValue {
                                        recipe.projectionFocus = newValue
                                    }
                                }
                            ),
                            allowsNilOption: false
                        )

                        CustomPicker(
                            title: "Longevity Target",
                            placeholder: "Select longevity",
                            options: longevityOptions,
                            selection: Binding<LongevityTarget?>(
                                get: { recipe.longevityTarget },
                                set: { newValue in
                                    if let newValue {
                                        recipe.longevityTarget = newValue
                                    }
                                }
                            ),
                            allowsNilOption: false
                        )
                    }

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Mood Tags")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.brownMain)

                        let columns = [GridItem(.flexible()), GridItem(.flexible())]
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(LayeringMood.allCases, id: \.self) { mood in
                                MoodSelectionButton(selectedMoods: $recipe.moodTags, mood: mood)
                            }
                        }
                    }



                    VStack(alignment: .leading, spacing: 12) {
                        Text("Experiment Date")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.brownMain)
                        Button {
                            showingDatePicker = true
                        } label: {
                            HStack {
                                Text(formatter.string(from: recipe.applyDate))
                                    .foregroundStyle(.brownMain)
                                    .font(.system(size: 16))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .darkFramed(isBordered: true)
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Blend Notes")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.brownMain)
                        TextField("", text: $recipe.notes, prompt: Text("Describe projection, dry-down, or compliments").foregroundColor(.brownMain.opacity(0.5)), axis: .vertical)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.brownMain)
                            .lineLimit(4...8)
                            .darkFramed()
                    }

                    Toggle(isOn: $recipe.isFavorite) {
                        Text("Mark as favorite blend")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.brownMain)
                    }
                    .toggleStyle(CustomToggleStyle())
                    .lightFramed()

                    if isEditing {
                        Button(role: .destructive) {
                            if let index = userService.layeringRecipes.firstIndex(where: { $0.id == recipe.id }) {
                                userService.layeringRecipes.remove(at: index)
                                dismiss()
                            }
                        } label: {
                            Text("Delete Blend")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white)
                                .colorFramed(color: .greenMain)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, getSafeAreaTop() + 100)
                .padding(.bottom, getSafeAreaBottom() + 40)
            }
        }
        .customHeader(title: isEditing ? "Edit Blend" : "Compose Blend", isDismiss: true, showSaveButton: true) {
            saveRecipe()
        }
        .sheet(isPresented: $showingDatePicker) {
            CustomDatePickerSheet(selectedDate: $recipe.applyDate)
        }
    }

    private var fragranceOptions: [CustomPickerOption<UUID>] {
        userService.fragrances.map { fragrance in
            let title = fragrance.name.isEmpty ? "Untitled fragrance" : fragrance.name
            return CustomPickerOption(value: fragrance.id, title: title)
        }
    }

    private var ambianceOptions: [CustomPickerOption<LayeringAmbiance>] {
        LayeringAmbiance.allCases.map { CustomPickerOption(value: $0, title: $0.rawValue) }
    }

    private var projectionOptions: [CustomPickerOption<ProjectionFocus>] {
        ProjectionFocus.allCases.map { CustomPickerOption(value: $0, title: $0.rawValue) }
    }

    private var longevityOptions: [CustomPickerOption<LongevityTarget>] {
        LongevityTarget.allCases.map { CustomPickerOption(value: $0, title: $0.rawValue) }
    }

    private func saveRecipe() {
        guard userService.fragrances.count >= 2,
              let baseId = recipe.baseFragranceId,
              let companionId = recipe.companionFragranceId,
              baseId != companionId else {
            return
        }
        recipe.baseFragranceId = baseId
        recipe.companionFragranceId = companionId
        if isEditing {
            if let index = userService.layeringRecipes.firstIndex(where: { $0.id == recipe.id }) {
                userService.layeringRecipes[index] = recipe
            }
        } else {
            userService.layeringRecipes.append(recipe)
        }
    }
}

private struct MoodSelectionButton: View {
    @Binding var selectedMoods: [LayeringMood]
    let mood: LayeringMood

    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                if let index = selectedMoods.firstIndex(of: mood) {
                    selectedMoods.remove(at: index)
                } else {
                    selectedMoods.append(mood)
                }
            }
        } label: {
            Text(mood.rawValue)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(selectedMoods.contains(mood) ? .white : .brownMain.opacity(0.7))
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(selectedMoods.contains(mood) ? Color.greenMain : Color.lightBrownMain)
                )
        }
    }
}
