//
//  AKLowShelfFilter.swift
//  AudioKit
//
//  Autogenerated by scripts by Aurelius Prochazka. Do not edit directly.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

import AVFoundation

/** AudioKit version of Apple's LowShelfFilter Audio Unit */
public struct AKLowShelfFilter: AKNode {
    
    private let cd = AudioComponentDescription(
        componentType: kAudioUnitType_Effect,
        componentSubType: kAudioUnitSubType_LowShelfFilter,
        componentManufacturer: kAudioUnitManufacturer_Apple,
        componentFlags: 0,
        componentFlagsMask: 0)
    
    private var internalEffect = AVAudioUnitEffect()
    private var internalAU = AudioUnit()
    public var avAudioNode: AVAudioNode
    
    /** Cutoff Frequency (Hz) ranges from 10 to 200 (Default: 80) */
    public var cutoffFrequency: Double = 80 {
        didSet {
            if cutoffFrequency < 10 {
                cutoffFrequency = 10
            }
            if cutoffFrequency > 200 {
                cutoffFrequency = 200
            }
            AudioUnitSetParameter(
                internalAU,
                kAULowShelfParam_CutoffFrequency,
                kAudioUnitScope_Global, 0,
                Float(cutoffFrequency), 0)
        }
    }
    
    /** Gain (dB) ranges from -40 to 40 (Default: 0) */
    public var gain: Double = 0 {
        didSet {
            if gain < -40 {
                gain = -40
            }
            if gain > 40 {
                gain = 40
            }
            AudioUnitSetParameter(
                internalAU,
                kAULowShelfParam_Gain,
                kAudioUnitScope_Global, 0,
                Float(gain), 0)
        }
    }
    
    /** Initialize the low shelf filter node */
    public init(
        _ input: AKNode,
        cutoffFrequency: Double = 80,
        gain: Double = 0) {
            
            self.cutoffFrequency = cutoffFrequency
            self.gain = gain
            
            internalEffect = AVAudioUnitEffect(audioComponentDescription: cd)
            self.avAudioNode = internalEffect
            AKManager.sharedInstance.engine.attachNode(self.avAudioNode)
            AKManager.sharedInstance.engine.connect(input.avAudioNode, to: self.avAudioNode, format: AKManager.format)
            internalAU = internalEffect.audioUnit
            
            AudioUnitSetParameter(internalAU, kAULowShelfParam_CutoffFrequency, kAudioUnitScope_Global, 0, Float(cutoffFrequency), 0)
            AudioUnitSetParameter(internalAU, kAULowShelfParam_Gain, kAudioUnitScope_Global, 0, Float(gain), 0)
    }
}