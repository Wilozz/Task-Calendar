import SwiftUI

struct ContentView: View {
    @State private var tasks: [Task] = []
    @State private var showAddTask: Bool = false
    @State private var newTaskName = ""
    
    func deleteTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
    }
    
    func addTask() {
        if !newTaskName.trimmingCharacters(in: .whitespaces).isEmpty {
            tasks.append(Task(name: newTaskName))
            newTaskName = ""
            showAddTask = false
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TaskBarView(showAddTask: $showAddTask)

            ScrollView {
                VStack(spacing: 20) {
                    ForEach(tasks.indices, id: \.self) { index in
                        TaskCalendarView(
                            task: $tasks[index],
                            onDelete: {
                                deleteTask(tasks[index])
                            }
                        )
                    }
                }
                .padding(.top)
            }
        }
        .frame(minWidth: 320, minHeight: 500)
        .background(Color(.controlBackgroundColor)) 
        .sheet(isPresented: $showAddTask) {
            VStack(spacing: 20) {
                Text("Add a New Task")
                    .font(.title2)

                TextField("Enter Task Name", text: $newTaskName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onSubmit {
                        addTask()
                    }

                Button("Add") {
                    addTask()
                }
                .buttonStyle(.borderedProminent)

                Button("Cancel") {
                    showAddTask = false
                }
                .foregroundColor(.red)

                Spacer()
            }
            .padding()
            .frame(width: 300, height: 250)
        }
    }
}
