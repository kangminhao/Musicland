//
//  Haptics.swift
//  MusicLand
//
//  Created by 康明浩 on 2023/5/3.
//

import SwiftUI

public class Haptics {
    static private let shared = Haptics()
    private let softHammer = UIImpactFeedbackGenerator(style: .soft)
    private let hardHammer = UIImpactFeedbackGenerator(style: .light)
    
    private init() {
        softHammer.prepare()
        hardHammer.prepare()
    }
    
    public static func softRoll(_ intensity: CGFloat = 0.9) {
        shared.softHammer.impactOccurred(intensity: intensity)
    }
    public static func hit(_ intensity: CGFloat = 0.9) {
        shared.hardHammer.impactOccurred(intensity: intensity)
    }
}
