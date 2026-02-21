import SwiftUI

struct EmergencyButton: View {
    let type: EmergencyType
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: type.iconName)
                .font(.system(size: 40))
                .foregroundColor(.white)
                .frame(width: 60)
            
            Text(type.rawValue)
                .font(Theme.titleFont)
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color.white.opacity(0.5))
        }
        .padding(24)
        .background(type.color)
        .cornerRadius(20)
    }
}

struct StepProgressIndicator: View {
    let currentStep: Int
    let totalSteps: Int
    let color: Color
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalSteps, id: \\.self) { index in
                Capsule()
                    .fill(index <= currentStep ? color : color.opacity(0.3))
                    .frame(height: 8)
            }
        }
        .padding(.horizontal)
    }
}

struct StepViewLayout: View {
    let step: EmergencyStep
    let stepIndex: Int
    let totalSteps: Int
    let accentColor: Color
    let onNext: () -> Void
    let onPrevious: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 40) {
            StepProgressIndicator(currentStep: stepIndex, totalSteps: totalSteps, color: accentColor)
                .padding(.top, 20)
            
            Spacer()
            
            Image(systemName: step.iconName)
                .font(.system(size: 120, weight: .regular))
                .foregroundColor(accentColor)
                .symbolRenderingMode(.hierarchical)
                .frame(height: 160)
            
            Text(step.text)
                .font(Theme.stepFont)
                .foregroundColor(Theme.textMain)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .layoutPriority(1)
            
            Spacer()
            
            HStack(spacing: 20) {
                if let onPrevious = onPrevious {
                    Button(action: onPrevious) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 80, height: 80)
                            .background(Theme.surface)
                            .cornerRadius(40)
                    }
                }
                
                Button(action: onNext) {
                    Text(stepIndex == totalSteps - 1 ? "Finish" : "Next Step")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .background(accentColor)
                        .cornerRadius(40)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .background(Theme.background.ignoresSafeArea())
    }
}
