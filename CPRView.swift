import SwiftUI

struct CPRView: View {
    @Environment(\.dismiss) var dismiss
    @State private var stepIndex = 0
    let steps = EmergencyData.cprSteps
    
    // Optional Metronome for CPR (100-120 BPM)
    @State private var isMetronomeActive = false
    @State private var metronomeScale: CGFloat = 1.0
    let timer = Timer.publish(every: 0.55, on: .main, in: .common).autoconnect() // ~109 BPM
    
    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            
            VStack {
                HStack {
                    CloseButton(action: { dismiss() })
                    Spacer()
                    if stepIndex == steps.count - 1 {
                        Button(action: {
                            isMetronomeActive.toggle()
                        }) {
                            HStack {
                                Image(systemName: isMetronomeActive ? "metronome.fill" : "metronome")
                                Text(isMetronomeActive ? "Stop Pace" : "Start Pace")
                            }
                            .font(.headline)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Theme.surface)
                            .foregroundColor(Theme.warningRed)
                            .cornerRadius(20)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                
                ZStack {
                    StepViewLayout(
                        step: steps[stepIndex],
                        stepIndex: stepIndex,
                        totalSteps: steps.count,
                        accentColor: Theme.warningRed,
                        onNext: {
                            if stepIndex < steps.count - 1 {
                                withAnimation {
                                    stepIndex += 1
                                }
                            } else {
                                dismiss()
                            }
                        },
                        onPrevious: stepIndex > 0 ? {
                            withAnimation {
                                stepIndex -= 1
                            }
                        } : nil
                    )
                    
                    if isMetronomeActive && stepIndex == steps.count - 1 {
                        VStack {
                            Spacer()
                            Circle()
                                .fill(Theme.warningRed.opacity(0.3))
                                .frame(width: 300, height: 300)
                                .scaleEffect(metronomeScale)
                                .animation(Animation.easeInOut(duration: 0.25).repeatForever(autoreverses: true), value: metronomeScale)
                                .onReceive(timer) { _ in
                                    metronomeScale = metronomeScale == 1.0 ? 1.2 : 1.0
                                    // Optional: haptic feedback could be added here
                                    let impact = UIImpactFeedbackGenerator(style: .heavy)
                                    impact.impactOccurred()
                                }
                                .allowsHitTesting(false) // So it doesn't block buttons
                                .offset(y: -50)
                            Spacer()
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onDisappear {
            isMetronomeActive = false
        }
    }
}
