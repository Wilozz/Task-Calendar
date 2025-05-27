import SwiftUI

struct TaskCalendarView: View {
    @State private var showConfirmation = false
    var task: Task
    var onDelete: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white, lineWidth: 1)

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
                .padding(.bottom, 10)

                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.controlBackgroundColor))
                    .frame(height: 150)
                    .overlay(FullCalendarView())
            }
            .padding(12) 
        }
        .padding(.horizontal)
    }
}
