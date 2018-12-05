#if os(OSX)
import AppKit.NSView

#else
import UIKit.UIImage

public extension UIImage {
    /**
     * let resizedImage = image.resize(to: CGSize(width: 50, height: 50))
     */
    public func resize(to size: CGSize) -> UIImage {
      return UIGraphicsImageRenderer(size: size).image { _ in
         draw(in:CGRect(origin: .zero, size: size))
      }
    }
}
#endif
