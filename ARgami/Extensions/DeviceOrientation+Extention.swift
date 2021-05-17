//
//  DeviceOrientation+Extention.swift
//  ARgami
//
//  Created by Solomon Chai on 2021-05-16.
//

import UIKit

extension UIDeviceOrientation {

    var imageOrientation: CGImagePropertyOrientation {
        switch self {
        case .portraitUpsideDown:
            return .left
        case .landscapeLeft:
            return .up
        case .landscapeRight:
            return .down
        case .portrait,
             .unknown,
             .faceUp,
             .faceDown:
            fallthrough
        @unknown default:
            return .right
        }
    }
}

extension UIInterfaceOrientation {
    var imageOrientation: CGImagePropertyOrientation {
        switch self {
        case .portraitUpsideDown:
            return .left
        case .landscapeLeft:
            return .up
        case .landscapeRight:
            return .down
        case .unknown,
             .portrait:
            fallthrough
        @unknown default:
            return .right
        }
    }
}
