import SwiftUI

struct TaskCalendarView: View {
    @State private var showConfirmation = false
    var task: Task
    var onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(task.name)
                    .font(.headline)
                
                Spacer()
                
                Button(action: {
                    showConfirmation = true
                }) {
                    Image(systemName: "minus")
                        .padding(6)
                }
                .buttonStyle(.bordered)
                .alert("Delete Task?", isPresented: $showConfirmation) {
                    Button("Delete", role: .destructive) {
                        onDelete()
                    }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Are you sure you want to delete this task?")
                }
                

            }
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue.opacity(0.1))
                .frame(height: 150)
                .overlay(Text("Calendar goes here"))
        }
        .padding(.horizontal)
    }
}
