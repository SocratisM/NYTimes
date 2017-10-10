//
//  ImageCachable.swift
//  NYTimes
//
//  Created by Socratis on  03/10/2017.
//


import Foundation
import UIKit

//MARK: Load image from url and cache
protocol ImageCachable {}
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView: ImageCachable {}

extension ImageCachable where Self: UIImageView
{
	typealias SuccessCompletion = (UIImage) -> ()
	
	func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?, completion: @escaping SuccessCompletion)
	{
		self.image = nil
		if let cachedImage = imageCache.object(forKey: NSString(string: URLString))
		{
			DispatchQueue.main.async
				{
					self.image = cachedImage
					completion(cachedImage)
			}
			return
		}
		
		self.image = placeHolder
		
		if let url = URL(string: URLString)
		{
			URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
				
				//debugPring("RESPONSE: \(response)")
				guard let httpResponse = response as? HTTPURLResponse else
				{
					return
				}
				if httpResponse.statusCode == 200
				{
					if let data = data
					{
						if let downloadedImage = UIImage(data: data)
						{
							imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
							DispatchQueue.main.async
								{
									self.image = downloadedImage
									completion(downloadedImage)
							}
						}
					}
				} else
				{
					self.image = placeHolder
				}
			}).resume()
		} else
		{
			self.image = placeHolder
		}
	}
}
