import SwiftUI

struct TaskCalendarView: View {
    var task: Task
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.name)
                .font(.headline)
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue.opacity(0.1))
                .frame(height: 150)
                .overlay(Text("Calendar goes here"))
        }
        .padding(.horizontal)
    }
}
