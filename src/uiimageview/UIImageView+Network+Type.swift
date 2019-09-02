import UIKit
/**
 * Typalias and default
 */
 extension UIImageView {
   public typealias OnError = (UIImage.IMGError?) -> Void
   public static var defaultErrorHandler: OnError = { err in
      Swift.print("img error:  \(String(describing: err))")
   }
}
