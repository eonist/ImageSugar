

#if os(OSX)
import AppKit.NSView

#else
import UIKit.UIView

public extension UIView {
    /**
     * Returns color for point in UIView
     */
    public func color(point:CGPoint) -> UIColor {
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo.init(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)//fromRaw()!

        var pixelData:[UInt8] = [0, 0, 0, 0]

        if let context = CGContext(data: &pixelData, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) {
            context.translateBy(x: -point.x, y: -point.y)
            self.layer.render(in: context)
        }

        let red:CGFloat = CGFloat(pixelData[0])/CGFloat(255.0)
        let green:CGFloat = CGFloat(pixelData[1])/CGFloat(255.0)
        let blue:CGFloat = CGFloat(pixelData[2])/CGFloat(255.0)
        let alpha:CGFloat = CGFloat(pixelData[3])/CGFloat(255.0)

        let color:UIColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    /**
     * let resizedImage = image.resize(to: CGSize(width: 50, height: 50))
     */
    public func resize(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
         draw(CGRect(origin: .zero, size: size))
        }
    }
}

#endif

