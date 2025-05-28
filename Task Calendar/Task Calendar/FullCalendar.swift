import SwiftUI

struct FullCalendarView: View {
    @State private var hoveredDate: Date? = nil
    @State private var mousePosition: CGPoint = .zero

    let year: Int = Calendar.current.component(.year, from: Date())
    let weekdays = ["S", "M", "T", "W", "T", "F", "S"]

    var body: some View {
        GeometryReader { rootGeo in
            ZStack(alignment: .topLeading) {
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 4) {
                        VStack(spacing: 4) {
                            ForEach(weekdays.indices, id: \.self) { index in
                                Text(weekdays[index])
                                    .font(.caption)
                                    .frame(width: 11, height: 11)
                            }
                        }

                        let dayColumns = generateDayColumns(for: year)

                        ForEach(dayColumns, id: \.self) { column in
                            VStack(spacing: 4) {
                                ForEach(column.indices, id: \.self) { index in
                                    let date = column[index]
                                    if let date = date {
                                        HoverableRectangle(date: date) { hovering, globalFrame in
                                            let localOrigin = CGPoint(
                                                x: globalFrame.midX - rootGeo.frame(in: .global).origin.x,
                                                y: globalFrame.midY - rootGeo.frame(in: .global).origin.y
                                            )

                                            if hovering {
                                                if hoveredDate != date {
                                                    hoveredDate = date
                                                    mousePosition = localOrigin
                                                }
                                            } else {
                                                if hoveredDate == date {
                                                    hoveredDate = nil
                                                }
                                            }
                                        }
                                    } else {
                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(width: 11, height: 11)
                                    }
                                }
                            }
                        }
                    }
                }

                if let date = hoveredDate {
                    Text(date.formatted(date: .long, time: .omitted))
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.black.opacity(0.85))
                        .cornerRadius(8)
                        .position(x: mousePosition.x + 30, y: mousePosition.y + 20)
                        .zIndex(1)
                        .transition(.opacity)
                }
            }
        }
    }

    func generateDayColumns(for year: Int) -> [[Date?]] {
        var calendar = Calendar.current
        calendar.firstWeekday = 1

        let startDate = calendar.date(from: DateComponents(year: year, month: 1, day: 1))!
        let endDate = calendar.date(from: DateComponents(year: year, month: 12, day: 31))!

        var allDates: [Date?] = []

        let startWeekday = calendar.component(.weekday, from: startDate)
        let firstPadding = (startWeekday - calendar.firstWeekday + 7) % 7
        allDates.append(contentsOf: Array(repeating: nil, count: firstPadding))

        var currentDate = startDate

        while currentDate <= endDate {
            allDates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }

        let remainder = allDates.count % 7
        if remainder != 0 {
            allDates.append(contentsOf: Array(repeating: nil, count: 7 - remainder))
        }

        return stride(from: 0, to: allDates.count, by: 7).map {
            Array(allDates[$0..<min($0 + 7, allDates.count)])
        }
    }
}

struct HoverableRectangle: View {
    let date: Date
    let onHoverChanged: (Bool, CGRect) -> Void

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(white: 0.3))

            GeometryReader { geo in
                Color.clear
                    .contentShape(Rectangle())
                    .onHover { hovering in
                        let frame = geo.frame(in: .global)
                        onHoverChanged(hovering, frame)
                    }
            }
        }
        .frame(width: 11, height: 11)
    }
}
