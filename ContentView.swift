import SwiftUI

struct ContentView: View {
    @State private var selectedEmergency: EmergencyType?
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Header
                        VStack(spacing: 8) {
                            Image(systemName: "cross.case.fill")
                                .font(.system(size: 60))
                                .foregroundColor(Theme.warningRed)
                            
                            Text("Vital")
                                .font(.system(size: 40, weight: .black, design: .default))
                                .foregroundColor(Theme.textMain)
                            
                            Text("What is the emergency?")
                                .font(.title3)
                                .foregroundColor(Theme.textSecondary)
                        }
                        .padding(.top, 40)
                        .padding(.bottom, 20)
                        
                        // Emergency Buttons Grid/List
                        VStack(spacing: 20) {
                            ForEach(EmergencyType.allCases) { type in
                                Button(action: {
                                    selectedEmergency = type
                                }) {
                                    EmergencyButton(type: type)
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .fullScreenCover(item: $selectedEmergency) { type in
            switch type {
            case .panicAttack:
                PanicAttackView()
            case .cpr:
                CPRView()
            case .seizure:
                SeizureView()
            case .choking:
                ChokingView()
            }
        }
    }
}
