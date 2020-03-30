#if os(iOS)
import UIKit.UIImage
/**
 * Typealias, Error-type
 */
extension UIImage {
  public typealias DownloadComplete = (UIImage?, IMGError?) -> Void
  public enum IMGError: Error {
      case invalideWebPath
      case imageDataIsCorrupted
      case errorGettingDataFromURL
   }
}
#endif
