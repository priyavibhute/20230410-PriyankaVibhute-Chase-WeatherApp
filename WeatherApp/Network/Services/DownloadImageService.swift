//
//  DownloadImageService.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 11/04/23.
//

import Foundation
import UIKit

public struct IconModel: Codable {
    public let image: Data
    
    public init(image: UIImage) {
        self.image = image.pngData() ?? Data()
    }
}

protocol DownloadImageServiceProtocol {
    func getImage(name: String, completion: @escaping (Result<WeatherIconModel, NetworkError>) -> Void)
}

class DownloadImageService: BaseService, DownloadImageServiceProtocol {
    func getImage(name: String, completion: @escaping (Result<WeatherIconModel, NetworkError>) -> Void) {
        
        guard let url = URL(string: iconBaseURL + "\(name)@2x.png") else {
            completion(.failure(.apiError))
            return
        }
        
        if let image = CacheManager.shared.get(name: url.absoluteString) {
            completion(.success(WeatherIconModel(icon: image)))
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.apiError))
                return
            }
            if let image = UIImage(data: data) {
                CacheManager.shared.add(image: image, name: url.absoluteString)
                completion(.success(WeatherIconModel(icon: image)))
            } else {
                completion(.failure(.apiError))
            }
        }.resume()
    }
}
