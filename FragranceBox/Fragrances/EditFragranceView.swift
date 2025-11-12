import SwiftUI
import UIKit

struct EditFragranceView: View {
    let isEditing: Bool
    @State private var fragrance: FragranceModel
    @EnvironmentObject var userService: UserService
    @Environment(\.dismiss) var dismiss

    @State private var showImagePicker = false
    @State private var pickerSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var showSourceSheet = false

    init(fragrance: FragranceModel? = nil) {
        if let fragrance = fragrance {
            self._fragrance = State(initialValue: fragrance)
            isEditing = true
        } else {
            self._fragrance = State(initialValue: FragranceModel())
            isEditing = false
        }
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    VStack (alignment: .leading, spacing: 20) {
                        Text("Fragrance Photo")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.black)
                        Button {
                            showSourceSheet = true
                        } label: {
                            ZStack {
                                VStack (spacing: 10) {
                                    Image(systemName: "camera.fill")
                                        .font(.system(size: 30, weight: .light))
                                        .foregroundStyle(.brownMain)
                                        .padding(25)
                                        .background(
                                            Circle()
                                                .fill(.white)
                                        )
                                    Text("Add a photo")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundStyle(.black)
                                    Text("Tap to upload image")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundStyle(.brownMain)
                                        .padding(.bottom)
                                    Text("+ Choose Photo")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundStyle(.white)
                                        .padding(.horizontal)
                                        .padding(.vertical, 10)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(.greenMain)
                                        )
                                }
                                .padding(.vertical)
                                .colorFramed(color: .bgBrownMain)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.brownMain, style: .init(dash: [1, 3]))
                                )
                                if let data = fragrance.imageData, let image = UIImage(data: data) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                }
                            }
                            .frame(height: 250)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    
                    VStack (alignment: .leading, spacing: 10) {
                        Text("Fragrance Name")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.black)
                        TextField("", text: $fragrance.name, prompt: Text("Enter fragrance name").foregroundColor(.gray))
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.black)
                            .darkFramed()
                    }
                    
                    VStack (alignment: .leading, spacing: 10) {
                        Text("Brand")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.black)
                        TextField("", text: $fragrance.brand, prompt: Text("Enter brand name").foregroundColor(.gray))
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.black)
                            .darkFramed()
                    }
                    
                    VStack (alignment: .leading, spacing: 10) {
                        Text("Description")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.black)
                        TextField("", text: $fragrance.description, prompt: Text("Enter description").foregroundColor(.gray), axis: .vertical)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.black)
                            .lineLimit(3...6)
                            .darkFramed()
                    }
                    
                    VStack (alignment: .leading, spacing: 15) {
                        Text("Top Notes")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.black)
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            ForEach(NoteType.allCases, id: \.self) { note in
                                NotePickerButton(noteArray: $fragrance.topNotes, note: note, noteCategory: .top)
                            }
                        }
                    }
                    
                    VStack (alignment: .leading, spacing: 15) {
                        Text("Heart Notes")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.black)
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            ForEach(NoteType.allCases, id: \.self) { note in
                                NotePickerButton(noteArray: $fragrance.heartNotes, note: note, noteCategory: .heart)
                            }
                        }
                    }
                    
                    VStack (alignment: .leading, spacing: 15) {
                        Text("Base Notes")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.black)
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            ForEach(NoteType.allCases, id: \.self) { note in
                                NotePickerButton(noteArray: $fragrance.baseNotes, note: note, noteCategory: .base)
                            }
                        }
                    }
                    
                    VStack (alignment: .leading, spacing: 15) {
                        Text("When to Wear")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.black)
                        HStack {
                            ForEach(WearTime.allCases, id: \.self) { time in
                                WearTimePickerButton(wearTimeArray: $fragrance.whenToWear, wearTime: time)
                            }
                        }
                    }
                    
                    VStack (alignment: .leading, spacing: 15) {
                        Text("Where to Wear")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.black)
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            ForEach(WearPlace.allCases, id: \.self) { place in
                                WearPlacePickerButton(wearPlaceArray: $fragrance.whereToWear, wearPlace: place)
                            }
                        }
                    }
                    
                    VStack (alignment: .leading, spacing: 15) {
                        Text("Season")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.black)
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            ForEach(Season.allCases, id: \.self) { season in
                                SeasonPickerButton(selectedSeason: $fragrance.season, season: season)
                            }
                        }
                    }
                    
                    VStack (alignment: .leading, spacing: 15) {
                        Text("Bottle Information")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.black)
                        
                        HStack(spacing: 15) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Bottle Size (ml)")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.black)
                                TextField("", value: $fragrance.bottleSize, format: .number, prompt: Text("100").foregroundColor(.gray))
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundStyle(.black)
                                    .keyboardType(.decimalPad)
                                    .darkFramed()
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Remaining (%)")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.black)
                                TextField("", value: $fragrance.remainingAmount, format: .number, prompt: Text("100").foregroundColor(.gray))
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundStyle(.black)
                                    .keyboardType(.decimalPad)
                                    .darkFramed()
                            }
                        }
                    }
                    
                    VStack (alignment: .leading, spacing: 15) {
                        HStack {
                            Text("Rating")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(.black)
                            Spacer()
                            HStack(spacing: 4) {
                                ForEach(1...5, id: \.self) { index in
                                    Button {
                                        fragrance.rating = index
                                    } label: {
                                        Image(systemName: index <= fragrance.rating ? "star.fill" : "star")
                                            .font(.system(size: 20, weight: .medium))
                                            .foregroundStyle(index <= fragrance.rating ? .greenMain : .lightBrownMain)
                                    }
                                }
                            }
                        }
                        .lightFramed()
                    }
                    
                    VStack (alignment: .leading, spacing: 15) {
                        Toggle(isOn: $fragrance.isWishlist) {
                            Text("Add to Wishlist")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(.black)
                        }
                        .toggleStyle(CustomToggleStyle())
                        .lightFramed()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, getSafeAreaTop() + 100)
                .padding(.bottom, getSafeAreaBottom() + 40)
            }
        }
        .customHeader(title: isEditing ? "Edit Fragrance" : "Add Fragrance", isDismiss: false, showSaveButton: true) {
            if isEditing {
                if let index = userService.fragrances.firstIndex(where: { $0.id == fragrance.id }) {
                    userService.fragrances[index] = fragrance
                }
            } else {
                userService.fragrances.append(fragrance)
            }
        }
        .confirmationDialog("Select Source", isPresented: $showSourceSheet, titleVisibility: .visible) {
            Button("Camera") {
                pickerSource = .camera
                showImagePicker = true
            }
            Button("Photo Library") {
                pickerSource = .photoLibrary
                showImagePicker = true
            }
            Button("Cancel", role: .cancel) {}
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: pickerSource) { selectedImage in
                fragrance.imageData = selectedImage
            }
        }
    }
}
