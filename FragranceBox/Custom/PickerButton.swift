import SwiftUI

struct NotePickerButton: View {
    @Binding var noteArray: [NoteType]
    var note: NoteType
    var noteCategory: NoteCategory

    var body: some View {
        Button {
            withAnimation (.easeOut(duration: 0.3)) {
                if let index = noteArray.firstIndex(of: note) {
                    noteArray.remove(at: index)
                } else {
                    noteArray.append(note)
                }
            }
        } label: {
            HStack {
                Image(systemName: noteArray.contains(note) ? "checkmark.square.fill" : "square")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundStyle(.brownMain)
                Text(note.rawValue)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.brownMain)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.bgBrownMain)
            }
        }
    }
}

enum NoteCategory {
    case top
    case heart
    case base
}

struct WearTimePickerButton: View {
    @Binding var wearTimeArray: [WearTime]
    var wearTime: WearTime

    var body: some View {
        Button {
            withAnimation (.easeOut(duration: 0.3)) {
                if let index = wearTimeArray.firstIndex(of: wearTime) {
                    wearTimeArray.remove(at: index)
                } else {
                    wearTimeArray.append(wearTime)
                }
            }
        } label: {
            Text(wearTime.rawValue)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(wearTimeArray.contains(wearTime) ? .white : .white)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(wearTimeArray.contains(wearTime) ? .greenMain : .lightBrownMain)
                }
        }
    }
}

struct WearPlacePickerButton: View {
    @Binding var wearPlaceArray: [WearPlace]
    var wearPlace: WearPlace

    var body: some View {
        Button {
            withAnimation (.easeOut(duration: 0.3)) {
                if let index = wearPlaceArray.firstIndex(of: wearPlace) {
                    wearPlaceArray.remove(at: index)
                } else {
                    wearPlaceArray.append(wearPlace)
                }
            }
        } label: {
            Text(wearPlace.rawValue)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(wearPlaceArray.contains(wearPlace) ? .white : .white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(wearPlaceArray.contains(wearPlace) ? .greenMain : .lightBrownMain)
                }
        }
    }
}

struct SeasonPickerButton: View {
    @Binding var selectedSeason: Season
    var season: Season

    var body: some View {
        Button {
            withAnimation (.easeOut(duration: 0.3)) {
                selectedSeason = season
            }
        } label: {
            Text(season.rawValue)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(selectedSeason == season ? .white : .white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(selectedSeason == season ? .greenMain : .lightBrownMain)
                }

        }
    }
}

