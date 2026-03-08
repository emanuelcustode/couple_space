//
//  CalenderView.swift
//  couple_space
//
//  Created by Emanuel on 08.03.26.
//

import SwiftUI

struct CalenderView: View {
    
    @State private var selectedDate: Date = Date()
    @State private var showCreateEvent: Bool = false
    
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
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Kalender
                    DatePicker(
                        "Datum",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // Events für ausgewählten Tag
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
                                        
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.secondary)
                                            .font(.caption)
                                    }
                                    .padding()
                                    .background(Color.pink.opacity(0.08))
                                    .cornerRadius(12)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Kalender")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showCreateEvent.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showCreateEvent, content: {
                CreateEventView()
                }
            )
        }
    }
}

#Preview {
    CalenderView()
}
