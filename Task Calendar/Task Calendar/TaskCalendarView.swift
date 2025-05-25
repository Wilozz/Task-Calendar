import SwiftUI

struct TaskCalendarView: View {
    var task: Task
    var onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(task.name)
                    .font(.headline)
                
                Spacer()
                
                Button(action: {
                    onDelete()
                }) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                }
                .buttonStyle(.plain)

            }
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue.opacity(0.1))
                .frame(height: 150)
                .overlay(Text("Calendar goes here"))
        }
        .padding(.horizontal)
    }
}
