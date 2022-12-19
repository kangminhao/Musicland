import SwiftUI

public struct BlurView: UIViewRepresentable {
    
    public init(style: UIBlurEffect.Style = .regular) {
        self.style = style
    }
    
    let style: UIBlurEffect.Style
    
    public func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {}
}

public class Haptics {
    
    static private let shared = Haptics()
    private let softHammer = UIImpactFeedbackGenerator(style: .soft)
    private let hardHammer = UIImpactFeedbackGenerator(style: .light)
    private init() {
        softHammer.prepare()
        hardHammer.prepare()
    }
    
    // Public
    public static func softRoll(_ intensity: CGFloat = 0.9) {
        shared.softHammer.impactOccurred(intensity: intensity)
    }
    public static func hit(_ intensity: CGFloat = 0.9) {
        shared.hardHammer.impactOccurred(intensity: intensity)
    }
}
