#if os(macOS)
import Cocoa

extension NSImage {
   /**
    * - Note: Great to use un hybrid systems, as ios has the same API
    */
   convenience init(ciImage: CIImage) {
      let rep: NSCIImageRep = .init(ciImage: ciImage)
      self.init(size: rep.size)
      self.addRepresentation(rep)
   }
   /**
    * creates cgimage from nsimage
    * - Important: ⚠️️ we use autoreleasepool{} or else there will be memory leakage
    */
   public var cgImage: CGImage? {
      autoreleasepool {
         self.cgImage(forProposedRect: nil, context: nil, hints: nil)
      }
   }
   /**
    * Converts NSImage to CIImage
    */
   public var ciImage: CIImage? {
      guard let cgImg: CGImage = self.cgImage else { Swift.print("unable to convert to cgImage"); return nil }
      let ciImg: CoreImage.CIImage? = .init(cgImage: cgImg)
      return ciImg
   }
   /**
    * Resize NSImage
    * - Ref: https://stackoverflow.com/questions/11949250/how-to-resize-nsimage
    */
   public func resize(newSize: CGSize) -> NSImage {
      let destSize: CGSize = .init(width: newSize.width, height: newSize.height)
      let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(destSize.width), pixelsHigh: Int(destSize.height), bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .calibratedRGB, bytesPerRow: 0, bitsPerPixel: 0)
      rep?.size = destSize
      NSGraphicsContext.saveGraphicsState()
      if let aRep = rep { NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: aRep) }
      self.draw(in: .init(origin: .zero, size: destSize), from: NSRect.zero, operation: NSCompositingOperation.copy, fraction: 1.0)
      NSGraphicsContext.restoreGraphicsState()
      let newImage: NSImage = .init(size: destSize)
      if let aRep = rep { newImage.addRepresentation(aRep) }
      return newImage
   }
   /**
    * ## Examples:
    * let redImage = NSImage.image(color: .red, size: .init(width: 128, height: 128))
    */
   public static func image(size: CGSize, color: NSColor, scale: CGFloat = 1.0) -> NSImage? {
      self.init(size: size)
      lockFocus()
      color.drawSwatch(in: NSRect(origin: .zero, size: size))
      unlockFocus()
   }
   /**
    * nsimage -> png
    */
   public func pngData() -> Data? {
      guard let data = tiffRepresentation, let bitmap = NSBitmapImageRep(data: data), let png = bitmap.representation(using: .png, properties: [:]) else { return nil }
      return png
   }
}
/**
 * Inverts an image (black becomes white etc)
 */
//   func invertedImage() -> Image? {
//      guard let ciImage:CIImage = self.ciImage() else {Swift.print("UIImage.invertedImage() - unable to create ciImage"); return nil}//CoreImage.CIImage(cgImage: cgImage)
//      guard let cgImage:CGImage = ciImage.invertedImage() else {Swift.print("unable to create cgImage");return nil}
//      return Image(cgImage: cgImage)
//   }

/**
 * Creates UIImage for size and color
 */
//   static func createImage(size: CGSize, color:Color) -> Image {
//      return UIGraphicsImageRenderer(size: size).image { rendererContext in
//         color.setFill()
//         rendererContext.fill(CGRect(origin: .zero, size: size))
//      }
//   }
#endif
