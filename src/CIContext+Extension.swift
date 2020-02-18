import Foundation
import QuartzCore
import CoreImage

#if os(iOS)
extension CIContext {
   /**
    * ⚠️️ Untested ⚠️️ Could stop the mem leaking that happens when converting to cgimg
    * - Fixme: ⚠️️ get rid of forced unwraps
    * - Note: ref https://stackoverflow.com/a/32686370/5389500
    */
   func cgImg(ciImage: CIImage, from fromRect: CGRect) -> CGImage {
      let width: Int = .init(fromRect.width)
      let height: Int = .init(fromRect.height)
      let rawData = UnsafeMutablePointer<UInt8>.allocate(capacity: width * height * 4)
      render(ciImage, toBitmap: rawData, rowBytes: width * 4, bounds: fromRect, format: .RGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())
      let dataProvider = CGDataProvider(dataInfo: nil, data: rawData, size: height * width * 4) { _, data, _ in data.deallocate() }
      return CGImage(width: width, height: height, bitsPerComponent: 8, bitsPerPixel: 32, bytesPerRow: width * 4, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue), provider: dataProvider!, decode: nil, shouldInterpolate: false, intent: .defaultIntent)!
   }
}
#endif
