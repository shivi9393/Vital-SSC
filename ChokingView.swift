import SwiftUI

struct ChokingView: View {
    @Environment(\\.dismiss) var dismiss
    @State private var stepIndex = 0
    let steps = EmergencyData.chokingSteps
    
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
            }
        }
        .navigationBarHidden(true)
    }
}
