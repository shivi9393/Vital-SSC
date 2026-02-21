import SwiftUI

struct PanicAttackView: View {
    @Environment(\.dismiss) var dismiss
    @State private var stepIndex = 0
    let steps = EmergencyData.panicAttackSteps
    
    // Breathing Animation State
    @State private var isBreathingIn = false
    
    private var isBreathingStep: Bool {
        stepIndex == steps.count - 1
    }
    
    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            
            VStack {
                HStack {
                    CloseButton(action: { dismiss() })
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                
                if isBreathingStep {
                    // Full breathing experience — replaces the standard step layout
                    VStack(spacing: 30) {
                        StepProgressIndicator(currentStep: stepIndex, totalSteps: steps.count, color: Theme.accentTeal)
                            .padding(.top, 20)
                        
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .stroke(Theme.accentTeal.opacity(0.3), lineWidth: 4)
                                .frame(width: 260, height: 260)
                            
                            Circle()
                                .fill(Theme.accentTeal.opacity(0.15))
                                .frame(width: 260, height: 260)
                                .scaleEffect(isBreathingIn ? 1.0 : 0.35)
                            
                            Text(isBreathingIn ? "Breathe In..." : "Breathe Out...")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(Theme.accentTeal)
                        }
                        
                        Text(steps[stepIndex].text)
                            .font(Theme.stepFont)
                            .foregroundColor(Theme.textMain)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                        
                        Spacer()
                        
                        HStack(spacing: 16) {
                            Button(action: {
                                withAnimation { stepIndex -= 1 }
                            }) {
                                HStack(spacing: 8) {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 20, weight: .bold))
                                    Text("Back")
                                        .font(.system(size: 20, weight: .bold))
                                }
                                .foregroundColor(.white)
                                .frame(height: 70)
                                .padding(.horizontal, 24)
                                .background(Color.white.opacity(0.15))
                                .cornerRadius(35)
                            }
                            
                            Button(action: { dismiss() }) {
                                Text("Finish")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 70)
                                    .background(Theme.accentTeal)
                                    .cornerRadius(35)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 40)
                    }
                    .onAppear {
                        startBreathingAnimation()
                    }
                } else {
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
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    private func startBreathingAnimation() {
        withAnimation(Animation.easeInOut(duration: 4.0).repeatForever(autoreverses: true)) {
            isBreathingIn.toggle()
        }
    }
}
