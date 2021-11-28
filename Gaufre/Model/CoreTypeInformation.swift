//
//  CoreTypeInformation.swift
//  Gaufre
//
//  Created by MacBook Pro on 2021/11/28.
//

import Foundation
import DeviceHardware

// MARK: - Core Type
enum CoreType: String {
    /// efficiency core
    case efficiency = "Efficiency"
    /// performance core
    case performance = "Performance"
    /// not efficency / performance core (all same type core)
    case plain = ""
}

// MARK: - Apple Silicon for iPhone, iPad, iPod touch and Mac
enum AppleSilicon: String {
    // A Series
    case A4 = "Apple A4"
    case A5 = "Apple A5"
    case A5X = "Apple A5X"
    case A6 = "Apple A6"
    case A6X = "Apple A6X"
    case A7 = "Apple A7"
    case A8 = "Apple A8"
    case A8X = "Apple A8X"
    case A9 = "Apple A9"
    case A9X = "Apple A9X"
    case A10 = "Apple A10 Fusion"
    case A10X = "Apple A10X Fusion"
    case A11 = "Apple A11 Bionic"
    case A12 = "Apple A12 Bionic"
    case A12X = "Apple A12X Bionic"
    case A12Z = "Apple A12Z Bionic"
    case A13 = "Apple A13 Bionic"
    case A14 = "Apple A14 Bionic"
    case A15 = "Apple A15 Bionic"
    
    // M Seris
    case M1 = "Apple M1"
    case M1Pro = "Apple M1 Pro"
    case M1Max = "Apple M1 Max"
}

// MARK: - Obtain core type information
struct CoreTypeInformation {
    private let deviceHardware: MacDeviceHardware
    let coreTypes: [CoreType]
    
    init() {
        deviceHardware = MacDeviceHardware.deviceHardware
        let processorName = deviceHardware.processorName
        
        print("\(deviceHardware.processorCount)-core \(processorName)")
        
        if let chip = AppleSilicon(rawValue: processorName) {
            let efficiencyCores: Int
            let performanceCores: Int
            
            switch chip {
            case .A11:
                efficiencyCores = 4
                performanceCores = 2
            case .A12:
                efficiencyCores = 4
                performanceCores = 2
            case .A12X, .A12Z:
                efficiencyCores = 4
                performanceCores = 4
            case .A13:
                efficiencyCores = 4
                performanceCores = 2
            case .A14:
                efficiencyCores = 4
                performanceCores = 2
            case .A15:
                efficiencyCores = 4
                performanceCores = 2
            case .M1:
                efficiencyCores = 4
                performanceCores = 4
            case .M1Pro:
                efficiencyCores = 2
                performanceCores = deviceHardware.processorCount - efficiencyCores
            case .M1Max:
                efficiencyCores = 2
                performanceCores = 8
            default:
                // Not big.LITTLE
                efficiencyCores = 0
                performanceCores = 0
            }
            
            if efficiencyCores == 0 && performanceCores == 0 {
                // Not big.LITTLE
                coreTypes = Array(repeating: CoreType.plain, count: deviceHardware.processorCount)
            } else {
                // big.LITTLE
                coreTypes = Array(repeating: CoreType.efficiency, count: efficiencyCores) + Array(repeating: CoreType.performance, count: performanceCores)
            }
        } else {
            coreTypes = Array(repeating: CoreType.plain, count: deviceHardware.processorCount)
        }
    }
}
