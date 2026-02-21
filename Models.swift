import SwiftUI

enum EmergencyType: String, CaseIterable, Identifiable {
    case panicAttack = "Panic Attack"
    case cpr = "CPR"
    case seizure = "Seizure"
    case choking = "Choking"
    
    var id: String { self.rawValue }
    
    var iconName: String {
        switch self {
        case .panicAttack: return "wind"
        case .cpr: return "heart.fill"
        case .seizure: return "exclamationmark.triangle.fill"
        case .choking: return "figure.stand"
        }
    }
    
    var color: Color {
        switch self {
        case .panicAttack: return Theme.accentTeal
        case .cpr: return Theme.warningRed
        case .seizure: return Theme.warningRed
        case .choking: return Theme.warningRed
        }
    }
}

struct EmergencyStep: Identifiable {
    let id = UUID()
    let text: String
    let iconName: String
}

// Pre-defined static data sources for offline-first capabilities
struct EmergencyData {
    static let cprSteps: [EmergencyStep] = [
        EmergencyStep(text: "Check for responsiveness. Tap the shoulder and shout 'Are you okay?'", iconName: "person.fill.questionmark"),
        EmergencyStep(text: "Call emergency services immediately (911/112).", iconName: "phone.circle.fill"),
        EmergencyStep(text: "Place the heel of one hand on the center of the chest.", iconName: "hand.raised.fill"),
        EmergencyStep(text: "Place your other hand on top and interlock your fingers.", iconName: "hands.sparkles.fill"),
        EmergencyStep(text: "Push hard and fast. About 2 inches deep, 100-120 beats per minute.", iconName: "waveform.path.ecg")
    ]
    
    static let chokingSteps: [EmergencyStep] = [
        EmergencyStep(text: "Ask 'Are you choking?' If they cannot speak or cough, act immediately.", iconName: "exclamationmark.bubble.fill"),
        EmergencyStep(text: "Give 5 back blows between the shoulder blades with the heel of your hand.", iconName: "hand.raised.fill"),
        EmergencyStep(text: "If still choking, give 5 abdominal thrusts (Heimlich maneuver).", iconName: "figure.walk"),
        EmergencyStep(text: "Alternate 5 back blows and 5 abdominal thrusts until the object is clear.", iconName: "arrow.2.squarepath")
    ]
    
    static let seizureSteps: [EmergencyStep] = [
        EmergencyStep(text: "Stay calm and gently guide the person to the floor.", iconName: "figure.fall"),
        EmergencyStep(text: "Clear the area of hard or sharp objects to prevent injury.", iconName: "clear.fill"),
        EmergencyStep(text: "Place something soft under their head.", iconName: "bed.double.fill"),
        EmergencyStep(text: "Do NOT hold them down or put anything in their mouth.", iconName: "hand.raised.slash.fill"),
        EmergencyStep(text: "Roll them onto their side once the shaking stops, and time the seizure.", iconName: "arrow.turn.down.right")
    ]
    
    static let panicAttackSteps: [EmergencyStep] = [
        EmergencyStep(text: "You are safe. This will pass.", iconName: "shield.fill"),
        EmergencyStep(text: "Breathe in slowly through your nose.", iconName: "arrow.down.circle"),
        EmergencyStep(text: "Hold your breath for a moment.", iconName: "pause.circle"),
        EmergencyStep(text: "Exhale slowly through your mouth.", iconName: "arrow.up.circle"),
        EmergencyStep(text: "Let's breathe together.", iconName: "wind")
    ]
}
