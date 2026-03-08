//
//  DashboardView.swift
//  couple_space
//
//  Created by Emanuel on 07.03.26.
//

import SwiftUI

struct DashboardView: View {
    
    @State private var selectedDate: Date = Date()
    
    private let mockNotes = [
        ("Einkaufsliste", "Milch, Eier, Brot..."),
        ("Urlaubsplanung", "Flüge nach Barcelona..."),
        ("Ideen", "Gemeinsames Hobby finden..."),
        ("Rezepte", "Pasta Carbonara Rezept...")
    ]
    
    private let mockEvents: [Date: [String]] = {
        let calendar = Calendar.current
        let today = Date()
        return [
            calendar.date(byAdding: .day, value: 1, to: today)!: ["Dinner zu zweit", "Film schauen"],
            calendar.date(byAdding: .day, value: 3, to: today)!: ["Kinoabend"]
        ]
    }()
    
    var eventsForSelectedDate: [String] {
        mockEvents.first(where: {
            Calendar.current.isDate($0.key, inSameDayAs: selectedDate)
        })?.value ?? []
    }
    
    var selectedDateFormatted: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "EEEE, d. MMMM"
        return formatter.string(from: selectedDate)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                
                // Begrüßung
                VStack(alignment: .leading, spacing: 4) {
                    Text("Willkommen in eurem Space")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Schön dass ihr heute wieder da seid.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 24){
                    Text("Was Steht diese Woche alles an?")
                        .font(.headline)
                }.padding(.horizontal)
                VStack(alignment: .leading, spacing: 12) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(currentWeekDays(), id: \.self) { date in
                                WeekDayCell(
                                    date: date,
                                    isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate),
                                    hasEvent: mockEvents.keys.contains(where: {
                                        Calendar.current.isDate($0, inSameDayAs: date)
                                    })
                                )
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        selectedDate = date
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(selectedDateFormatted)
                        .font(.headline)
                        .padding(.horizontal)
                    
                    if eventsForSelectedDate.isEmpty {
                        HStack {
                            Image(systemName: "calendar.badge.plus")
                                .foregroundColor(.secondary)
                            Text("Keine Events an diesem Tag")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.gray.opacity(0.08))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    } else {
                        VStack(spacing: 8) {
                            ForEach(eventsForSelectedDate, id: \.self) { event in
                                HStack(spacing: 12) {
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(Color.pink)
                                        .frame(width: 4, height: 36)
                                    
                                    Text(event)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(Color.pink.opacity(0.08))
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Notizen Grid
                VStack(alignment: .leading, spacing: 12) {
                    Text("Notizen")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 12) {
                        ForEach(mockNotes, id: \.0) { note in
                            NoteCard(title: note.0, preview: note.1)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top)
        }
    }
    
    func currentWeekDays() -> [Date] {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - 2), to: today)!
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }
}

struct WeekDayCell: View {
    let date: Date
    let isSelected: Bool
    let hasEvent: Bool
    
    private var dayLetter: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    private var dayNumber: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    var body: some View {
        VStack(spacing: 6) {
            Text(dayLetter)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(dayNumber)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(isSelected ? .white : .primary)
                .frame(width: 36, height: 36)
                .background(isSelected ? Color.pink : Color.clear)
                .clipShape(Circle())
            
            Circle()
                .fill(Color.pink)
                .frame(width: 6, height: 6)
                .opacity(hasEvent ? 1 : 0)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 4)
    }
}

struct NoteCard: View {
    let title: String
    let preview: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .lineLimit(1)
            
            Text(preview)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(3)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 100, alignment: .topLeading)
        .background(Color.pink.opacity(0.08))
        .cornerRadius(14)
    }
}

#Preview {
    DashboardView()
}
