#if os(iOS)
import UIKit.UIImage

extension UIImage {
    /**
     * let resizedImage = image.resize(to: .init(width: 50, height: 50))
     * has fit and fill: https://github.com/haoking/SwiftyUI
     */
    public func resize(to size: CGSize) -> UIImage {
      UIGraphicsImageRenderer(size: size).image { _ in
         draw(in: CGRect(origin: .zero, size: size))
      }
    }
    /**
    * Creates UIImage for size and color
    * ## Examples:
    * let image: UIImage = UIImage.createImage(size: .init(width: 24, height: 24), color: .purple)
    */
   public static func createImage(size: CGSize, color: UIColor) -> UIImage {
      UIGraphicsImageRenderer(size: size).image { rendererContext in
         color.setFill()
         rendererContext.fill(CGRect(origin: .zero, size: size))
      }
   }
   /**
    * ## Examples:
    * someUIImage.cgImage doesn't work so we use this
    */
   public func cgImage() -> CGImage? {
      guard let ciImage = self.ciImage else { return nil }
      let context: CIContext = .init(options: nil)
      return context.createCGImage(ciImage, from: ciImage.extent)
   }

   /**
    * - Note: Sometimes uiImage.ciImage just doesn't work
    */
   public func ciImage() -> CIImage {
      guard let cgImage: CGImage = self.cgImage else { Swift.print("UIImage.ciImage() - unable to create cgimage"); fatalError("unable to return") }
      return CoreImage.CIImage(cgImage: cgImage)
   }
   /**
    * Returns a color for a point in UIImage
    * - Note: Somehow this works with retina images where scale is 2x as well
    * - Note: alternative: https://gist.github.com/giulio92/69e4f74217422154bb25d2a35d6710f8
    */
   public func getPixelColor(pos: CGPoint) -> UIColor? {
      guard let cgImage = self.cgImage() else { Swift.print("unable to get cgImage"); return nil }
      guard let dataProvider = cgImage.dataProvider else { Swift.print("unable to get dataProvider"); return nil }
      guard let pixelData: CFData = dataProvider.data else { Swift.print("unable to get cfData"); return nil }
      let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
      let pixelInfo: Int = ((Int(self.size.width * self.scale) * Int(pos.y)) + Int(pos.x)) * 4
      // Swift.print("pixelInfo:  \(pixelInfo)")
      let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
      let g = CGFloat(data[pixelInfo + 1]) / CGFloat(255.0)
      let b = CGFloat(data[pixelInfo + 2]) / CGFloat(255.0)
      let a = CGFloat(data[pixelInfo + 3]) / CGFloat(255.0)
      return UIColor(red: r, green: g, blue: b, alpha: a)
   }
   public func grayScale() {
       // see https://prograils.com/posts/grayscale-conversion-swift for solution
   }
    /**
    * Compare images
    * A more precise algo: https://stackoverflow.com/a/53958281/5389500
    * - since swift 5 you may do img == img
    */
   public func isEqualToImage(image: UIImage) -> Bool {
      self.pngData() == image.pngData()
   }
}
#endif
