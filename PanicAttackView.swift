import SwiftUI

struct PanicAttackView: View {
    @Environment(\.dismiss) var dismiss
    @State private var stepIndex = 0
    let steps = EmergencyData.panicAttackSteps
    
    // Breathing Animation State
    @State private var isBreathingIn = false
    
    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Theme.surface)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                
                ZStack {
                    StepViewLayout(
                        step: steps[stepIndex],
                        stepIndex: stepIndex,
                        totalSteps: steps.count,
                        accentColor: Theme.accentTeal,
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
                    
                    // Show continuous breathing guide on the last step
                    if stepIndex == steps.count - 1 {
                        VStack {
                            Spacer()
                            ZStack {
                                Circle()
                                    .stroke(Theme.accentTeal.opacity(0.3), lineWidth: 4)
                                    .frame(width: 250, height: 250)
                                
                                Circle()
                                    .fill(Theme.accentTeal.opacity(0.2))
                                    .frame(width: 250, height: 250)
                                    .scaleEffect(isBreathingIn ? 1.0 : 0.4)
                                
                                Text(isBreathingIn ? "Breathe In..." : "Breathe Out...")
                                    .font(.headline)
                                    .foregroundColor(Theme.accentTeal)
                                    .animation(nil, value: isBreathingIn) // Text crossfade
                            }
                            .offset(y: -50)
                            .onAppear {
                                startBreathingAnimation()
                            }
                            Spacer()
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    private func startBreathingAnimation() {
        // Simple 4-7-8 or 4-4-4 logic. Here we use a smooth 4 in, 4 out for simplicity.
        withAnimation(Animation.easeInOut(duration: 4.0).repeatForever(autoreverses: true)) {
            isBreathingIn.toggle()
        }
    }
}
