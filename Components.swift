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
            ForEach(0..<totalSteps, id: \.self) { index in
                Capsule()
                    .fill(index <= currentStep ? color : color.opacity(0.3))
                    .frame(height: 8)
            }
        }
        .padding(.horizontal)
    }
}

struct CloseButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "xmark")
                    .font(.system(size: 18, weight: .bold))
                Text("Close")
                    .font(.system(size: 18, weight: .semibold))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color.white.opacity(0.15))
            .cornerRadius(24)
        }
    }
}

struct StepViewLayout: View {
    let step: EmergencyStep
    let stepIndex: Int
    let totalSteps: Int
    let accentColor: Color
    var hideIcon: Bool = false
    let onNext: () -> Void
    let onPrevious: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 40) {
            StepProgressIndicator(currentStep: stepIndex, totalSteps: totalSteps, color: accentColor)
                .padding(.top, 20)
            
            Spacer()
            
            if !hideIcon {
                Image(systemName: step.iconName)
                    .font(.system(size: 120, weight: .regular))
                    .foregroundColor(accentColor)
                    .symbolRenderingMode(.hierarchical)
                    .frame(height: 160)
            }
            
            Text(step.text)
                .font(Theme.stepFont)
                .foregroundColor(Theme.textMain)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .layoutPriority(1)
            
            Spacer()
            
            HStack(spacing: 16) {
                if let onPrevious = onPrevious {
                    Button(action: onPrevious) {
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
                }
                
                Button(action: onNext) {
                    Text(stepIndex == totalSteps - 1 ? "Finish" : "Next Step")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .background(accentColor)
                        .cornerRadius(35)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .background(Theme.background.ignoresSafeArea())
    }
}
