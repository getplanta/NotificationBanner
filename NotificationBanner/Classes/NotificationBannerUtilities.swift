/*

 The MIT License (MIT)
 Copyright (c) 2017-2018 Dalton Hinterscher

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
 to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
 ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 */

import UIKit

class NotificationBannerUtilities: NSObject {

    class func isNotchFeaturedIPhone() -> Bool {
        let value = (activeWindow()?.safeAreaInsets.bottom ?? 0.0) > 0.0
        debugLog("isNotchFeaturedIPhone=\(value)")
        return value
    }

    class func hasDynamicIsland() -> Bool {
        let top = activeWindow()?.safeAreaInsets.top ?? 0.0
        let value = top > 50.0
        debugLog("hasDynamicIsland=\(value) safeAreaTop=\(top)")
        return value
    }

    class func isPortrait() -> Bool {
        let scene = activeWindowScene()
        let orientation = scene?.interfaceOrientation ?? .unknown
        let value = orientation.isPortrait
        debugLog("isPortrait=\(value) orientationRaw=\(orientation.rawValue) activationRaw=\(scene?.activationState.rawValue ?? -1)")
        return value
    }

    private class func debugLog(_ message: String) {
        NSLog("[NotificationBanner] \(message)")
    }

    private class func activeWindow() -> UIWindow? {
        let windows = activeWindowScene()?.windows ?? []
        return windows.first(where: { $0.isKeyWindow }) ?? windows.first
    }

    private class func activeWindowScene() -> UIWindowScene? {
        let scenes = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
        return scenes.first(where: { $0.activationState == .foregroundActive })
            ?? scenes.first
    }

}
