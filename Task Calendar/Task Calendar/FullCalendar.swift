import SwiftUI

struct FullCalendarView: View {
    let year: Int = Calendar.current.component(.year, from: Date())
    let weekdays = ["S", "M", "T", "W", "T", "F", "S"]
    
    var body: some View {
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

                ForEach(dayColumns, id: \.self) {column in
                    VStack(spacing: 4) {
                        ForEach(column, id: \.self) {date in
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 11, height: 11)

                        }
                    }
                }
            }
        }
    }
    
    func generateDayColumns(for year: Int) -> [[Date]] {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        
        let startDate = calendar.date(from: DateComponents(year: year, month: 1, day: 1))!
        let endDate = calendar.date(from: DateComponents(year: year, month: 12, day: 31))!
        
        var allDates: [Date] = []
        var currentDate = startDate
        
        while (currentDate <= endDate) {
            allDates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return stride(from: 0, to: allDates.count, by: 7).map {
            Array(allDates[$0..<min($0 + 7, allDates.count)])
        }
    }
}
