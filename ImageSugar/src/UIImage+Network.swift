#if os(OSX)
import AppKit.NSImage
#else
import UIKit.UIImage
#endif
/**
 * TODO: ⚠️️ Add a way to also get response, maybe look into result?
 */
 extension UIImage{
   /**
    * get UIImage from webPath
    */
   public static func image(webPath:String, onComplete:@escaping DownloadComplete){
      guard let url = URL.init(string: webPath) else { onComplete(nil,.invalideWebPath);return}
      UIImage.downloadImage(url: url, downloadComplete: onComplete)
   }
}
/**
 * Typealias, Error-type
 */
 extension UIImage{
  public typealias DownloadComplete = (UIImage?,IMGError?) -> Void
  public enum IMGError: Error {
      case invalideWebPath
      case imageDataIsCorrupted
      case errorGettingDataFromURL
   }
}
/**
 * Helper methods
 */
 extension UIImage{
   /**
    * Assign and convert data to Image
    */
   fileprivate static func downloadImage(url: URL, downloadComplete:@escaping UIImage.DownloadComplete) {
      //        print("Download Started")
      getDataFromUrl(url: url) { data, response, error in
         guard let data = data, error == nil else { downloadComplete(nil,.errorGettingDataFromURL); return}
         Swift.print(response?.suggestedFilename ?? url.lastPathComponent)
         //            print("Download Finished")
         guard let image = UIImage(data: data) else {downloadComplete(nil,.imageDataIsCorrupted);return}
         downloadComplete(image,nil)
      }
   }
   fileprivate typealias URLQuery = (Data?, URLResponse?, Error?) -> ()
   /**
    * Get data from URL
    */
   private static func getDataFromUrl(url: URL, completion: @escaping URLQuery) {
      URLSession.shared.dataTask(with: url) { data, response, error in
         completion(data, response, error)
         }.resume()
   }
}
