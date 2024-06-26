//
//  ContentView.swift
//  OnTrack
//
//  Displays a summary of the user's routines and allows the user to
//  check them off.
//
//  Created by Enam Amevo on 3/28/24.
//
//  Contributors:
//
    
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: ViewModel
    var numComplete: Int = 0
    
    var list: [String] = ["Hello", "World"]
    
    // State vars which manage whether add/selected view is visible
    @State var selectedRoutineViewVisible = false
    @State var addRoutineViewVisible = false
    
    var body: some View {
        VStack {
            Text("Hello, \(vm.name)")
                .padding()
            
            Text(vm.getDailyQuote())
                .padding()
            
            List() {
                ForEach(vm.routines) { (routine: Routine) in
                    HStack {
                        
                        Button(action: {
                            vm.markRoutine(routine: routine)
                        }) {
                            Image(systemName: vm.routineIsComplete(routine: routine) ? "checkmark.square" : "square")
                        }
                        // prevents whole list from being clickable
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                        VStack {
                            Text(routine.title)
                                .bold()
                            Text(routine.description)
                        }
                        Spacer()
                        Button(action: {
                            // setting this to true makes the sheet pop up
                            selectedRoutineViewVisible = true
                        }) {
                            Image(systemName: "info.circle")
                        }
                        .sheet(isPresented: $selectedRoutineViewVisible, content: {
                            SelectedRoutineView()
                                .onDisappear() { // when view disappears, reset bool
                                selectedRoutineViewVisible = false
                            }
                        })
                        // prevents whole list from being clickable
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            
            Button(action: {
                // setting this to true makes the sheet pop up
                addRoutineViewVisible = true
            }) {
                Text("Add Routine")
            }.sheet(isPresented: $addRoutineViewVisible, content: {
                // present AddRoutineView when button clicked
                AddRoutineView()
                    .onDisappear() { // when view disappears, reset bool
                    addRoutineViewVisible = false
                }
            })
            .padding()
                
            Text("\(numComplete)/\(vm.routines.count)")
                .padding()
        }
    }
}

#Preview {
    ContentView().environmentObject(ViewModel())
}
